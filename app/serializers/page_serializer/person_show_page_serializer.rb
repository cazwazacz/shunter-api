module PageSerializer
  class PersonShowPageSerializer < PageSerializer::BasePageSerializer
    def initialize(person, seat_incumbencies=[], committee_memberships=[], government_incumbencies=[], opposition_incumbencies=[])
      @person = person
      @seat_incumbencies = seat_incumbencies
      @committee_memberships = committee_memberships
      @government_incumbencies = government_incumbencies
      @opposition_incumbencies = opposition_incumbencies
    end

    private

    def title
      "#{@person.display_name} - UK Parliament"
    end

    def content
      c = []

      c << ComponentSerializer::Heading1ComponentSerializer.new(@person).to_h
      c << ComponentSerializer::SubheadingComponentSerializer.new(@person).to_h
      c << ComponentSerializer::ImageComponentSerializer.new(@person).to_h if @person.image_id && @person.image_id != 'placeholder'
      c << ComponentSerializer::WhenToContactComponentSerializer.new.to_h
      c << ComponentSerializer::ContactComponentSerializer.new(@person).to_h if @person.current_seat_incumbency.contact_points.any?
      c << ComponentSerializer::RolesComponentSerializer.new(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies).to_h if @person.incumbencies.any? || @committee_memberships.any?
      c << ComponentSerializer::TimelineComponentSerializer.new(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies).to_h if @person.incumbencies.any? || @committee_memberships.any?
      c << ComponentSerializer::RelatedLinksComponentSerializer.new(@person).to_h if @person.weblinks? || (@person.image_id && @person.image_id != 'placeholder')

      c
    end
  end
end