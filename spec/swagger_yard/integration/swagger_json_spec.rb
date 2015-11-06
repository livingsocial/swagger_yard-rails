require 'spec_helper'

RSpec.describe "Swagger.json", :type => :request do
  before { get "/swagger/swagger.json" }

  context "returns an OK response" do
    subject { response }
    its(:code) { is_expected.to eq("200") }
  end

  context "swagger model" do
    subject(:swagger) { JSON.parse(response.body) }

    it 'is valid' do
      errors = Apivore::Swagger.new(swagger).validate
      puts(*errors) unless errors.empty?
      expect(errors).to be_empty
    end

    its(['paths']) { are_expected.to include('/pets', '/transports', '/pets/{id}')}

    context "/pets" do
      subject { swagger['paths']['/pets'] }

      it { is_expected.to include('get', 'post') }

      its(['get']) { is_expected.to include('summary' => 'return a list of Pets')}

      its(['post']) { is_expected.to include('summary' => 'create a Pet')}

      context "update action is not swaggered" do
        it { is_expected.to_not include('put') }
      end
    end
  end
end
