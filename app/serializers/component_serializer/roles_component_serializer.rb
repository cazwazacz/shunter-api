module ComponentSerializer
  class RolesComponentSerializer < BaseComponentSerializer
    def initialize(seat_incumbencies, committee_memberships, government_incumbencies, opposition_incumbencies, role_helper)
      @seat_incumbencies = seat_incumbencies
      @committee_memberships = committee_memberships
      @government_incumbencies = government_incumbencies
      @opposition_incumbencies = opposition_incumbencies
      @role_helper = role_helper
    end

    def current_roles
      history = @role_helper.create_role_history(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies)
      @role_helper.organise_roles(history[:current]) if history[:current]
    end

    private

    def name
      "roles"
    end

    def data
      current_roles_data
    end

    def current_roles_data
      {
          "template": "roles",
          "role-list": current_roles
      }
    end
  end
end