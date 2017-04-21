# Extra features list

Extra features implemented in this project:

## Whole project

* Adder and subtractor embedded in one module
* All modules in ALU are **structural** and has no process
* Control unit waits for memory to be ready in operation fetchnig
* All modules are **generic**, so the words sizes can be changed.

## Optional components

* XOR module
* Two's complement module
* Multiplication module
* Shift-Right module
* Port manager

## Others

* We have 2 bash files, that performs directory support to ghdl compiler, which compiles each component that are listed in _module\_list_ file and then runs the _test bench_. These bashes are supported in Linux and MacOS.