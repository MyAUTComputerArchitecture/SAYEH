--------------------------------------------------------------------------------
-- Author:              Ahmad Anvari
--------------------------------------------------------------------------------
-- Create Date:         09-04-2017
-- Package Name:        util
-- Module Name:         
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity TB is
end entity;

architecture TB_ARCH of TB is
	component TRI_STATE is
		generic(
			COMPONENT_SIZE  : integer
			);
		port(
			DATA_IN			:  in  std_logic_vector(COMPONENT_SIZE - 1 downto 0);
			STATE			:  in  std_logic;
			DATA_OUT		:  out std_logic_vector(COMPONENT_SIZE - 1 downto 0)
	      );
	end component;
	
	signal 	INPUT			: std_logic_vector(3 downto 0);
	signal 	OUTPUT			: std_logic_vector(3 downto 0);
	signal 	S				: std_logic;
	
	signal 	INPUT2			: std_logic_vector(3 downto 0);
	signal 	S2				: std_logic;
begin
	TRI_STATE_inst : component TRI_STATE
		generic map(
			COMPONENT_SIZE => 4
		)
		port map(
			DATA_IN  => INPUT,
			STATE    => S,
			DATA_OUT => OUTPUT
		);
		
	TRI_STATE_inst2 : component TRI_STATE
		generic map(
			COMPONENT_SIZE => 4
		)
		port map(
			DATA_IN  => INPUT2,
			STATE    => S2,
			DATA_OUT => OUTPUT
		);
		
	
	TEST_BENCH : process is
	begin
		s		<= '0';
		INPUT	<= "1101";
		s2		<= '1';
		INPUT2	<= "0000";
		wait for 1 ns;
		
		s		<= '1';
		INPUT	<= "1101";
		s2		<= '0';
		INPUT2	<= "0000";
		wait for 1 ns;
		
		s		<= '0';
		INPUT	<= "1101";
		s2		<= '0';
		INPUT2	<= "0000";
		wait for 1 ns;
		
		s		<= '1';
		INPUT	<= "1001";
		s2		<= '1';
		INPUT2	<= "0000";
		wait for 1 ns;
		
		wait for 1 ns;
		assert false report "Reached end of test";
		wait;
	end process TEST_BENCH;
	
end architecture;