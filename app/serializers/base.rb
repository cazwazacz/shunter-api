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
        push_to_components(hash["components"], "cookie-banner", "cookie-banner")
        push_to_components(hash["components"], "top-navigation", "top-navigation")
        push_to_components(hash["components"], "banner", "banner")
        push_to_components(hash["components"], "header", "header")
        push_to_components(hash["components"], "footer", "footer")
      end
    end

    def remove_components(hash, options = {})
      options.each do |key, value|
        hash["components"].delete_if { |element| (element[:name] == key.to_s && value == false) }
      end
      hash
    end

    def push_to_components(hash, name, data)
      hash << { name: name, data: data }
    end

  end
end
