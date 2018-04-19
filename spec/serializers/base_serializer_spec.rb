require_relative '../rails_helper'

describe BaseSerializer do
  context '#to_h' do
    it 'raises an error if called' do
      expect { subject.to_h }.to raise_error(StandardError, "You must implement #content.")
    end
  end
end