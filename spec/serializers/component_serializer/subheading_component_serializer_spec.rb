require_relative '../../rails_helper'

describe ComponentSerializer::SubheadingComponentSerializer do

  let(:party) { double('party', name: 'Great') }
  let(:current_party_membership) { double('current_party_membership', party: party) }
  let(:constituency) { double('constituency', name: 'Anything') }
  let(:current_seat_incumbency) { double('current_seat_incumbency', constituency: constituency) }
  let(:person) {
    double('person',
           current_party_membership: current_party_membership,
           current_seat_incumbency: current_seat_incumbency,
           statuses: {
               :house_membership_status => ['one', 'two']
           }
    )
  }

  let (:serializer) { described_class.new(person) }

  context '#to_h' do
    it 'returns a hash with the name and Former MP is former_mp? is true' do
      allow(person).to receive(:former_mp?) { true }
      allow(person).to receive(:former_lord?) { false }
      allow(person).to receive(:current_mp?) { false }
      allow(person).to receive(:current_lord?) { false }
      hash = { name: 'subheading', data: 'Former MP' }
      expect(serializer.to_h).to eq hash
    end

    it 'returns a hash with the name and Former MP is former_lord? is true' do
      allow(person).to receive(:former_mp?) { false }
      allow(person).to receive(:former_lord?) { true }
      allow(person).to receive(:current_mp?) { false }
      allow(person).to receive(:current_lord?) { false }
      hash = { name: 'subheading', data: 'Former Member of the House of Lords' }
      expect(serializer.to_h).to eq hash
    end

    it 'returns a hash with the name and current MP string is current_mp? is true' do
      allow(person).to receive(:former_mp?) { false }
      allow(person).to receive(:former_lord?) { false }
      allow(person).to receive(:current_mp?) { true }
      allow(person).to receive(:current_lord?) { false }
      string = 'Great MP for Anything'
      hash = { name: 'subheading', data: string }
      expect(serializer.to_h).to eq hash
    end

    it 'returns a hash with the name and current Lord string is current_lord? is true' do
      allow(person).to receive(:former_mp?) { false }
      allow(person).to receive(:former_lord?) { false }
      allow(person).to receive(:current_mp?) { false }
      allow(person).to receive(:current_lord?) { true }
      string = 'Great - one and two'
      hash = { name: 'subheading', data: string }
      expect(serializer.to_h).to eq hash
    end
  end
end