module IntegrationFixtureHelper
  def get_fixture(path)
    file_path = File.join(File.dirname(__FILE__), '../', 'fixtures', 'controllers', path)

    file = File.open(file_path, 'r')
    file.read
  end
end