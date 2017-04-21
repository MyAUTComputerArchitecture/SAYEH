# Instruction

## Instruction Naming protocol

Every instruction has 16 bits or 8 bits. 16 bit instructions is called IMMEDIATE INSTRUCTIONS and the others are NON-IMMEDIATE INSTRUCTIONS.

### IMMEDIATE INSTRUCTIONS

These instructions are a formation like this:

|Opcode|Destination register id|Op helper code|Immediate value|
|--|--|--|--|
|4 bit|2 bit|2 bit|8 bit|

### NON IMMEDIATE INSTRUCTIONS

These instructions have two formations:

|Opcode|Destination register ID|Source register ID|
|--|--|--|
|4 bit|2 bit|2 bit|

|Opcode|Opcode Helper 1|Opcode Helper 2|
|--|--|--|
|4 bit|2 bit|2 bit|

Also non immmediate instructions are grouped into these:

* **No operand instructions** : Are instructions that need no operands like : `nop`, `hlt`, `szf`, `czf`, `scf`, `ccf`, `cwp` that need one clock for execution. Their executation state name is EXEC_NOI.

* **Operand needed instructions** : 16 bit instructions that need operands.

|Instruction Assembly|Instruction code|Instruction Group|Operand Group|
|:---:|:---:|:---:|:---:|
|`nop`|0000-00-00|Zeroer|No operand|
|`hlt`|0000-00-01|Zeroer|No operand|
|`szf`|0000-00-10|Zeroer|No operand|
|`czf`|0000-00-11|Zeroer|No operand|
|`scf`|0000-00-00|ALU-Ins|No operand|
|`ccf`|0000-00-00|ALU-Ins|No operand|
|`cwp`|0000-00-00|ALU-Ins|No operand|
|`mvr`|0000-00-00|ALU-Ins|No operand|
|`lda`|0000-00-00|ALU-Ins|No operand|
|`sta`|0000-00-00|ALU-Ins|No operand|
|`inp`|0000-00-00|ALU-Ins|No operand|
|`oup`|0000-00-00|ALU-Ins|No operand|
|`and`|0000-00-00|ALU-Ins|No operand|
|`orr`|0000-00-00|ALU-Ins|No operand|
|`not`|0000-00-00|ALU-Ins|No operand|
|`shl`|0000-00-00|ALU-Ins|No operand|
|`shr`|0000-00-00|ALU-Ins|No operand|
|`add`|0000-00-00|ALU-Ins|No operand|
|`sub`|0000-00-00|ALU-Ins|No operand|
|`mul`|0000-00-00|ALU-Ins|No operand|
|`cmp`|0000-00-00|ALU-Ins|No operand|
|`mil`|0000-00-00-I|Oner|No operand|
|`mih`|0000-00-00-I|Oner|No operand|
|`spc`|0000-00-00-I|Oner|No operand|
|`jpa`|0000-00-00-I|Oner|No operand|
|`jpr`|0000-00-00-I|Zeroer|No operand|
|`brz`|0000-00-00-I|Zeroer|No operand|
|`brc`|0000-00-00-I|Zeroer|No operand|
|`awp`|0000-00-00-I|Zeroer|No operand|

## Instructions as AddressUnit inputs

`lda` :
Put the **Rs register** on Address\_unit, set the **RPlus0** input of address\_logic _true_, so **Rs** value comes on Address\_out.  
`sta` :
Put the **Rd register** on Address\_unit, set the **RPlus0** input of address\_logic _true_, so **Rd** value comes on Address\_out.  
`spc` :
Enable the **PCPlusI** input of address\_logic _true_, so **PC + I** comes to Address\_out.  
`jpa` :
Put the **Rd register** on Address\_unit, then enable the **RPlusI** input, so **PC + Rd** comes on Address\_out.  
`jpr` , `brz`, `brc` :
Enable the **PCPlusI** input, so **PC + I** comes on Address\_out.