module PageSerializer
  class ConstituencyShowPageSerializer < PageSerializer::BasePageSerializer
    def initialize(constituency, json_location, member, seat_incumbencies)
      @constituency = constituency
      @json_location = json_location
      @member = member
      @seat_incumbencies = seat_incumbencies
    end

    private

    def title
      "#{@constituency.name} - UK Parliament"
    end

    def content
      c = []

      c << ComponentSerializer::ConstituencyHeadingComponentSerializer.new(@constituency).to_h
      c << ComponentSerializer::ConstituencySubheadingComponentSerializer.new(@constituency).to_h
      c << ComponentSerializer::MapComponentSerializer.new(@json_location).to_h
      c << people_array
      c << ComponentSerializer::FormerSeatIncumbenciesComponentSerializer.new(@seat_incumbencies).to_h

      c
    end

    def people_array
      {
          name: 'people',
          data: [ComponentSerializer::PersonComponentSerializer.new(
              @member, { constituency_show_page: true, constituency_name: @constituency.name }
          ).to_h]
      }
    end
  end
end