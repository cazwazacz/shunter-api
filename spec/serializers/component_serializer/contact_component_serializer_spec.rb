require_relative '../../rails_helper'

RSpec.describe ComponentSerializer::ContactComponentSerializer do

  let (:postal_address_1) { double('postal_address_1', full_address: 'here') }
  let (:postal_address_2) { double('postal_address_2', full_address: 'there') }

  let (:contact_point_1) {
    double(
        'contact_point_1',
        email: 'hello@email.com',
        phone_number: 123456,
        postal_addresses: [postal_address_1, postal_address_2]
    )
  }

  let (:contact_point_2) {
    double(
        'contact_point_1',
        email: 'bye@email.com',
        phone_number: 654321,
        postal_addresses: [postal_address_1, postal_address_2]
    )
  }

  let(:contact_points) {
    [
        contact_point_1,
        contact_point_2
    ]
  }
  let(:current_seat_incumbency) { double('current_seat_incumbency', contact_points: contact_points) }
  let(:object) { double('object', current_seat_incumbency: current_seat_incumbency) }
  let(:serializer) { described_class.new(object) }

  context '#to_h' do
    it 'returns a hash with the name and contact points data' do
      contact_points_data = [
          {
              email: 'hello@email.com',
              phone: 123456,
              addresses: %w{here there}
          },
          {
              email: 'bye@email.com',
              phone: 654321,
              addresses: %w{here there}
          }
      ]

      data =       {
          'template':'contact',
          'contact-points': contact_points_data
      }

      hash = { name: 'contact', data: data }

      expect(serializer.to_h).to eq hash
    end
  end
end