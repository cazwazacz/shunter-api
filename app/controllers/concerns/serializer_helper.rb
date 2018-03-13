module SerializerHelper
  def self.add_components(hash, options = {})
    options.each do |key, value|
      hash[:components].delete(key) if value == false
    end
    hash.to_json
  end
end
