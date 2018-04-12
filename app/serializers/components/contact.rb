module Serializers
  class Contact
    def initialize(object)
      @object = object
    end

    def produce_json
      {
        "template": "contact",
        "contact-points": find_contact_points
      }
    end

    def find_contact_points
      contact_points = []
      @object.try(&:current_seat_incumbency).try(&:contact_points).each do |contact_point|
        contact_points << {
          "email": contact_point.email,
          "phone": contact_point.phone_number,
          "addresses": contact_point.postal_addresses.map(&:full_address)
        }
      end
      contact_points
    end
  end
end
