require_relative '../../rails_helper'

  RSpec.describe PeopleController, vcr: true do
    describe 'GET show' do
      context 'with a person that exists' do
        context 'for a current mp' do
          it 'renders expected JSON output' do
            get '/people/43RHonMf'
            expected_json = get_fixture('people_controller/show/with_all_data.json')

            expect(response.body).to eq(expected_json)
          end
        end

        context 'for a former mp' do
          it 'renders expected JSON output' do
            get '/people/qkVSY7jb'
            expected_json = get_fixture('people_controller/show/former_mp.json')

            expect(response.body).to eq(expected_json)
          end
        end

        context 'for a current lord' do
          it 'renders expected JSON output' do
            get '/people/vRffoNWN'
            expected_json = get_fixture('people_controller/show/current_lord.json')

            expect(response.body).to eq(expected_json)
          end
        end

        context 'for a former lord' do
          it 'renders expected JSON output' do
            get '/people/O0giLg8A'
            expected_json = get_fixture('people_controller/show/former_lord.json')

            expect(response.body).to eq(expected_json)
          end
        end
      end
    end
  end