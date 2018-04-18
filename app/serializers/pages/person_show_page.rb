module Serializers
  class PersonShowPage < Page
    def initialize(person, seat_incumbencies=[], committee_memberships=[], government_incumbencies=[], opposition_incumbencies=[])
      @person = person
      @seat_incumbencies = seat_incumbencies
      @committee_memberships = committee_memberships
      @government_incumbencies = government_incumbencies
      @opposition_incumbencies = opposition_incumbencies
    end

    def title
      "#{@person.display_name} - UK Parliament"
    end

    def content
      [
          Serializers::Heading1.new(@person).to_h,
          Serializers::Subheading.new(@person).to_h,
          (Serializers::Image.new(@person).to_h if @person.image_id && @person.image_id != 'placeholder'),
          Serializers::WhenToContact.new.to_h,
          (Serializers::Contact.new(@person).to_p if @person.contact_points.any?),
          (Serializers::Roles.new(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies).to_h if @person.incumbencies.any? || @committee_memberships.any?),
          (Serializers::Timeline.new(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies).to_h if @person.incumbencies.any? || @committee_memberships.any?),
          (Serializers::RelatedLinks.new(@person).to_h if @person.weblinks? || (@person.image_id && @person.image_id != 'placeholder'))
      ]
    end

    # def subheading
    #   subheading = "Former MP" if @person.former_mp?
    #   subheading = "Former Member of the House of Lords" if @person.former_lord?
    #   subheading = "#{@person.current_party_membership.try(&:party).try(&:name)} MP for #{@person.current_seat_incumbency.constituency.name}" if @person.current_mp?
    #   subheading = "#{@person.current_party_membership.try(&:party).try(&:name)} - #{@person.statuses[:house_membership_status].join(' and ')}" if @person.current_lord?
    #   subheading
    # end
  end
end