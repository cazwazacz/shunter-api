module ComponentSerializer
  class TimelineComponentSerializer < BaseComponentSerializer
    def initialize(seat_incumbencies, committee_memberships, government_incumbencies, opposition_incumbencies, role_helper = RoleHelper, roles_component_serializer = ComponentSerializer::RolesComponentSerializer)
      @seat_incumbencies = seat_incumbencies
      @committee_memberships = committee_memberships
      @government_incumbencies = government_incumbencies
      @opposition_incumbencies = opposition_incumbencies
      @role_helper = role_helper
      @roles_component_serializer = roles_component_serializer
    end

    private

    def name
      "timeline"
    end

    def data
      timeline_data
    end

    def timeline_data
      {
          "template": "timeline",
          "timeline-roles": timeline_roles
      }
    end

    def timeline_roles
      history = @role_helper.create_role_history(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies)
      current_roles = @roles_component_serializer.new(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies).current_roles
      @role_helper.build_timeline(history, current_roles)
    end
  end
end