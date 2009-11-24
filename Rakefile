require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

PROJECT_NAME = "gccxml_gem"
GCCXML_VERSION = "0.9.2"
RUBYFORGE_USERNAME = "jameskilton"

desc "Build gccxml for this system" 
task :build_gccxml => [:clean, :unpack, :build, :install] 

def make_cmd
  PLATFORM =~ /mswin/ ? "mingw32-make" : "make"
end

task :unpack do
  cd "ext" do
    sh "tar xzvf gccxml.tar.gz"
    mkdir "gccxml-build"
  end
end

task :build do
  install_path = File.expand_path(File.dirname(__FILE__))

  platform = PLATFORM =~ /mswin/ ? "-G \"MinGW Makefiles\"" : ""

  cd "ext/gccxml-build" do
    sh "cmake -DCMAKE_INSTALL_PREFIX:PATH=#{install_path} #{platform} ../gccxml"
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
task :clean => [:clobber] do
  rm_rf "ext/gccxml"
  rm_rf "ext/gccxml-build"
  rm_rf "bin"
  rm_rf "share"
end

spec = Gem::Specification.new do |s|
  s.platform = Gem::Platform::CURRENT
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

  patterns = [
    'Rakefile',
    '*.rb',
    'bin/*',
    'share/**/*'
  ]

  s.files = patterns.map {|p| Dir.glob(p) }.flatten

  s.require_paths = ['.']
end

Rake::GemPackageTask.new(spec) do |pkg|
end
