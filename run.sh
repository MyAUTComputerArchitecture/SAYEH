# ! /usr/bin/bash

# This file is a bash file for compiling and simulatation of SAYEH basic computer.
# Filename and entity name of each module is listed in the module_list file that exists in the root of the
# project. This bash script reads each line and give the module_name_file to the ghdl with -a tag to compile to the object file.

# Created at 3-4-2017

cd out                                            # Change the current directory to the /out

input=../module_list                              # Module file list 

# Color Constants
GREEN='\033[0;32m'                                # Green Color
RED='\033[0;31m'                                  # Red Color
NC='\033[0m'                                      # No Color

echo "I ${RED}love${NC} ${GREEN}Stack Overflow${NC}"

while read file module_name
do
  analyz_out="$(./a.out ../$file)"                # Analyz module
  evaluate_out="$(./a.out $module_name)"          # Evaluate module
  if [ -z $analyz_out ];then
    echo "${GREEN}File $file analyzed successfully.${NC}"
  else
    echo "${RED}$analyz_out${NC}"
  fi
done < "$input"