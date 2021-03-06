require_relative '../../rails_helper'

RSpec.describe ConstituenciesController, vcr: true do
  describe 'GET show' do
    context 'with a constituency that exists' do
      it 'renders expected JSON output' do
        get '/constituencies/yyocmekJ'
        expected_json = get_fixture('constituencies_controller/show/with_all_data.json')

        expect(response.body).to eq(expected_json)
      end
    end
  end

  describe 'GET map' do
    context 'with a constituency that exists' do
      it 'renders expected JSON output' do
        get '/constituencies/yyocmekJ/map.json'
        expected_json = get_fixture('constituencies_controller/map/map.json')

        expect(response.body).to eq(expected_json)
      end
    end
  end

  describe 'GET index' do
    context 'for all constituencies' do
      it 'renders expected JSON output' do
        get '/constituencies'
        expected_json = get_fixture('constituencies_controller/index/index.json')

        expect(response.body).to eq(expected_json)
      end
    end
  end

  describe 'GET letters' do
    context 'for constituencies beginning with A' do
      it 'renders expected JSON output' do
        get '/constituencies/a-z/y'
        expected_json = get_fixture('constituencies_controller/letters/y.json')

        expect(response.body).to eq(expected_json)
      end
    end
  end
end