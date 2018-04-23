require_relative '../../rails_helper'

RSpec.describe ComponentSerializer::RelatedLinksComponentSerializer do

  let (:person_double) {
    double('person_double',
           full_name: 'Diane Abbott',
           image_id: 123,
           personal_weblinks: [1],
           twitter_weblinks: [1])
  }
  let (:serializer) { described_class.new(person_double) }

  context '#to_h' do
    it 'returns a hash with the name and related links data if all data is available' do
      data = {}.tap do |hash|
        hash['template'] = 'related-links'
        hash['name'] = 'Diane Abbott'
        hash['website'] = [1]
        hash['twitter'] = [1]
        hash['media-url'] = '/media/123'
      end
      hash = { name: 'related-links', data: data }
      expect(serializer.to_h).to eq hash
    end

    it 'leaves out name and media-url if image_id is falsey' do
      allow(person_double).to receive(:image_id) { false }
      data = {}.tap do |hash|
        hash['template'] = 'related-links'
        hash['website'] = [1]
        hash['twitter'] = [1]
      end
      hash = { name: 'related-links', data: data }
      expect(serializer.to_h).to eq hash
    end

    it 'leaves out website if personal_weblinks is an empty array' do
      allow(person_double).to receive(:personal_weblinks) { [] }
      data = {}.tap do |hash|
        hash['template'] = 'related-links'
        hash['name'] = 'Diane Abbott'
        hash['twitter'] = [1]
        hash['media-url'] = '/media/123'
      end
      hash = { name: 'related-links', data: data }
      expect(serializer.to_h).to eq hash
    end

    it 'leaves out twitter if twitter_weblinks is an empty array' do
      allow(person_double).to receive(:twitter_weblinks) { [] }
      data = {}.tap do |hash|
        hash['template'] = 'related-links'
        hash['name'] = 'Diane Abbott'
        hash['website'] = [1]
        hash['media-url'] = '/media/123'
      end
      hash = { name: 'related-links', data: data }
      expect(serializer.to_h).to eq hash
    end
  end
end