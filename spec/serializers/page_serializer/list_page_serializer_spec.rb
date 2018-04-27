require_relative '../../rails_helper'

RSpec.describe PageSerializer::ListPageSerializer do

  let(:active_letter) { 'C' }
  let(:letters) { %w{A C} }
  let(:object_name) { 'object name' }
  let(:klass_instance) { double('klass_instance', to_h: 'method') }
  let(:klass) { double('klass', new: klass_instance) }
  let(:objects) { [1, 2, 3] }

  let(:serializer) { described_class.new(objects, klass, object_name, letters, active_letter) }

  context '#to_h' do
    it 'creates a hash for the list page' do
      hash = {:layout=>{:template=>"layout"}, :components => [{:name=>"cookie-banner", :data=>"cookie-banner"}, {:name=>"top-navigation", :data=>"top-navigation"}, {:name=>"banner", :data=>"banner"}, {:name=>"header", :data=>"header"}, {:name=>"letter-navigation", :data=>{:object_name=>"object name", :letters=>[{:letter=>"A", :presence=>true, :active=>nil}, {:letter=>"B", :presence=>nil, :active=>nil}, {:letter=>"C", :presence=>true, :active=>true}, {:letter=>"D", :presence=>nil, :active=>nil}, {:letter=>"E", :presence=>nil, :active=>nil}, {:letter=>"F", :presence=>nil, :active=>nil}, {:letter=>"G", :presence=>nil, :active=>nil}, {:letter=>"H", :presence=>nil, :active=>nil}, {:letter=>"I", :presence=>nil, :active=>nil}, {:letter=>"J", :presence=>nil, :active=>nil}, {:letter=>"K", :presence=>nil, :active=>nil}, {:letter=>"L", :presence=>nil, :active=>nil}, {:letter=>"M", :presence=>nil, :active=>nil}, {:letter=>"N", :presence=>nil, :active=>nil}, {:letter=>"O", :presence=>nil, :active=>nil}, {:letter=>"P", :presence=>nil, :active=>nil}, {:letter=>"Q", :presence=>nil, :active=>nil}, {:letter=>"R", :presence=>nil, :active=>nil}, {:letter=>"S", :presence=>nil, :active=>nil}, {:letter=>"T", :presence=>nil, :active=>nil}, {:letter=>"U", :presence=>nil, :active=>nil}, {:letter=>"V", :presence=>nil, :active=>nil}, {:letter=>"W", :presence=>nil, :active=>nil}, {:letter=>"X", :presence=>nil, :active=>nil}, {:letter=>"Y", :presence=>nil, :active=>nil}, {:letter=>"Z", :presence=>nil, :active=>nil}]}}, {:name=>"object name", :data=>["method", "method", "method"]}, {:name=>"footer", :data=>"footer"}], :title=>"Object name A to Z showing results for C - UK Parliament"}
      expect(serializer.to_h).to eq hash
    end
  end
end