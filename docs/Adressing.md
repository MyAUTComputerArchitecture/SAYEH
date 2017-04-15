# Addressing

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