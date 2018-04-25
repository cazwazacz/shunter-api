require_relative '../../rails_helper'

RSpec.describe ComponentSerializer::ConstituencySubheadingComponentSerializer do
  let(:region) { double('region', name: 'South West') }
  let(:constituency) { double('constituency', regions: [region]) }

  let (:serializer) { described_class.new(constituency) }

  context '#to_h' do
    it 'returns a hash with the name and data' do
      hash = {
          name: 'constituency-subheading',
          data: 'South West'
      }
      expect(serializer.to_h).to eq hash
    end
  end
end