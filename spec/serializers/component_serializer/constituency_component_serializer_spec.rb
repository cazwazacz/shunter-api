require_relative '../../rails_helper'

RSpec.describe ComponentSerializer::ConstituencyComponentSerializer do

  let (:constituency) {
    double(
        'constituency',
        name: 'Falkirk',
        graph_id: 'Eda5tpUZ',
        current_member_display_name: 'John McNally',
        current_member_party_name: 'Scottish National Party'
    )
  }
  let (:serializer) { described_class.new(constituency) }

  context '#to_h' do
    it 'returns constituency component' do
      hash = {
          'constituency_name': 'Falkirk',
          'graph_id': 'Eda5tpUZ',
          'current_member': 'John McNally',
          'party': 'Scottish National Party'
      }

      expect(serializer.to_h).to eq hash
    end
  end
end