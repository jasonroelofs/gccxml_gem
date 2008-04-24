require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'

PROJECT_NAME = "gccxml"
GCCXML_VERSION = "0.9"
RUBYFORGE_USERNAME = "jameskilton"

desc "Build gccxml for this system" 
task :build_gccxml => [:clean, :unpack, :build, :install] 

task :unpack do
  cd "ext" do
    sh "tar xzvf gccxml.tar.gz"
    mkdir "gccxml-build"
  end
end

task :build do
  install_path = File.expand_path(File.dirname(__FILE__))
  cd "ext/gccxml-build" do
    sh "cmake -DCMAKE_INSTALL_PREFIX:PATH=#{install_path} ../gccxml"
    sh "make"
  end
end

task :install do
  cd "ext/gccxml-build" do
    sh "make install"
  end

  sh "chmod a+x bin/*"
  sh "chmod a+rx -R share/"
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
  pkg.need_zip = true
  pkg.need_tar = true
end
