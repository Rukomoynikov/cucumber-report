require 'json'
require 'slim'
require 'fileutils'

module CucumberTestReportViewer
  module Parser
    @json_tests = ''

    def self.parse(file_path = '')
      raise ArgumentError, 'Incorrect file path' if !File.exist?(file_path)

      fetch_test_file(file_path)
      content = generate_root_pages
      copy_generated_report(content)
      copy_template_files
    end

    private

    def self.fetch_test_file(file_path)
      file = File.open file_path
      @json_tests = JSON.load file
    end

    def self.generate_root_pages
      content = @json_tests.map do |test_object|
        template = Slim::Template.new File.expand_path('../../templates/test.html.slim', __FILE__ )
        content = template.render(Object.new, test_description(test_object))
        content
      end

      content
    end

    def self.copy_generated_report(content)
      layout = Slim::Template.new File.expand_path('../../templates/layout.html.slim',__FILE__ )
      test_html = layout.render { content.join('') }
      Dir.mkdir('build') if !Dir.exist?('build')
      myfile = File.new("build/test.html", "w+")
      myfile.puts(test_html)
    end

    def self.test_description(test_object)
      test = {}
      test[:name] = test_object['name']
      test[:elements] = test_object['elements'].map do |element|
        {
            keyword: element['keyword'],
            type: element['type'],
            steps: element['steps'],
            name: element['name']
        }
      end

      test
    end

    def self.copy_template_files
      FileUtils.copy_file(
          File.expand_path('../../templates/styles.css', __FILE__ ),
          'build/styles.css',
          preserve = false,
          dereference = true
      )

      FileUtils.copy_file(
          File.expand_path('../../templates/application.js', __FILE__ ),
          'build/application.js',
          preserve = false,
          dereference = true
      )
    end
  end
end
