--------------------------------------------------------------------------------
-- Author:              Ahmad Anvari
--------------------------------------------------------------------------------
-- Create Date:         06-04-2017
-- Package Name:        alu_component
-- Module Name:         XOR_COMPONENT
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity XOR_COMPONENT is
	generic(
		COMPONENT_SIZE	: integer
	       );
	port(
		INPUT1		: in  std_logic_vector(COMPONENT_SIZE - 1 downto 0);
		INPUT2		: in  std_logic_vector(COMPONENT_SIZE - 1 downto 0);
		OUTPUT		: out std_logic_vector(COMPONENT_SIZE - 1 downto 0)
	    );
end component;

architecture XOR_COMPONENT_ARCH of XOR_COMPONENT is

begin
	GATE_GEN:
	for I in OUTPUT'range generate
	begin
		OUTPUT(i) <= INPUT1 xor INPUT2;
	end for;
end architecture;
