# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.
$:.unshift(File.expand_path('lib'))

require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "acts_as_markup_extended"
    gem.summary = %Q{Represent ActiveRecord Markdown, Textile, Wiki text, RDoc columns as Markdown, Textile Wikitext, RDoc objects using various external libraries to convert to HTML. Includes markup extension methods.}
    gem.description = %Q{Represent ActiveRecord Markdown, Textile, Wiki text, RDoc columns as Markdown, Textile Wikitext, RDoc objects using various external libraries to convert to HTML. Includes markup extension methods.}
    gem.email = "mitch.marx@mdpaladin.com"
    gem.homepage = "https://github.com/mitchmarx/acts_as_markup_extended/"
    gem.authors = ["Mitch Marx"]
    gem.version = '1.0.0'
    gem.add_dependency('activesupport', '>= 2.3.2')
    gem.add_dependency('activerecord', '>= 2.3.2')
    gem.add_dependency('rdiscount', '~> 1.3')
    gem.add_dependency('wikitext', '~> 2.0')
    gem.add_dependency('RedCloth', '~> 4.2')
    gem.files =  FileList["[A-Z]*", "{lib,test}/**/*"]
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'tasks/test'
require 'tasks/rdoc'

task :test => :check_dependencies
task :default => :test
