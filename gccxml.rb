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

  def find_exe
    ext = if PLATFORM =~ /mswin/
            ".exe"
          else
            ""
          end

    path = File.expand_path(File.join(File.dirname(__FILE__), "bin", "gccxml#{ext}"))
    path.chomp!

    if `#{path} --version 2>&1` !~ /GCC-XML/
      raise "Unable to find gccxml executable: #{path}"
    end

    path
  end

end
