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
      {
          current: @constituency.current?,
          subheading: subheading
      }
    end

    def subheading
      @constituency.current? ? "#{region}" : "Constituency from #{@constituency.date_range}"
    end

    def region
      @constituency.regions.map { |region| region.name }.first
    end
  end
end