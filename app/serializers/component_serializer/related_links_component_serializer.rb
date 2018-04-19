module ComponentSerializer
  class RelatedLinksComponentSerializer < BaseComponentSerializer
    def initialize(person)
      @person = person
    end

    private

    def name
      "related-links"
    end

    def data
      related_links_data
    end

    def related_links_data
      {}.tap do |hash|
        hash["template"] = "related-links"
        hash["name"] = @person.full_name if @person.image_id
        hash["website"] = @person.personal_weblinks if @person.personal_weblinks.any?
        hash["twitter"] = @person.twitter_weblinks if @person.twitter_weblinks.any?
        hash["media-url"] = "/media/#{@person.image_id}" if @person.image_id
      end
    end
  end
end