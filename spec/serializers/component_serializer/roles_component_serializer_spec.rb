require_relative '../../rails_helper'

describe ComponentSerializer::RolesComponentSerializer do
  let(:history) { { current: true } }
  let(:role_helper_double) { double('role_helper_double', create_role_history: history, organise_roles: 'hello') }
  let(:serializer) { described_class.new(1, 2, 3, 4, role_helper_double) }

  context '#current_roles' do
    context 'history[:current] is true' do
      it 'role_helper receives create_role_history and organise_roles' do
        serializer.to_h
        expect(role_helper_double).to have_received(:create_role_history)
        expect(role_helper_double).to have_received(:organise_roles)
      end

      it 'returns the roles data' do
        data =       {
            'template':'roles',
            'role-list': 'hello'
        }
        hash = { name: 'roles', data: data }
        expect(serializer.to_h).to eq hash
      end
    end

    context 'history[:current] is false' do
      let(:history) { { current: false } }

      it 'role_helper does not receive organise_roles if history[:current] is false' do
        serializer.to_h
        expect(role_helper_double).to have_received(:create_role_history)
        expect(role_helper_double).to_not have_received(:organise_roles)
      end
    end
  end
end