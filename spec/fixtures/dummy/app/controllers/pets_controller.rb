# @resource Pet
# @resource_path /pets
# 
# This document describes the API for interacting with Pet resources
# 
# @authorize_with header_x_application_api_key
# 
class PetsController < ApplicationController
  # return a list of Pets
  # @response_type [Array<Pet>]
  # @parameter client_name(required) [string] The name of the client using the API
  def index
  end

  # return a Pet
  # @parameter id [integer] The ID for the Pet
  # @response_type [Pet]
  # @error_message [EmptyPet] 404 Pet not found
  # @error_message 400 Invalid ID supplied
  def show
  end

  # create a Pet
  # @parameter pet(required,body) [Pet] The pet object
  def create
  end

  # Update a Pet
  #
  # There is no path tag here nor a route in the routing table so this action
  # will not be swaggered.
  def update
  end

  def destroy
    # No docstring here so this won't be included
  end

  # This is a class method so this won't be included
  def self.a_class_method
  end

  private
  # This method is private so this won't be included
  def a_helper
  end
end
