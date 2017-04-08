library IEEE;

use IEEE.std_logic_1164.all;

entity TB is
end TB;

architecture TB_ARCH of TB is
	component SHIFT_R_COMPONENT is
		generic(
			COMPONENT_SIZE	: integer
		       );
		port(
			INPUT		: in  std_logic_vector(COMPONENT_SIZE - 1 downto 0);
			OUTPUT		: out std_logic_vector(COMPONENT_SIZE - 1 downto 0)
		    );
	end component;
	
	signal a, o	: std_logic_vector(15 downto 0);
begin
	MODULE: SHIFT_R_COMPONENT
		generic map(16)
       	port map( a ,o);
	
	process
	begin
		a <= "0000000000000001";
		
		wait for 1 ns;
		
		a <= "0111000010101010";
		
		wait for 1 ns;
		
		a <= "1111111111111111";

		wait for 1 ns;

		assert false report "Reached end of test";
		wait;
	end process;
end TB_ARCH;
