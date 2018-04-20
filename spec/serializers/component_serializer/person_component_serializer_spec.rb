require_relative '../../rails_helper'

describe ComponentSerializer::PersonComponentSerializer do

  let(:constituency) { double('constituency', name: 'Hackney North') }
  let(:current_seat_incumbency) { double('current_seat_incumbency', constituency: constituency) }

  let(:party) { double('party', name: 'Labour') }
  let(:current_party_membership) { double('current_party_membership', party: party) }

  let(:person_double) {
    double('person_double',
           display_name: 'Diane Abbott',
           graph_id: '123',
           image_id: 321,
           former_mp?: false,
           former_lord?: false,
           current_mp?: true,
           current_lord?: false,
           current_party_membership: current_party_membership,
           current_seat_incumbency: current_seat_incumbency,
           statuses: { house_membership_status: %w{hi hello} },
    )
  }
  let (:serializer) { described_class.new(person_double) }

  context '#to_h' do
    it 'returns the complete person hash if all the data is available and person is a current MP' do
      hash = {}.tap do |hash|
        hash[:'display_name'] = 'Diane Abbott'
        hash[:'graph_id'] = '123'
        hash[:'image_url'] = 'https://api.parliament.uk/Live/photo/321.jpeg?crop=CU_1:1&amp;width=186&amp;quality=80'
        hash[:'role'] = 'MP for Hackney North'
        hash['current_party'] = 'Labour'
      end
      expect(serializer.to_h).to eq hash
    end

    it 'placeholder image url is used when the image_id is placeholder' do
      allow(person_double).to receive(:image_id) { 'placeholder' }
      placeholder_image_url = 'https://s3-eu-west-1.amazonaws.com/web1live.pugin-website/1.7.6/images/placeholder_members_image.png'
      expect(serializer.to_h[:'image_url']).to eq placeholder_image_url
    end

    it 'current_party is nil if person is a former MP' do
      allow(person_double).to receive(:former_mp?) { true }
      allow(person_double).to receive(:former_lord?) { false }
      allow(person_double).to receive(:current_mp?) { false }
      allow(person_double).to receive(:current_lord?) { false }
      expect(serializer.to_h['current_party']).to eq nil
    end

    it 'current_party is nil if person is a former Lord' do
      allow(person_double).to receive(:former_mp?) { false }
      allow(person_double).to receive(:former_lord?) { true }
      allow(person_double).to receive(:current_mp?) { false }
      allow(person_double).to receive(:current_lord?) { false }
      expect(serializer.to_h['current_party']).to eq nil
    end

    it 'current_party is returned if person is a current Lord' do
      allow(person_double).to receive(:former_mp?) { false }
      allow(person_double).to receive(:former_lord?) { false }
      allow(person_double).to receive(:current_mp?) { false }
      allow(person_double).to receive(:current_lord?) { true }
      expect(serializer.to_h['current_party']).to eq 'Labour'
    end

    it 'role is Former MP is person is former MP' do
      allow(person_double).to receive(:former_mp?) { true }
      allow(person_double).to receive(:former_lord?) { false }
      allow(person_double).to receive(:current_mp?) { false }
      allow(person_double).to receive(:current_lord?) { false }
      expect(serializer.to_h[:'role']).to eq 'Former MP'
    end

    it 'role is Former Member of the House of Lords is person is former Lord' do
      allow(person_double).to receive(:former_mp?) { false }
      allow(person_double).to receive(:former_lord?) { true }
      allow(person_double).to receive(:current_mp?) { false }
      allow(person_double).to receive(:current_lord?) { false }
      expect(serializer.to_h[:'role']).to eq 'Former Member of the House of Lords'
    end

    it 'role shows house membership statuses is person if current Lord' do
      allow(person_double).to receive(:former_mp?) { false }
      allow(person_double).to receive(:former_lord?) { false }
      allow(person_double).to receive(:current_mp?) { false }
      allow(person_double).to receive(:current_lord?) { true }
      expect(serializer.to_h[:'role']).to eq 'hi and hello'
    end
  end
end