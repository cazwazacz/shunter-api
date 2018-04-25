require_relative '../../rails_helper'

  RSpec.describe ComponentSerializer::MapComponentSerializer do
    let(:json_location) { '/123/map.json' }

    let (:serializer) { described_class.new(json_location) }

    context '#to_h' do
      it 'returns a hash with the name and data' do
        hash = {
            name: 'map',
            data: {
                'json_location': '/123/map.json'
            }
        }
        expect(serializer.to_h).to eq hash
      end
    end
  end