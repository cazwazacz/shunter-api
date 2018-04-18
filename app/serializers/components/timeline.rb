module Serializers
  class Timeline < Base
    def initialize(seat_incumbencies, committee_memberships, government_incumbencies, opposition_incumbencies)
      @seat_incumbencies = seat_incumbencies
      @committee_memberships = committee_memberships
      @government_incumbencies = government_incumbencies
      @opposition_incumbencies = opposition_incumbencies
    end

    def content
      {
        "template": "timeline",
        "timeline-roles": timeline_roles
      }
    end

    def timeline_roles
      history = RoleHelper.create_role_history(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies)
      current_roles = Serializers::Roles.new(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies).current_roles
      RoleHelper.build_timeline(history, current_roles)
    end
  end
end
