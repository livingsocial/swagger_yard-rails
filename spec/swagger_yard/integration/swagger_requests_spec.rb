require 'spec_helper'

describe SwaggerYard::Rails::Controller do
  let(:controller) { subject.new }
  let(:session) {{}}

  before(:each) do
    controller.stubs(:session).returns(session)
  end

  it 'returns api json'
  it 'returns resource json'
end
