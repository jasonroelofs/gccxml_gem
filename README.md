GCC-XML in Gem form
===================

**Deprecated Gem**

GCCXML used to be quite difficult to install on all systems, but with the advent of tools like homebrew on Mac, it's much easier to build, install, and use GCCXML on all platforms.

This gem is no longer required, and the functionality has been merged into [rbgccxml](http://github.com/jasonroelofs/rbgccxml).

------------------

This package exists to make it easy for anyone to install the GCC-XML
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

Project page: [http://github.com/jasonroelofs/gccxml_gem](http://github.com/jasonroelofs/gccxml_gem)
