module Serializers
  class Person
    def initialize(person, seat_incumbencies=[], committee_memberships=[], government_incumbencies=[], opposition_incumbencies=[], options = {})
      @person = person
      @seat_incumbencies = seat_incumbencies
      @committee_memberships = committee_memberships
      @government_incumbencies = government_incumbencies
      @opposition_incumbencies = opposition_incumbencies
      @options = options
    end

    def produce_show_json
      base_json_hash = Serializers::Base.new(@options).produce_json
      base_and_core_json_hash = produce_core_show_json(base_json_hash)
      base_and_core_and_additional_json_hash = produce_additional_show_json(base_and_core_json_hash)
      full_json_hash = Serializers::Base.new(@options).add_footer_to_json(base_and_core_and_additional_json_hash)
      full_json_hash.to_json
    end

    def produce_list_json
      json_hash = {
        "display_name": "#{@person.display_name}",
        "graph_id": "#{@person.graph_id}",
        "image_url": get_image_url,
        "role": role
      }
      json_hash.tap do |hash|
        hash["current_party"] = current_party if current_party
      end
      json_hash
    end

    private

    def get_image_url
      image_url = "https://s3-eu-west-1.amazonaws.com/web1live.pugin-website/1.7.6/images/placeholder_members_image.png"
      if @person.image_id != "placeholder"
        image_url = "https://api.parliament.uk/Live/photo/#{@person.image_id}.jpeg?crop=CU_1:1&amp;width=186&amp;quality=80"
      end
      image_url
    end

    def produce_core_show_json(json_hash)
      json_hash.tap do |hash|
        hash["layout"] = {}
        hash["layout"]["template"] = "layout"
        hash["layout"]["page_template"] = "people__show"
        hash["title"] = "#{@person.display_name} UK Parliament"
        push_to_components(hash["components"], "heading1", "#{@person.full_name}")
        push_to_components(hash["components"], "subheading", subheading)
      end
    end

    def produce_additional_show_json(json_hash)
      json_hash.tap do |hash|
        push_to_components(hash["components"], "image", (Serializers::Image.new(@person).produce_json if @person.image_id && @person.image_id != 'placeholder'))
        push_to_components(hash["components"], "when-to-contact", Serializers::WhenToContact.new.produce_json)
        push_to_components(hash["components"], "contact", (Serializers::Contact.new(@person).produce_json if @person.contact_points.any?))
        push_to_components(hash["components"], "roles", (Serializers::Roles.new(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies).produce_json if @person.incumbencies.any? || @committee_memberships.any?))
        push_to_components(hash["components"], "timeline", (Serializers::Timeline.new(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies).produce_json if @person.incumbencies.any? || @committee_memberships.any?))
        push_to_components(hash["components"], "related-links", (Serializers::RelatedLinks.new(@person).produce_json if @person.weblinks? || (@person.image_id && @person.image_id != 'placeholder')))
      end
    end

    def push_to_components(hash, name, data)
      hash << { name: name, data: data }
    end

    ## Person Helper methods
    def subheading
      subheading = "Former MP" if @person.former_mp?
      subheading = "Former Member of the House of Lords" if @person.former_lord?
      subheading = "#{@person.current_party_membership.try(&:party).try(&:name)} MP for #{@person.current_seat_incumbency.constituency.name}" if @person.current_mp?
      subheading = "#{@person.current_party_membership.try(&:party).try(&:name)} - #{@person.statuses[:house_membership_status].join(' and ')}" if @person.current_lord?
      subheading
    end

    def current_party
      current_party = nil if @person.former_mp? || @person.former_lord?
      current_party = @person.current_party_membership.try(&:party).try(&:name) if @person.current_mp? || @person.current_lord?
      current_party
    end

    def role
      role = "Former MP" if @person.former_mp?
      role = "Former Member of the House of Lords" if @person.former_lord?
      role = "MP for #{@person.current_seat_incumbency.constituency.name}" if @person.current_mp?
      role = "#{@person.statuses[:house_membership_status].join(' and ')}" if @person.current_lord?
      role
    end
  end
end
