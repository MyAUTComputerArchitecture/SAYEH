--------------------------------------------------------------------------------
-- Author:              SeyedMostafa Meshkati
--------------------------------------------------------------------------------
-- Create Date:         13-04-2017
-- Package Name:        alu/components
-- Module Name:         MULTIPLICATION_COMPONENT
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;

entity MULTIPLICATION_COMPONENT is
	generic(
		COMPONENT_SIZE	: integer
	);
	
	port(
		INPUT1		: in std_logic_vector(COMPONENT_SIZE/2 - 1 downto 0);
		INPUT2		: in std_logic_vector(COMPONENT_SIZE/2 - 1 downto 0);
		OUTPUT		: out std_logic_vector(COMPONENT_SIZE - 1 downto 0)
	);
end entity;

architecture MULTIPLICATION_COMPONENT_ARCH of MULTIPLICATION_COMPONENT is
	component ADDER_SUBTRACTOR_COMPONENT is
		generic(
			COMPONENT_SIZE  : integer
			);
		port(
			CARRY_IN	: in  std_logic;
			INPUT1		: in  std_logic_vector(COMPONENT_SIZE - 1 downto 0);
			INPUT2		: in  std_logic_vector(COMPONENT_SIZE - 1 downto 0);
			IS_SUB		: in  std_logic;											-- 0 for add and 1 for subtraction
			SUM			: out std_logic_vector(COMPONENT_SIZE - 1 downto 0);
			CARRY		: out std_logic
	      );
	end component;
	
	type arraySignals is array (0 to COMPONENT_SIZE - 1) of std_logic_vector(COMPONENT_SIZE - 1 downto 0);

	-- signal multy	: std_logic_vector(COMPONENT_SIZE - 1 downto 0);
	-- signal zero_signal	: std_logic_vector(COMPONENT_SIZE - 1 downto 0);
	-- signal temp	: std_logic_vector(COMPONENT_SIZE - 1 downto 0);
    -- signal out_temp	: std_logic_vector(15 downto 0);
    -- signal car : std_logic;
	
begin
	-- MAKE_SIGNALS_ZERO:
	-- for I in 0 to COMPONENT_SIZE - 1 generate
	-- 	-- multy(I) <= '0';
	-- 	zero_signal(I) <= '0';
    --     out_temp(I) <= '0';
	-- end generate;

	MAKE_SEQUENSE:
	for I in 0 to component_size generate

        MODULE: ADDER_SUBTRACTOR_COMPONENT
        generic map(COMPONENT_SIZE)
        port map('0', multy, "0000000000011001", '0', multy, car);
		-- port map('0', multy, temp, '0', out_temp, car);
	end generate MAKE_SEQUENSE;
	
    OUTPUT <= multy;
end architecture;
