require 'rake/testtask'
require 'rdoc/task'
require 'rubygems/package_task'

PROJECT_NAME = "gccxml_gem"
GCCXML_VERSION = "0.9.3"
RUBYFORGE_USERNAME = "jameskilton"

desc "Build gccxml for this system"
task :build_gccxml => [:clean, :unpack, :build, :install]

def make_cmd
  RUBY_PLATFORM =~ /mswin/ ? "mingw32-make" : "make"
end

task :unpack do
  cd "ext" do
    sh "tar xzvf gccxml.tar.gz"
    mkdir "gccxml-build"
  end
end

task :build do
  install_path = File.expand_path(File.dirname(__FILE__))

  platform = RUBY_PLATFORM =~ /mswin/ ? "-G \"MinGW Makefiles\"" : ""

  cd "ext/gccxml-build" do
    sh "cmake -DCMAKE_INSTALL_PREFIX:PATH=#{install_path} -DCMAKE_BUILD_TYPE=None #{platform} ../gccxml"
    sh make_cmd
  end
end

task :install do
  cd "ext/gccxml-build" do
    sh "#{make_cmd} install"
  end

  sh "chmod a+x bin/*"
  sh "chmod -R a+rx share/"

  cd "bin" do
    `cp gccxml_cc1plus.exe gccxml_cc1plus` if File.exists?("gccxml_cc1plus.exe")
  end
end

desc "Clean up everything"
task :clean do
  rm_rf "ext/gccxml"
  rm_rf "ext/gccxml-build"
  rm_rf "bin"
  rm_rf "share"
end

base_spec = lambda do |s|
  s.name = PROJECT_NAME
  s.version = GCCXML_VERSION
  s.summary = 'Easy install for GCCXML'
  s.homepage = 'http://rbplusplus.rubyforge.org/'
  s.rubyforge_project = "rbplusplus"
  s.author = 'Jason Roelofs'
  s.email = 'jameskilton@gmail.com'

  s.description = <<-END
Because GCCXML is difficult to install on all platforms,
this binary gem is provided for ease of installing
and using RbGCCXML.
  END

  s.require_paths = ['.']
end

binary_spec = Gem::Specification.new do |s|
  base_spec.call(s)
  s.platform = Gem::Platform::CURRENT

  patterns = [
    'Rakefile',
    '*.rb',
    'bin/*',
    'share/**/*'
  ]

  s.files = patterns.map {|p| Dir.glob(p) }.flatten
end

pure_ruby_spec = Gem::Specification.new do |s|
  base_spec.call(s)
  s.platform = Gem::Platform::RUBY

  patterns = [
    'Rakefile',
    '*.rb'
  ]

  s.files = patterns.map {|p| Dir.glob(p) }.flatten
end

desc "Build binary build of the gem"
task :binary_gem do
  Gem::Builder.new(binary_spec).build
end

desc "Build pure ruby build of the gem"
task :pure_ruby_gem do
  Gem::Builder.new(pure_ruby_spec).build
end
