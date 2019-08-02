RSpec.describe CucumberTestReportViewer::Parser do
  # it "has a version number" do
  #   expect(CucumberTestReportViewer::VERSION).not_to be nil
  # end

  # context "failure" do
  #   describe '.parse' do
  #     it "throw an error when provided file not exist" do
  #       expect { CucumberTestReportViewer::Parser.parse('') }.to raise_error(ArgumentError)
  #     end
  #   end
  # end

  context 'success' do
    describe '.parse' do
      it "throw an error when provided file not exist" do
        CucumberTestReportViewer::Parser.parse('spec/fixtures/elk.json')
        # expect(CucumberTestReportViewer::Parser.parse('spec/fixtures/elk.json')).to eq {}
      end
    end
  end
end