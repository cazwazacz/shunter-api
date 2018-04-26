module ComponentSerializer
  class ConstituencySubheadingComponentSerializer < BaseComponentSerializer
    def initialize(constituency)
      @constituency = constituency
    end

    private

    def name
      'constituency-subheading'
    end

    def data
      "#{region}"
    end

    def region
      @constituency.regions.map { |region| region.name }.first
    end
  end
end