require 'rbconfig'

# This class takes care of finding and actually calling the gccxml executable, 
# setting up certain use flags according to what was specified.
class GCCXML

  def initialize()
    @exe = find_exe.strip.chomp
    @includes = []
    @flags = []
  end

  # Add an include path for parsing
  def add_include(path)
    @includes << path
  end

  # Add extra CXXFLAGS to the command line
  def add_cxxflags(flags)
    @flags << flags
  end

  # Run gccxml on the header file(s), sending the output to the passed in
  # file.
  def parse(header_file, to_file)
    includes = @includes.flatten.uniq.map {|i| "-I#{i.chomp}"}.join(" ").chomp
    flags = @flags.flatten.join(" ").chomp
    cmd = "#{@exe} #{includes} #{flags} #{header_file} -fxml=#{to_file}"
    raise "Error executing gccxml command line: #{cmd}" unless system(cmd)
  end

  private

  def windows?
    RUBY_PLATFORM =~ /(mswin|cygwin)/
  end

  def find_exe
    ext = windows? ? ".exe" : ""
    binary = "gccxml#{ext}"

    path = File.expand_path(File.join(File.dirname(__FILE__), "bin", binary))
    path.chomp!

    if `#{path} --version 2>&1` =~ /GCC-XML/
      path
    elsif `#{binary} --version 2>&1` =~ /GCC-XML/
      binary
    else
      if File.exists?(path)
        # This is the Rubygems <= 1.1.1 bug of not setting file attributes properly
        dir = File.expand_path(File.dirname(__FILE__))
        raise "Unable to execute gccxml. Please run 'sudo chmod -R a+x #{dir}'"
      else
        raise "Unable to find gccxml executable locally or on your PATH."
      end
    end
  end

end
