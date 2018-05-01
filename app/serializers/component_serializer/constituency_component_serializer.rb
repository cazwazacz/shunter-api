module ComponentSerializer
  class ConstituencyComponentSerializer < BaseComponentSerializer
    def initialize(constituency)
      @constituency = constituency
    end

    private

    def content
      {
          current: @constituency.current?,
          constituency_hash: constituency_hash
      }
    end

    def constituency_hash
      @constituency.current? ? current_constituency_hash : former_constituency_hash
    end

    def current_constituency_hash
      {
        'constituency_name': "#{@constituency.name}",
        'graph_id': "#{@constituency.graph_id}",
        'current_member': current_member,
        'party': party
      }
    end

    def former_constituency_hash
      {
          'constituency_name': former_constituency_name,
          'graph_id': "#{@constituency.graph_id}",
          'subtitle': 'Former constituency'
      }
    end

    def former_constituency_name
      "#{@constituency.name} (#{@constituency.start_date.year} - #{@constituency.end_date.year})"
    end

    def current_member
      "#{@constituency.current_member_display_name}"
    end

    def party
      "#{@constituency.current_member_party_name}"
    end
  end
end