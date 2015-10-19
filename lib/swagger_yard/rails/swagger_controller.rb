module SwaggerYard
  module Rails
    class SwaggerController < ApplicationController
      layout false

      def index
        listing = resource_listing.to_h
        listing.merge!("basePath" => request.url) if listing["basePath"].blank?
        render :json => listing
      end

      def show
        declaration = resource_listing.declaration_for("/#{params[:resource]}").to_h

        declaration.merge!("basePath" => request.base_url + SwaggerYard.config.api_path) if declaration["basePath"].blank?
        render :json => declaration
      end

      private
      def resource_listing
        SwaggerYard::ResourceListing.new(::Rails.root+'app/controllers/**/*.rb', ::Rails.root+'app/models/**/*.rb')
      end
    end
  end
end
