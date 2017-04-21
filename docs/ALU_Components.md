# ALU Components


|Component Name|Function Code|
|--------------|-------------|
|AND Component|0000|
|OR Component|0001|
|XOR Component|0010|
|Camparison Component|0011|
|Shift L Component|0100|
|Shift R Component|0101|
|Add Component|0110|
|Subtract Component|0111|

<hr>

## Comparison Component

|Inputs|Outputs|
| :---: | :---: |
|INPUT1|Z_FLAG|
|INPUT2|CARRY_FLAG|

### Description

This component compares INPUT1 _( Rs in SAYEH )_ and INPUT2 _( Rd in SAYEH )_.  
If `INPUT1 < INPUT2` then CARRY\_FLAG becomes 1 and if `INPUT1 = INPUT2` then Z\_FLAG becomes 1.

### How it works?

Using a sequense of modified **BIT_COMPARATOR** components to support cascading.

## Multiplication Component

|Inputs|Outputs|
| :---: | :---: |
|INPUT1|OUTPUT|
|INPUT2||

### Description

This component multiplicate 2 numbers INPUT1 and INPUT2.

### How it works?

Using a sequense of **ADDER_SUBTRACTOR** components. This component has no process and is **generic** so can support any number sizes.

## Two's complement Component

|Inputs|Outputs|
| :---: | :---: |
|INPUT|OUTPUT|

### Description

This component performs two’s complement operation on INPUT _( Rs in SAYEH )_ and stores it in OUTPUT _( Rd in SAYEH )_.

### How it works?

Using a sequense of **FULL_ADDER** components to perform this operation.