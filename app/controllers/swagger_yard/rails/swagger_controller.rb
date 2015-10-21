module SwaggerYard
  module Rails
    class SwaggerController < ApplicationController
      layout 'application'

      def doc
      end

      def index
        render :json => Swagger.new.to_h, :layout => false
      end
    end
  end
end
