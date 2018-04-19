module PageSerializer
  class BasePageSerializer < BaseSerializer
    def initialize(person)
      @person = person
    end

    def to_h
      {
          layout: { template: 'layout' },
          components: components,
          title: title
      }
    end

    private

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

    def title
      raise StandardError, "Please use a specific page serializer"
    end
  end
end