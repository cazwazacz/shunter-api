require_relative '../../rails_helper'

describe PageSerializer::BasePageSerializer do
  let ( :base_page_serializer ) { described_class.new(123) }

  context '#to_h' do
    it 'raises an error' do
      expect { base_page_serializer.to_h }.to raise_error(StandardError, "You must implement #content.")
    end
  end
end