module ComponentSerializer
  class MapComponentSerializer < BaseComponentSerializer
    def initialize(json_location)
      @json_location = json_location
    end

    private

    def name
      "map"
    end

    def data
      {
          'json_location': "#{@json_location}"
      }
    end
  end
end