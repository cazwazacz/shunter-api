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
              name: "heading1",
              data: "#{@person.full_name}"
          },
          {
              name: "subheading",
              data: subheading
          },
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

    ## Person Helper methods
    def subheading
      subheading = "Former MP" if @person.former_mp?
      subheading = "Former Member of the House of Lords" if @person.former_lord?
      subheading = "#{@person.current_party_membership.try(&:party).try(&:name)} MP for #{@person.current_seat_incumbency.constituency.name}" if @person.current_mp?
      subheading = "#{@person.current_party_membership.try(&:party).try(&:name)} - #{@person.statuses[:house_membership_status].join(' and ')}" if @person.current_lord?
      subheading
    end
  end
end