require_relative '../../rails_helper'

RSpec.describe PageSerializer::ConstituencyShowPageSerializer do

  let(:seat_incumbencies) { double('seat_incumbencies') }
  let(:member) { double('member') }
  let(:json_location) { double('json_location') }
  let(:constituency) { double('constituency', name: 'Bath') }
  let(:serializer) { described_class.new(constituency, json_location, member, seat_incumbencies) }

  context '#to_h' do
    it 'initialises all serializers correctly' do
      allow(ComponentSerializer::ConstituencyHeadingComponentSerializer).to receive(:new)
      allow(ComponentSerializer::ConstituencySubheadingComponentSerializer).to receive(:new)
      allow(ComponentSerializer::MapComponentSerializer).to receive(:new)
      allow(ComponentSerializer::PersonComponentSerializer).to receive(:new)
      allow(ComponentSerializer::FormerSeatIncumbenciesComponentSerializer).to receive(:new)

      serializer.to_h

      expect(ComponentSerializer::ConstituencyHeadingComponentSerializer).to have_received(:new).with(constituency)
      expect(ComponentSerializer::ConstituencySubheadingComponentSerializer).to have_received(:new).with(constituency)
      expect(ComponentSerializer::MapComponentSerializer).to have_received(:new).with(json_location)
      options = { constituency_show_page: true, constituency_name: 'Bath' }
      expect(ComponentSerializer::PersonComponentSerializer).to have_received(:new).with(member, options)
      expect(ComponentSerializer::FormerSeatIncumbenciesComponentSerializer).to have_received(:new).with(seat_incumbencies)
    end
  end

end