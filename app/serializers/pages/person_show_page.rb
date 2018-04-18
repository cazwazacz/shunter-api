module Serializers
  class PersonShowPage < Page
    def initialize(person, seat_incumbencies=[], committee_memberships=[], government_incumbencies=[], opposition_incumbencies=[])
      @person = person
      @seat_incumbencies = seat_incumbencies
      @committee_memberships = committee_memberships
      @government_incumbencies = government_incumbencies
      @opposition_incumbencies = opposition_incumbencies
    end

    def content
      [
          {
              name: "image",
              data: (Serializers::Image.new(@person).to_h if @person.image_id && @person.image_id != 'placeholder')
          },
          {
              name: "when-to-contact",
              data: Serializers::WhenToContact.new.to_h
          },
          {
              name: "contact",
              data: (Serializers::Contact.new(@person).to_h if @person.contact_points.any?)
          },
          {
              name: "roles",
              data: (Serializers::Roles.new(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies).to_h if @person.incumbencies.any? || @committee_memberships.any?)
          },
          {
              name: "timeline",
              data: (Serializers::Timeline.new(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies).to_h if @person.incumbencies.any? || @committee_memberships.any?)
          },
          {
              name: "related-links",
              data: (Serializers::RelatedLinks.new(@person).to_h if @person.weblinks? || (@person.image_id && @person.image_id != 'placeholder'))
          }
      ]
    end
  end
end