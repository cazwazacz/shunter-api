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
      {
          "cookie-banner": "cookie-banner",
          "top-navigation": "top-navigation",
          "banner": "banner",
          "header": "header"
      }
    end

    def footer
      { "footer": "footer" }
    end
  end
end