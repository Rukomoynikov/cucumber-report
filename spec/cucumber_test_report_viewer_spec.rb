RSpec.describe CucumberTestReportViewer::Parser do
  context 'success' do
    describe '.parse' do
      it "throw an error when provided file not exist" do
        CucumberTestReportViewer::Parser.parse('spec/fixtures/elk.json')
      end
    end
  end
end
