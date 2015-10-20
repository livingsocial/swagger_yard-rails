require 'spec_helper'

RSpec.describe "Swagger.json", :type => :request do
  before { get "/swagger/swagger.json" }

  subject { response }

  its(:code) { is_expected.to eq("200") }
end
