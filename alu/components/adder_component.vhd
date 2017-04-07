--------------------------------------------------------------------------------
-- Author:              Ahmad Anvari
--------------------------------------------------------------------------------
-- Create Date:         07-04-2017
-- Package Name:        alu/components
-- Module Name:         ADDER_COMPONENT
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity ADDER_COMPONENT is
	generic(
		COMPONENT_SIZE	: integer := 2
	       );
	port(
		INPUT1		: in  std_logic_vector(COMPONENT_SIZE - 1 downto 0);
		INPUT2		: in  std_logic_vector(COMPONENT_SIZE - 1 downto 0);
		SUM		: out std_logic_vector(COMPONENT_SIZE - 1 downto 0);
		CARRY		: out std_logic
	    );
end entity;

architecture ADDER_COMPONENT_ARCH of ADDER_COMPONENT is
	signal RES		: std_logic_vector(COMPONENT_SIZE downto 0);
begin
	RES <= std_logic_vector(to_integer(unsigned('0' & INPUT1)) + unsigned('0' & INPUT2));
	SUM <= RES(COMPONENT_SIZE - 1 to 0);
	CARRY  <= RES(COMPONENT_SIZE);
end architecture;
