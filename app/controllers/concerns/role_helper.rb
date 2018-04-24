# Namespace for role helper methods
module RoleHelper
  # Return role type as string
  # @param [String] URI string that represents the schema type of an object
  # @example "https://id.parliament.uk/schema/GovernmentIncumbency" returns "GovernmentIncumbency"
  def self.role_type(role, role_type)
    Grom::Helper.get_id(role.type) == role_type
  end

  def self.organise_roles(role_array)
    roles = []

    role_array = role_array.reverse!.group_by { |role| Grom::Helper.get_id(role.type) }

    role_array.fetch('GovernmentIncumbency', []).each do |role|
      roles << { "role-type": "Government role", "role-title": "#{role.government_position.name}", "role-dates": [role.date_range] }
    end

    role_array.fetch('OppositionIncumbency', []).each do |role|
      roles << { "role-type": "Opposition role", "role-title": "#{role.opposition_position.name}", "role-dates": [role.date_range] }
    end

    role_array.fetch('SeatIncumbency', []).each do |role|
      if role.class == GroupingHelper::GroupedObject || role&.house_of_commons?
        if role.class == GroupingHelper::GroupedObject
          first_line_start = 'MP for'
          first_line_end = "#{role.nodes[0].constituency.name}"
          first_line = "#{first_line_start} #{first_line_end}"
          roles << { "role-type": "Parliamentary role", "role-title": first_line, "role-count": "Elected #{role.nodes.count} times", "role-dates": role.nodes.map(&:date_range) }
        else
          first_line_start = 'MP for'
          first_line_end = "#{role.constituency.name}"
          first_line = "#{first_line_start} #{first_line_end}"
          roles << { "role-type": "Parliamentary role", "role-title": first_line, "role-dates": [role.date_range] }
        end
      else
        roles << { "role-type": "Parliamentary role", "role-title": "Member of the House of Lords", "role-dates": [role.date_range] }
      end
    end

    role_array.fetch('FormalBodyMembership', []).each do |role|
      roles << { "role-type": "Committee role", "role-title": "Member of the #{role.formal_body.name}", "role-dates": [role.date_range] }
    end
    roles
  end

  def self.build_timeline(history_hash, current_roles)
    timeline_roles = []
    timeline_roles << { "time-period": "Held currently", "roles": current_roles }

    history_hash[:years].keys.sort.each do |year|
      timeline_roles << { "time-period": "Held in the last #{year} years", "roles": RoleHelper.organise_roles(history_hash[:years][year]) }
    end

    timeline_roles << { "time-period": history_hash[:start].year } if history_hash[:start]
    timeline_roles
  end

  def self.create_role_history(seat_incumbencies, committee_memberships, government_incumbencies, opposition_incumbencies)
    # Only seat incumbencies, not committee roles are being grouped
    incumbencies = GroupingHelper.group(seat_incumbencies, :constituency, :graph_id)

    roles = []
    roles += incumbencies
    roles += committee_memberships.to_a
    roles += government_incumbencies.to_a
    roles += opposition_incumbencies.to_a

    HistoryHelper.reset
    HistoryHelper.add(roles)
    HistoryHelper.history
  end
end
