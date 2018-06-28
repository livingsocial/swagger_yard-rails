require 'spec_helper'

RSpec.describe "openapi.json", :type => :request do
  before { get "/swagger/openapi.json" }

  context "returns an OK response" do
    subject { response }
    its(:code) { is_expected.to eq("200") }
  end

  context "openapi model" do
    subject(:openapi) { JSON.parse(response.body) }

    its(['paths']) { are_expected.to include('/pets', '/transports', '/pets/{id}')}

    context "/pets" do
      subject { openapi['paths']['/pets'] }

      it { is_expected.to include('get', 'post') }

      its(['get']) { is_expected.to include('summary' => 'return a list of Pets')}

      its(['post']) { is_expected.to include('summary' => 'create a Pet')}

      context "update action is not documented" do
        it { is_expected.to_not include('put') }
      end
    end
  end
end
