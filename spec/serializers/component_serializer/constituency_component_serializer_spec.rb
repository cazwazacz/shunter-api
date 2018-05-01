require_relative '../../rails_helper'

RSpec.describe ComponentSerializer::ConstituencyComponentSerializer do

  let (:current_constituency) {
    double(
        'constituency',
        current?: true,
        name: 'Falkirk',
        graph_id: 'Eda5tpUZ',
        current_member_display_name: 'John McNally',
        current_member_party_name: 'Scottish National Party'
    )
  }

  let (:former_constituency) {
    double(
        'constituency',
        current?: false,
        name: 'Falkirk',
        graph_id: 'Eda5tpUZ',
        start_date: double('start_date', year: 1945),
        end_date: double('end_date', year: 2010)
    )
  }

  let (:current_constituency_component_serializer) { described_class.new(current_constituency) }
  let (:former_constituency_component_serializer) { described_class.new(former_constituency) }

  context '#to_h' do
    context 'if the constituency is current' do
      it 'returns the constituency component' do
        hash = {
            current: true,
            constituency_hash: {
              'constituency_name': 'Falkirk',
              'graph_id': 'Eda5tpUZ',
              'current_member': 'John McNally',
              'party': 'Scottish National Party'
            }
        }

        expect(current_constituency_component_serializer.to_h).to eq hash
      end
    end

    context 'if the constituency is former' do
      it 'returns the constituency component' do
        hash = {
            current: false,
            constituency_hash: {
                'constituency_name': 'Falkirk (1945 - 2010)',
                'graph_id': 'Eda5tpUZ',
                'subtitle': 'Former constituency'
            }
        }

        expect(former_constituency_component_serializer.to_h).to eq hash
      end
    end
  end
end