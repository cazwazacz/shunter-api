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
      c = []

      c << Serializers::Heading1.new(@person).to_h
      c << Serializers::Subheading.new(@person).to_h
      c << Serializers::Image.new(@person).to_h if @person.image_id && @person.image_id != 'placeholder'
      c << Serializers::WhenToContact.new.to_h
      c << Serializers::Contact.new(@person).to_h if @person.contact_points.any?
      c << Serializers::Roles.new(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies).to_h if @person.incumbencies.any? || @committee_memberships.any?
      c << Serializers::Timeline.new(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies).to_h if @person.incumbencies.any? || @committee_memberships.any?
      c << Serializers::RelatedLinks.new(@person).to_h if @person.weblinks? || (@person.image_id && @person.image_id != 'placeholder')

      c
    end
  end
end