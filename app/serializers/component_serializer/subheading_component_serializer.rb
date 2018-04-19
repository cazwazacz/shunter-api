module ComponentSerializer
  class SubheadingComponentSerializer < BaseComponentSerializer
    def initialize(person)
      @person = person
    end

    def name
      "subheading"
    end

    def data
      subheading
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