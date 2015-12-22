module SwaggerYard
  module Rails
    class SwaggerController < ApplicationController
      layout false

      def doc
      end

      def index
        render :json => Swagger.new.to_h
      end
    end
  end
end
