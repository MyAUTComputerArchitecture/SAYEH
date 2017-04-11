--------------------------------------------------------------------------------
-- Author:              Ahmad Anvari
--------------------------------------------------------------------------------
-- Create Date:         11-04-2017
-- Package Name:        cu
-- Module Name:         CONTROL_UNIT
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity CONTROL_UNIT is
	generic(
		COMPONENT_SIZE  : integer
		);
	port(
		INPUT		: in  std_logic_vector(COMPONENT_SIZE - 1 downto 0);
		OUTPUT		: out std_logic
      );
end entity;

architecture CONTROL_UNIT_ARCH of CONTROL_UNIT is
begin
end architecture;