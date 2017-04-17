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

* **Operand needed instructions** : 

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