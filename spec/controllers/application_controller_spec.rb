require_relative '../rails_helper'

RSpec.describe ApplicationController do

  let(:serialiser) {
    Class.new do
      def to_h
        { foo: true, bar: 'baz' }
      end
    end
  }

  let(:response) {
    Class.new do
      def content_type=(content_type); end

      def committed?; end

      def body; end
    end
  }

  controller(ApplicationController) do
    def index
      render_page(serialiser)
    end

    def response

    end
  end

  # let(:serializer) { double('serializer') }
  # let(:application) { described_class.new }

  context '#render_page' do
    # it 'calls to_h on the serializer' do
    #   # expect(serializer).to receive(:to_h)
    #   # allow(serializer).to receive(:to_h)
    #   # allow(serializer).to receive(:content_type)
    #   # application.render_page(serializer)
    # end

    xit 'returns the expected string' do
      get :index
      expect(response.body).to eq('{"foo":true,"bar":"baz"}')
    end
  end

end