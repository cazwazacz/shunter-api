require_relative '../../rails_helper'

RSpec.describe PageSerializer::PersonShowPageSerializer do

  let(:postal_address) { double('postal_address', full_address: 'Full Address') }
  let(:contact_point) { double('contact_point', email: 'email', phone_number: 123, postal_addresses: [postal_address]) }
  let(:constituency) { double('constituency', name: 'Constituency Name') }
  let(:current_seat_incumbency) { double('current_seat_incumbency', contact_points: [contact_point], constituency: constituency) }
  let(:party) { double('party', name: 'Party Name') }
  let(:current_party_membership) { double('current_party_membership', party: party) }

  let(:person_double) {
    double(
        'person_double',
        full_name: 'Diane Abbott',
        display_name: 'Diane Abbott',
        former_mp?: false,
        former_lord?: false,
        current_mp?: true,
        current_lord?: false,
        image_id: 123,
        graph_id: 321,
        current_seat_incumbency: current_seat_incumbency,
        current_party_membership: current_party_membership,
        committee_memberships: [1],
        incumbencies: [1],
        weblinks?: true,
        personal_weblinks: [1],
        twitter_weblinks: [1]
    )
  }

  subject(:person_show_page_serializer) { described_class.new(person_double) }

  context '#to_h' do
    describe 'when all person information is available' do
      it 'initializes serializers' do
        allow(ComponentSerializer::Heading1ComponentSerializer).to receive(:new).with(person_double)
        allow(ComponentSerializer::SubheadingComponentSerializer).to receive(:new).with(person_double)
        allow(ComponentSerializer::ImageComponentSerializer).to receive(:new).with(person_double)
        allow(ComponentSerializer::WhenToContactComponentSerializer).to receive(:new)
        allow(ComponentSerializer::ContactComponentSerializer).to receive(:new).with(person_double)
        allow(ComponentSerializer::RolesComponentSerializer).to receive(:new).with([], [], [], [])
        allow(ComponentSerializer::TimelineComponentSerializer).to receive(:new).with([], [], [], [])
        allow(ComponentSerializer::RelatedLinksComponentSerializer).to receive(:new).with(person_double)

        person_show_page_serializer.to_h

        expect(ComponentSerializer::Heading1ComponentSerializer).to have_received(:new).with(person_double)
        expect(ComponentSerializer::SubheadingComponentSerializer).to have_received(:new).with(person_double)
        expect(ComponentSerializer::ImageComponentSerializer).to have_received(:new).with(person_double)
        expect(ComponentSerializer::WhenToContactComponentSerializer).to have_received(:new)
        expect(ComponentSerializer::ContactComponentSerializer).to have_received(:new).with(person_double)
        expect(ComponentSerializer::RolesComponentSerializer).to have_received(:new).with([], [], [], [])
        expect(ComponentSerializer::TimelineComponentSerializer).to have_received(:new).with([], [], [], [])
        expect(ComponentSerializer::RelatedLinksComponentSerializer).to have_received(:new).with(person_double)
      end
    end

    describe 'image component serializer is not initialized' do
      it 'if person does not have image_id' do
        allow(ComponentSerializer::ImageComponentSerializer).to receive(:new).with(person_double)
        allow(person_double).to receive(:image_id) { nil }

        person_show_page_serializer.to_h
        expect(ComponentSerializer::ImageComponentSerializer).not_to have_received(:new).with(person_double)
      end

      it 'if person has image_id that is placeholder' do
        allow(ComponentSerializer::ImageComponentSerializer).to receive(:new).with(person_double)
        allow(person_double).to receive(:image_id) { 'placeholder' }

        person_show_page_serializer.to_h
        expect(ComponentSerializer::ImageComponentSerializer).not_to have_received(:new).with(person_double)
      end
    end

    describe 'contact component serializer is not initialized' do
      it 'if contact points is an empty array' do
        allow(ComponentSerializer::ContactComponentSerializer).to receive(:new).with(person_double)
        allow(current_seat_incumbency).to receive(:contact_points) { [] }

        person_show_page_serializer.to_h
        expect(ComponentSerializer::ContactComponentSerializer).not_to have_received(:new).with(person_double)
      end
    end

    describe 'roles component serializer is not initialized' do
      it 'if incumbencies and committee_memberships are empty arrays' do
        allow(ComponentSerializer::RolesComponentSerializer).to receive(:new).with([], [], [], [])
        allow(person_double).to receive(:incumbencies) { [] }

        person_show_page_serializer.to_h
        expect(ComponentSerializer::RolesComponentSerializer).not_to have_received(:new).with([], [], [], [])
      end
    end

    describe 'timeline component serializer is not initialized' do
      it 'if incumbencies and committee memberships are empty arrays' do
        allow(ComponentSerializer::TimelineComponentSerializer).to receive(:new).with([], [], [], [])
        allow(person_double).to receive(:incumbencies) { [] }

        person_show_page_serializer.to_h
        expect(ComponentSerializer::TimelineComponentSerializer).not_to have_received(:new).with([], [], [], [])
      end
    end

    describe 'related links component serializer is not initialized' do
      it 'if person has no weblinks and they have no image_id' do
        allow(ComponentSerializer::RelatedLinksComponentSerializer).to receive(:new).with(person_double)
        allow(person_double).to receive(:weblinks?) { nil }
        allow(person_double).to receive(:image_id) { nil }

        person_show_page_serializer.to_h
        expect(ComponentSerializer::RelatedLinksComponentSerializer).not_to have_received(:new).with(person_double)
      end

      it 'if person has no weblinks and they have no image_id' do
        allow(ComponentSerializer::RelatedLinksComponentSerializer).to receive(:new).with(person_double)
        allow(person_double).to receive(:weblinks?) { nil }
        allow(person_double).to receive(:image_id) { 'placeholder' }

        person_show_page_serializer.to_h
        expect(ComponentSerializer::RelatedLinksComponentSerializer).not_to have_received(:new).with(person_double)
      end
    end
  end
end