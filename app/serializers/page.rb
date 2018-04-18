module Serializers
  class Page < Base
    def initialize

    end

    def to_h
      {
          layout: { template: 'layout' },
          components: components
      }
    end

    def components
      c = []

      c << header
      c << content
      c << footer

      c.flatten
    end

    def header
      [
         { "name": "cookie-banner", data: "cookie-banner" },
         { "name": "top-navigation", data: "top-navigation" },
         { "name": "banner", data: "banner" },
         { "name": "header", data: "header" }
      ]
    end

    def footer
      { "name": "footer", data: "footer" }
    end
  end
end