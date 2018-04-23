require_relative '../../rails_helper'

RSpec.describe ComponentSerializer::BaseComponentSerializer do
  context '#to_h' do
    it 'raises an error' do
      expect { subject.to_h }.to raise_error(StandardError, "You must implement #name.")
    end
  end
end