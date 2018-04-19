require_relative '../../rails_helper'

describe ComponentSerializer::Heading1ComponentSerializer do
  let(:person) { double('person', full_name: "Diane Abbott") }

  let (:serializer) { described_class.new(person) }

  context '#to_h' do
    it 'returns a hash with the name and data' do
      hash = { name: "heading1", data: "Diane Abbott" }
      expect(serializer.to_h).to eq hash
    end
  end
end