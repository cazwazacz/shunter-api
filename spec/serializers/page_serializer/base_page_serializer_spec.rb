require_relative '../../rails_helper'

RSpec.describe PageSerializer::BasePageSerializer do
  let ( :base_page_serializer ) { described_class.new }

  context '#to_h' do
    it 'raises an error' do
      expect { base_page_serializer.to_h }.to raise_error(StandardError, "You must implement #content.")
    end
  end
end