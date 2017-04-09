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
    COMPONENT_SIZE  : integer
         );
  port(
    INPUT1    : in  std_logic_vector(COMPONENT_SIZE - 1 downto 0);
    INPUT2    : in  std_logic_vector(COMPONENT_SIZE - 1 downto 0);
    SUM       : out std_logic_vector(COMPONENT_SIZE - 1 downto 0);
    CARRY     : out std_logic
      );
end entity;

architecture ADDER_COMPONENT_ARCH of ADDER_COMPONENT is
	component FULL_ADDER is
		port(
			CIN			: in  std_logic;
		    A			: in  std_logic;
		    B			: in  std_logic;
		    SUM       	: out std_logic;
		    CARRY     	: out std_logic
	      );
	end component;
	
	signal CARRIES    : std_logic_vector(COMPONENT_SIZE downto 0);
	signal LAST_CAR	  : std_logic;
	
begin
	
	
	
	CARRIES(0)	<= '0';
	
	ADDERS_CONNECTING:
	for I in 0 to INPUT1'length - 1 generate
		ADDER_X: FULL_ADDER
			port map(
				CIN   => CARRIES(I),
				A     => INPUT1(I),
				B     => INPUT2(I),
				SUM   => SUM(I),
				CARRY => CARRIES(I + 1)
			);
	end generate;
--	
--	ADDER_END :FULL_ADDER
--		port map(
--			CIN   => CARRIES(COMPONENT_SIZE - 1),
--			A     => INPUT1(COMPONENT_SIZE - 1),
--			B     => INPUT2(COMPONENT_SIZE - 1),
--			SUM   => SUM(COMPONENT_SIZE - 1),
--			CARRY => LAST_CAR
--		); 
--		
	
--	CARRY		<= (INPUT1(COMPONENT_SIZE - 1) xnor INPUT2(COMPONENT_SIZE - 1)) and LAST_CAR;

	CARRY		<= CARRIES(COMPONENT_SIZE - 1) xor CARRIES(COMPONENT_SIZE);	
end architecture;