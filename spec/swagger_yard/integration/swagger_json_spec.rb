require 'spec_helper'

RSpec.describe "Swagger.json", :type => :request do
  before { get "/swagger/swagger.json" }

  let(:swagger) { Apivore::Swagger.new JSON.parse(response.body) }

  subject { response }

  its(:code) { is_expected.to eq("200") }

  context "swagger model" do
    it 'is valid' do
      errors = swagger.validate
      puts *errors unless errors.empty?
      expect(errors).to be_empty
    end
  end
end
