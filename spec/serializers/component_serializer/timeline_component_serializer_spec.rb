require_relative '../../rails_helper'

describe ComponentSerializer::TimelineComponentSerializer do
  let(:roles_component_serializer_instance) { double('roles_component_serializer_instance', current_roles: 'current_roles') }
  let(:roles_component_serializer_double) { double('roles_component_serializer_double', new: roles_component_serializer_instance) }
  let(:role_helper_double) { double('role_helper_double', create_role_history: '', build_timeline: 'timeline built') }

  let (:serializer) { described_class.new(1, 2, 3, 4, role_helper_double, roles_component_serializer_double) }

  context '#to_h' do
    it 'returns a hash with the name and timeline data' do
      data = {
          template: 'timeline',
          'timeline-roles': 'timeline built'
      }
      hash = { name: 'timeline', data: data }
      expect(serializer.to_h).to eq hash
    end

    it 'calls create_role_history and build_timeline on role_helper' do
      serializer.to_h
      expect(role_helper_double).to have_received(:create_role_history)
      expect(role_helper_double).to have_received(:build_timeline)
    end

    it 'calls current_roles on roles_component_serializer' do
      serializer.to_h
      expect(roles_component_serializer_instance).to have_received(:current_roles)
    end
  end
end