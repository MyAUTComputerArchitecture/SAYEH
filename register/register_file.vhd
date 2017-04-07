--------------------------------------------------------------------------------
-- Author:		Ahmad Anvari
--------------------------------------------------------------------------------
-- Create Date:   	07-04-2017
-- Package Name:	register
-- Module Name:   	REGISTER_FILE
--------------------------------------------------------------------------------
 
library IEEE;

use IEEE.std_logic_1164.all;
use IEEE.NUMERIC_STD.ALL;

-- This module is a register file containing REGISTER_COUNT regisers that each
-- register has REGESTER_SIZE bits and can be accessed to each register with SEL
-- signal.

	
entity REGISTER_FILE is
	generic(
		REGESTER_SIZE 	: integer;							-- Size of each register in the register file
		REGISTER_COUNT 	: integer							-- Number of registers in the register file
		);
	
	port(
		IDATA		: in std_logic_vector(REGESTER_SIZE - 1 downto 0);						--	STD logic vector for input data
		CLK			: in std_logic;															--	Clock input
		SEL			: in std_logic_vector(4 - 1 downto 0);									--	Select signal for addressing to registers
		RES 		: in std_logic;															--	Reset signal
		WRITE_EN	: in std_logic;															--	Wrinting enable signal
		READ_EN		: in std_logic;															--	Reading enable signal
		ODATA		: out std_logic_vector(REGESTER_SIZE - 1 downto 0)						--	Output of data
		);
end entity;

architecture REGISTER_FILE_ARCH of REGISTER_FILE is
	
	type REGISTERS_TYPE is array(REGISTER_COUNT - 1 downto 0) of std_logic_vector(REGESTER_SIZE - 1 downto 0);
	signal REGISTERS : REGISTERS_TYPE;
	
begin	
	
	process(clk)
			variable address : integer;
	begin
		if clk'event and clk = '1' then
			if(WRITE_EN = '1') then
				address := to_integer(unsigned(SEL));
				REGISTERS(address) <= IDATA;
			end if;
			if(READ_EN = '1') then
				address := to_integer(unsigned(SEL));
				ODATA <= REGISTERS(address);
			end if;
			if(RES = '1') then
				for I in REGISTERS'low to REGISTERS'high loop
					for J in REGISTERS(I)'low to REGISTERS(I)'high loop
						REGISTERS(I)(J) <= '0';
					end loop;
				end loop;
			end if;
		end if;
	end process;
end architecture;