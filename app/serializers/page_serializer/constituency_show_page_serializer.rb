module PageSerializer
  class ConstituencyShowPageSerializer < PageSerializer::BasePageSerializer
    def initialize(constituency, json_location)
      @constituency = constituency
      @json_location = json_location
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

      c
    end
  end
end