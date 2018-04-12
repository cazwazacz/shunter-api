module Serializers
  class Base

    def initialize(options)
      @options = options
    end

    def produce_json
      remove_components(base_json, @options)
    end

    def base_json
      {}.tap do |hash|
        hash["components"] = []
        hash["components"] << { "cookie-banner": "cookie-banner" }
        hash["components"] << { "top-navigation": "top-navigation" }
        hash["components"] << { "banner": "banner" }
        hash["components"] << { "header": "header" }
        hash["components"] << { "footer": "footer" }
      end
    end

    def remove_components(hash, options = {})
      options.each do |key, value|
        hash["components"].delete_if { |element| (element.values[0] == key.to_s && value == false) }
      end
      hash
    end

  end
end
