module Serializers
  class Page < Base
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

    end
  end
end