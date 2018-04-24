require_relative '../../rails_helper'

  RSpec.describe PeopleController, vcr: true do
    describe 'GET show' do
      before(:each) do
        get '/people/43RHonMf'
      end

      context 'with a person that exists' do
        context 'with all the information present' do
          it 'renders expected JSON output' do
            expected_json = get_fixture('people_controller/show/with_all_data.json')

            expect(response.body).to eq(expected_json)
          end
        end
      end
    end
  end