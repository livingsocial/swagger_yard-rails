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

          info   = yard_info(yard_obj)
          route  = find_route(info)
          method = route.verb.source.gsub(/[$^]/, '')

          raise Error, "no http method: #{info.inspect}" if method.empty?

          path = route.parts.inject(route.ast.to_s) do |p,sym|
            p.sub(sym.inspect, "{#{sym}}")
          end

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
          matching_routes = @routes.select do |r|
            if info[:route]
              r.name == info[:route]
            else
              r.defaults[:controller] == info[:controller] &&
                r.defaults[:action] == info[:action]
            end
          end

          raise Error, "too many matches: #{info.inspect}"  if matching_routes.size > 1
          raise Error, "no matching route: #{info.inspect}" if matching_routes.size < 1

          matching_routes.first
        end
      end
    end
  end
end
