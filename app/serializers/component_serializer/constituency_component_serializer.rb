module ComponentSerializer
  class ConstituencyComponentSerializer < BaseComponentSerializer
    def initialize(constituency)
      @constituency = constituency
    end

    private

    def content
      {
        'constituency_name': "#{@constituency.name}",
        'graph_id': "#{@constituency.graph_id}",
        'current_member': current_member,
        'party': party
      }
    end

    def current_member
      "#{@constituency.current_member_display_name}"
    end

    def party
      "#{@constituency.current_member_party_name}"
    end
  end
end