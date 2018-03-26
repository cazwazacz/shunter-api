module Serializers
  class Person
    def initialize(person, seat_incumbencies, committee_memberships, government_incumbencies, opposition_incumbencies, options = {})
      @person = person
      @seat_incumbencies = seat_incumbencies
      @committee_memberships = committee_memberships
      @government_incumbencies = government_incumbencies
      @opposition_incumbencies = opposition_incumbencies
      @options = options
    end

    def produce_json
      base_json_hash = Serializers::Base.new(@options).produce_json
      base_and_core_json_hash = produce_core_json(base_json_hash)
      full_json_hash = produce_additional_json(base_and_core_json_hash)
      full_json_hash.to_json
    end

    private

    def produce_core_json(json_hash)
      json_hash.tap do |hash|
        hash["layout"] = {}
        hash["layout"]["template"] = "layout"
        hash["layout"]["page_template"] = "people__show"
        hash["title"] = "#{@person.display_name} UK Parliament"
        hash["components"]["heading1"] = "#{@person.full_name}"
        hash["components"]["subheading"] = subheading
      end
    end

    def produce_additional_json(json_hash)
      json_hash.tap do |hash|
        hash["components"]["image"] = Serializers::Image.new(@person).produce_json if @person.image_id && @person.image_id != 'placeholder'
        hash["components"]["when-to-contact"] = Serializers::WhenToContact.new.produce_json
        hash["components"]["contact"] = Serializers::Contact.new(@person).produce_json if @person.contact_points.any?
        hash["components"]["roles"] = Serializers::Roles.new(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies).produce_json if @person.incumbencies.any? || @committee_memberships.any?
        hash["components"]["timeline"] = Serializers::Timeline.new(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies).produce_json if @person.incumbencies.any? || @committee_memberships.any?
        hash["components"]["related-links"] = Serializers::RelatedLinks.new(@person).produce_json if @person.weblinks? || (@person.image_id && @person.image_id != 'placeholder')
      end
    end

    def subheading
      subheading = "Former MP" if @person.former_mp?
      subheading = "Former Member of the House of Lords" if @person.former_lord?
      subheading = "#{@person.current_party_membership.try(&:party).try(&:name)} MP for #{@person.current_seat_incumbency.constituency.name}" if @person.current_mp?
      subheading = "#{@person.current_party_membership.try(&:party).try(&:name)} - #{@person.statuses[:house_membership_status].join(' and ')}" if @person.current_lord?
      subheading
    end
  end
end
