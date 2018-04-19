module ComponentSerializer
  class BaseComponentSerializer < BaseSerializer
    def content
      {
          name: name,
          data: data
      }
    end

    def name
      ""
    end

    def data
      ""
    end
  end
end