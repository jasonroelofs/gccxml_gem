GCC-XML in Gem form
===================

This package is simply to make it easy for anyone to install the GCC-XML
package on their system. Binary gems are provided at

[http://rubygems.org/gems/gccxml_gem](http://rubygems.org/gems/gccxml_gem)

There are two ways of using gccxml with this gem. You can access the executable
directly via:

    /path/to/gems/gccxml_gem/bin/gccxml

Or you can use the small Ruby lib that's included

    require 'gccxml'

    gccxml = GCCXML.new

    # Add any -I flags to the command
    gccxml.add_includes(...)

    # Add any other flags to the command line
    gccxml.add_cxxflags(...)

    # You then tell GCCXML to parse a header file and tell it
    # to write the resulting XML to output_file
    gccxml.parse(path_to_header, output_file)

Misc
----

Project page: [http://github.com/jameskilton/gccxml_gem](http://github.com/jameskilton/gccxml_gem)
