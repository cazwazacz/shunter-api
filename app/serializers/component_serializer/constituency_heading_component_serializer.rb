module ComponentSerializer
  class ConstituencyHeadingComponentSerializer < BaseComponentSerializer
    def initialize(constituency)
      @constituency = constituency
    end

    private

    def name
      "constituency-heading"
    end

    def data
      "#{@constituency.name}"
    end
  end
end