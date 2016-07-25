module SwaggerYard
  module Rails
    module RouteInspector
      def self.discovery_function
        JourneyRoutes.new(::Rails.application.routes.set)
      end

      class Error < ::RuntimeError
      end

      class JourneyRoutes
        def initialize(routes)
          @routes = routes
        end

        def call(yard_obj)
          return nil if skip_object?(yard_obj)

          info      = yard_info(yard_obj)
          route_arr = find_route(info)
          route     = route_arr.last
          method    = route.verb.source.gsub(/[$^]/, '')

          raise Error, "no http method: #{info.inspect}" if method.empty?

          path = route_arr.map do |r|
            r.parts.inject(r.ast.to_s) do |p,sym|
              p.sub(sym.inspect, "{#{sym}}")
            end
          end.join

          # FIXME: always remove format parameter?
          path = path.sub('(.{format})', '')

          [method, path]
        end

        alias_method :[], :call

        private
        def skip_object?(obj)
          obj.scope != :instance ||
            obj.visibility != :public ||
            obj.docstring.blank?
        end

        def yard_info(obj)
          {}.tap do |info|
            route_tag = obj.tags.detect {|t| t.tag_name == 'route' }
            if route_tag
              info[:route] = route_tag.text
            else
              begin
                controller, action = obj.path.split obj.sep, 2
                info[:action]      = action
                info[:controller]  = controller.constantize.controller_path
              rescue NameError => e
                raise Error, e.message
              end
            end
          end
        end

        def find_route(info)
          matching_routes = walk_routes(info)

          raise Error, "too many matches: #{info.inspect}"  if matching_routes.size > 1
          raise Error, "no matching route: #{info.inspect}" if matching_routes.size < 1

          matching_routes.first
        end

        def walk_routes(info, routes = @routes, stack = [])
          selected_routes = []

          routes.each do |r|
            if info[:route] && r.name == info[:route]
              selected_routes << stack + [r]
            elsif info[:controller] && info[:action] &&
                  r.defaults[:controller] == info[:controller] &&
                r.defaults[:action] == info[:action]
              selected_routes << stack + [r]
            elsif r.app && r.app.respond_to?(:routes)
              selected_routes += walk_routes(info, r.app.routes.set, stack + [r])
            end
          end

          selected_routes
        end
      end
    end
  end
end
