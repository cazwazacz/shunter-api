require_relative '../../rails_helper'

RSpec.describe ComponentSerializer::ConstituencyHeadingComponentSerializer do
  let(:constituency) { double('constituency', name: 'Bath') }

  let (:serializer) { described_class.new(constituency) }

  context '#to_h' do
    it 'returns a hash with the name and data' do
      hash = {
          name: 'constituency-heading',
          data: 'Bath'
      }
      expect(serializer.to_h).to eq hash
    end
  end
end