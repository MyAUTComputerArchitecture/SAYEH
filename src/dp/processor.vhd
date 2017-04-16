--------------------------------------------------------------------------------
-- Author:              Ahmad Anvari
--------------------------------------------------------------------------------
-- Create Date:         13-04-2017
-- Package Name:        dp
-- Module Name:         PROCESSOR
--------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;

entity PROCESSOR is
	generic(
		WORD_SIZE  : integer
		);
	port(
		CLK						:	in	std_logic;
		------------------------- MEMORY SIGNALS -------------------------
		MEM_DATA_READY			:	in	std_logic;
		WRITE_MEM				:	out	std_logic;
		READ_MEM				:	out	std_logic;
		
		PORTS					:	inout	std_logic_vector(63 downto 0)
      );
end entity;

architecture PROCESSOR_ARCH of PROCESSOR is
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
	
	component FLAGS is
		port(
			CLK			:	in	std_logic;						--	Clock signal
			C_IN		:	in	std_logic;						--	Carry in
			Z_IN		:	in	std_logic;						--	Zero in
			C_SET		:	in	std_logic;						--	Carry Flag set
			C_RESET		:	in 	std_logic;						--	Carry Flag reset
			Z_SET		:	in	std_logic;						--	Zero Flag set
			Z_RESET		:	in 	std_logic;						--	Zero Flag reset
			IL_ENABLE	:	in	std_logic;						--	Imediate Load enable	
			C_OUT		:	out	std_logic;						--	Carry out
			Z_OUT		:	out	std_logic						--	Zero out
		);
	end component;
	
	component REGISTER_R is
		generic(
			REG_SIZE : integer := 2											-- Size of the register
		);
		port(
			IDATA	: in	std_logic_vector(REG_SIZE - 1 downto 0);		--	Input data for loading onto regiser
			CLK		: in	std_logic;										--	Clock signal
			LOAD	: in	std_logic;										--	Load enable signal for loading value onto register
			RESET	: in	std_logic;										--	Reset signal to make the register 0
			ODATA	: out	std_logic_vector(REG_SIZE - 1 downto 0)			--	Output of register
		);
	end component;
	
	component ADDRESS_UNIT IS
	    port (
	        Rside : IN std_logic_vector (15 DOWNTO 0);
	        Iside : IN std_logic_vector (7 DOWNTO 0);
	        Address : OUT std_logic_vector (15 DOWNTO 0);
	        clk, ResetPC, PCplusI, PCplus1 : IN std_logic;
	        RplusI, Rplus0, EnablePC : IN std_logic
	    );
	end component;
	
	component ALU is
		generic(
			COMPONENT_SIZE  : integer
			);
		port(
			CARRY_IN	: in  std_logic;
			INPUT1		: in  std_logic_vector(COMPONENT_SIZE - 1 downto 0);
			INPUT2		: in  std_logic_vector(COMPONENT_SIZE - 1 downto 0);
			OPERATION	: in  std_logic_vector(3 downto 0);
			OUTPUT		: out std_logic_vector(COMPONENT_SIZE - 1 downto 0);
			CARRY_OUT	: out std_logic;
			ZERO_OUT	: out std_logic
	      );
	end component;
	
	component REGISTER_FILE is
		generic(
			REGESTER_SIZE 	: integer := 16;											-- Size of each register in the register file
			ADDRESS_SIZE 	: integer := 6												-- Size of the address that can lead to the number of registers
			);
		
		port(
			IDATA		: in std_logic_vector(REGESTER_SIZE - 1 downto 0);						--	STD logic vector for input data
			CLK			: in std_logic;															--	Clock input
			WP_IN		: in std_logic_vector(ADDRESS_SIZE - 1 downto 0);						--	Select signal for addressing to registers
			RF_L_WRITE	: in std_logic;															--	Write enable signal for low significant bit
			RF_H_WRITE	: in std_logic;															--	Write enable signal for high significant bit
			SELECTOR	: in std_logic_vector(3 downto 0);
			LEFT_OUT	: out std_logic_vector(REGESTER_SIZE - 1 downto 0);						--	Output number 1
			RIGHT_OUT	: out std_logic_vector(REGESTER_SIZE - 1 downto 0)						--	Output number 2
			);
	end component;
begin
	FLAGS_INS : component FLAGS
		port map(
			CLK       => CLK,
			C_IN      => C_IN,
			Z_IN      => Z_IN,
			C_SET     => C_SET,
			C_RESET   => C_RESET,
			Z_SET     => Z_SET,
			Z_RESET   => Z_RESET,
			IL_ENABLE => IL_ENABLE,
			C_OUT     => C_OUT,
			Z_OUT     => Z_OUT
		);
		
	IR : component REGISTER_R
		generic map(
			REG_SIZE => REG_SIZE
		)
		port map(
			IDATA => IDATA,
			CLK   => CLK,
			LOAD  => LOAD,
			RESET => RESET,
			ODATA => ODATA
		);
		
	WP : component REGISTER_R
		generic map(
			REG_SIZE => REG_SIZE
		)
		port map(
			IDATA => IDATA,
			CLK   => CLK,
			LOAD  => LOAD,
			RESET => RESET,
			ODATA => ODATA
		);
		
	REGISTER_FILE_INS : component REGISTER_FILE
		generic map(
			REGESTER_SIZE => REGESTER_SIZE,
			ADDRESS_SIZE  => ADDRESS_SIZE
		)
		port map(
			IDATA      => IDATA,
			CLK        => CLK,
			WP_IN      => WP_IN,
			RF_L_WRITE => RF_L_WRITE,
			RF_H_WRITE => RF_H_WRITE,
			SELECTOR   => SELECTOR,
			LEFT_OUT   => LEFT_OUT,
			RIGHT_OUT  => RIGHT_OUT
		);
		
		
end architecture;