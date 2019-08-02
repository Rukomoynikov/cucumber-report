require 'json'
require 'slim'
require 'fileutils'

module CucumberTestReportViewer
  module Parser
    @json_tests = ''

    def self.parse(file_path = '')
      raise ArgumentError, 'Incorrect file path' if !File.exist?(file_path)

      fetch_file(file_path)
      generate_root_pages
    end

    private

    def self.fetch_file(file_path)
      file = File.open file_path
      @json_tests = JSON.load file
    end

    def self.generate_root_pages
      layout = Slim::Template.new 'lib/templates/layout.html.slim'
      
      content = @json_tests.map do |test_object|
        content = Slim::Template.new('lib/templates/test.html.slim').render(Object.new, test_description(test_object))
        content
      end

      test_html = layout.render { content.join('') }

      Dir.mkdir('build') if !Dir.exist?('build')
      

      myfile = File.new("build/test.html", "w+")
      myfile.puts(test_html)
      FileUtils.copy_file('lib/templates/styles.css', 'build/styles.css', preserve = false, dereference = true)
    end

    def self.test_description(test_object)
      test = {}
      test[:name] = test_object['name']
      test[:elements] = test_object['elements'].map do |element|
        {
          keyword: element['keyword'],
          type: element['type'],
          steps: element['steps']
        }
      end

      test
    end
  end
end
