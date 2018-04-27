require_relative '../rails_helper'

RSpec.describe ApplicationController do

  let(:serializer) { double('serializer') }
  let(:response) { double('response', headers: {}) }

  context '#render_page' do
    it 'calls the serializer\'s #to_h method and sets the required response headers' do
      allow(subject).to receive(:render)
      allow(serializer).to receive(:to_h)

      subject.render_page(serializer, response)

      headers = {}
      headers['Content-Type'] = 'application/x-shunter+json'

      expect(response.headers).to eq headers
      expect(subject).to have_received(:render).with(json: serializer.to_h)
    end
  end

end