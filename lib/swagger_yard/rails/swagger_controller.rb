module SwaggerYard
  module Rails
    class SwaggerController < ApplicationController
      layout 'application'

      def doc
      end

      def index
        if params[:version] == "2.0"
          render :json => {}, :layout => false
        else
          listing = resource_listing.to_h
          listing.merge!("basePath" => request.url) if listing["basePath"].blank?
          render :json => listing, :layout => false
        end
      end

      def show
        declaration = resource_listing.declaration_for("/#{params[:resource]}").to_h

        declaration.merge!("basePath" => request.base_url + SwaggerYard.config.api_path) if declaration["basePath"].blank?
        render :json => declaration, :layout => false
      end

      private
      def resource_listing
        SwaggerYard::ResourceListing.all
      end
    end
  end
end
