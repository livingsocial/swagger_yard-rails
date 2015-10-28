require 'spec_helper'

RSpec.describe SwaggerYard::Rails::RouteInspector do
  let(:routes) {
    [stub(defaults: { controller: 'foo', action: 'index'},
          name: nil,
          ast: '/foo(.:format)',
          verb: /^GET$/,
          parts: [:format]),
     stub(defaults: { controller: 'pets', action: 'index' },
          name: nil,
          ast: '/pets(.:format)',
          verb: /^GET$/,
          parts: [:format]),
    stub(defaults: { controller: 'transports', action: 'hello' },
          name: 'hello',
          ast: '/transports/hello(.:format)',
          verb: /^GET$/,
          parts: [:format]),
    stub(defaults: { controller: 'transports', action: 'greeting' },
          name: nil,
          ast: '/transports/greeting(.:format)',
          verb: //,
          parts: [:format])]
  }
  let(:pets_index_obj) { stub(tags: [], path: 'PetsController#index', sep: '#') }
  let(:hello_obj)      { stub(tags: [stub(tag_name: 'route', text: 'hello')]) }
  let(:greeting_obj)   { stub(tags: [], path: 'TransportsController#greeting', sep: '#') }
  let(:missing_obj)    { stub(tags: [], path: 'UnknownController#missing', sep: '#') }

  subject { described_class::JourneyRoutes.new routes }

  it 'looks up the route in the router' do
    expect(subject.call(pets_index_obj)).to eq(["GET", "/pets"])
  end

  it 'looks up a @route by name' do
    expect(subject.call(hello_obj)).to eq(["GET", "/transports/hello"])
  end

  it 'raises an error when no HTTP verb is specified' do
    expect do
      subject.call(greeting_obj)
    end.to raise_error(described_class::Error)
  end

  it 'raises an error when no route is found' do
    expect do
      subject.call(missing_obj)
    end.to raise_error(described_class::Error)
  end
end
