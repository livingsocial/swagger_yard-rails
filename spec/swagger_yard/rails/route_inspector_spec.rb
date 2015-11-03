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

  let(:obj_defaults)   { { scope: :instance, visibility: :public,
                           tags: [], sep: '#', docstring: stub(blank?: false) } }

  let(:pets_index_obj) { stub(obj_defaults.merge path: 'PetsController#index') }
  let(:hello_obj)      { stub(obj_defaults.merge tags: [stub(tag_name: 'route', text: 'hello')]) }
  let(:greeting_obj)   { stub(obj_defaults.merge path: 'TransportsController#greeting') }
  let(:missing_obj)    { stub(obj_defaults.merge path: 'UnknownController#missing') }

  let(:private_obj)      { stub(obj_defaults.merge visibility: :private) }
  let(:class_method_obj) { stub(obj_defaults.merge scope: :class) }
  let(:blank_obj)        { stub(obj_defaults.merge docstring: stub(blank?: true)) }

  subject { described_class::JourneyRoutes.new routes }

  it 'looks up the route in the router' do
    expect(subject.call(pets_index_obj)).to eq(["GET", "/pets"])
  end

  it 'looks up a @route by name' do
    expect(subject.call(hello_obj)).to eq(["GET", "/transports/hello"])
  end

  it 'skips private methods' do
    expect(subject.call(private_obj)).to be_nil
  end

  it 'skips class methods' do
    expect(subject.call(class_method_obj)).to be_nil
  end

  it 'skips blank docstrings' do
    expect(subject.call(blank_obj)).to be_nil
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
