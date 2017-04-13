# ! /usr/bin/bash

# This file is a bash file for compiling and simulatation of SAYEH basic computer.
# Filename and entity name of each module is listed in the module_list file that exists in the root of the
# project. This bash script reads each line and give the module_name_file to the ghdl with -a tag to compile to the object file.

# Created at 3-4-2017

cd out  	                                          # Change the current directory to the /out

y | rm *						# Removing all last generated copiled files
