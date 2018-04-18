module Serializers
  class Roles < Base
    def initialize(seat_incumbencies, committee_memberships, government_incumbencies, opposition_incumbencies)
      @seat_incumbencies = seat_incumbencies
      @committee_memberships = committee_memberships
      @government_incumbencies = government_incumbencies
      @opposition_incumbencies = opposition_incumbencies
    end

    def content
      {
        "template": "roles",
        "role-list": current_roles
      }
    end

    def current_roles
      history = RoleHelper.create_role_history(@seat_incumbencies, @committee_memberships, @government_incumbencies, @opposition_incumbencies)
      RoleHelper.organise_roles(history[:current]) if history[:current]
    end
  end
end
