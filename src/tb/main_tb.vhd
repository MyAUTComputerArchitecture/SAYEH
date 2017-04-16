--------------------------------------------------------------------------------
-- Author:			Ahmad Anvari
--------------------------------------------------------------------------------
-- Create Date:   	16-04-2017
-- Package Name:	tb
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;

entity CLOCK_TB is
end CLOCK_TB;

architecture CLOCK_TB_ARCH of CLOCK_TB is
	
	signal CLK_COUNTER	: integer := 0;
	signal CLK_COUNT	: integer := 50;
	signal CLK : std_logic := '1';
	
begin
			
	CLOCK_GEN : process is
	begin
		loop
			CLK <= not CLK;
			wait for 100 ns;
			CLK <= not CLK;
			wait for 100 ns;
			
			CLK_COUNTER <= CLK_COUNTER + 1;
			
			if(CLK_COUNTER = CLK_COUNT) then
				assert false report "Reached end of the clock generation";
				wait;
			end if;
			
		end loop;
		
	end process CLOCK_GEN;
	
	TEST_BENCH:process
	begin
		
		wait for 200 ns;
		assert false report "Reached end of test";
		wait;
	end process;
end CLOCK_TB_ARCH;