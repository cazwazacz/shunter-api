module ComponentSerializer
  class FormerSeatIncumbenciesComponentSerializer < BaseComponentSerializer
    def initialize(seat_incumbencies)
      @seat_incumbencies = seat_incumbencies
    end

    private

    def name
      'former-seat-incumbencies'
    end

    def data
      former_seat_incumbencies
    end

    def former_seat_incumbencies
      @seat_incumbencies.map do |seat_incumbency|
        if !seat_incumbency.current?
          {
            member_name: seat_incumbency.member.display_name,
            graph_id: seat_incumbency.member.graph_id,
            date_range: seat_incumbency.date_range
          }
        end
      end
    end
  end
end