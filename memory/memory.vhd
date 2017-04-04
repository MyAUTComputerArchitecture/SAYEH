--------------------------------------------------------------------------------
-- Author:        Parham Alvani (parham.alvani@gmail.com)
--
-- Create Date:   16-03-2017
-- Module Name:   memory.vhd
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity MEMORY is
	generic(
		MEMORY_WIDTH_SIZE 	: integer;		-- Size of each memory cell
		MEMORY_ADDRESS_SIZE	: integer		-- Size of the momory can be obtained from it
	       );
	port(
		address : in std_logic_vector(MEMORY_ADDRESS_SIZE - 1 downto 0);
		data_in : in std_logic_vector(2 ** MEMORY_ADDRESS_SIZE - 1 downto 0) ;
		data_out : out std_logic_vector(2 ** MEMORY_ADDRESS_SIZE - 1 downto 0);
		clk, rwbar : in std_logic
		);
end entity MEMORY;

architecture MEMORY_ARCH of MEMORY is
	type mem is array (natural range <>, natural range <>) of std_logic;
begin
	process (clk)
		constant memsize : integer := 2 ** address'length;
		variable memory : mem (0 to memsize - 1, data_in'range);
	begin
		if  clk'event and clk = '1' then
			if rwbar = '1' then -- Readiing :)
				for i in data_out'range loop
					data_out(i) <= memory (to_integer(unsigned(address)), i);
				end loop;
			else -- Writing :)
				for i in data_in'range loop
					memory (to_integer(unsigned(address)), i) := data_in (i);
				end loop;
			end if;
		end if;
	end process;
end architecture MEMORY_ARCH;
