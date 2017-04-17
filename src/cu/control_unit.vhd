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
		WORD_SIZE       : integer; -- This indicates the operations' size
		WP_ADDRESS_SIZE : integer
	);
	port(
		-- ----------- SIGNALS FROM OUT OF PROCESSOR --------------
		CLK                      : in  std_logic;
		EXTERNAL_RESET           : in  std_logic;
		-- --------------- MEMORY RELATED SIGNALS -----------------
		MEM_DATA_READY           : in  std_logic;
		WRITE_MEM                : out std_logic;
		READ_MEM                 : out std_logic;
		-- ---------------- FLAGS RELATED SIGNALS -----------------
		Z_IN                     : in  std_logic;
		C_IN                     : in  std_logic;
		C_OUT                    : out std_logic;
		Z_OUT                    : out std_logic;
		C_SET                    : out std_logic;
		C_RESET                  : out std_logic;
		Z_SET                    : out std_logic;
		Z_RESET                  : out std_logic;
		IL_ENABLE                : out std_logic;
		-- ------------------ AL RELATED SIGNALS ------------------
		RESET_PC                 : out std_logic;
		PC_PLUS_I                : out std_logic;
		PC_PLUS_1                : out std_logic;
		R_PLUS_I                 : out std_logic;
		R_PLUS_0                 : out std_logic;
		ENABLE_PC                : out std_logic;
		-- ------------------ ALU RELATED SIGNALS ------------------
		ALU_OPERATION			 : out std_logic_vector(3 downto 0);				--	This is not generic cause it can't be :D
		-- ------------------ WP RELATED SIGNALS ------------------
		WP_ADD_ENABLE			 : out std_logic;
		WP_RESET                 : out std_logic;
		---------------- REGISTER FILE RELATED SIGNALS ------------
		RF_L_WRITE				 : out std_logic;
		RF_H_WRITE				 : out std_logic;
		-- ---------------------- SHADOW --------------------------
		SHADOW                   : out std_logic;
		-- ------------------ IR RELATED SIGNALS ------------------
		IR_INPUT                 : in  std_logic_vector(WORD_SIZE - 1 downto 0);
		IR_LOAD                  : out std_logic;
		-- --------------- DATABUS CONTROL SIGNALS ----------------
		ADDRESS_ON_BUS           : out std_logic;
		RS_ON_ADDRESS_UNIT_RSIDE : out std_logic;
		RD_ON_ADDRESS_UNIT_RSIDE : out std_logic
	);
end entity;

architecture CONTROL_UNIT_ARCH of CONTROL_UNIT is
	type CU_STATE_TYPE is (
		FETCH_0,
		DECODE,
		EXEC_NOP, EXEC_HLT, EXEC_SZF, EXEC_CZF, EXEC_SCF, EXEC_CCF, EXEC_CWP,
		EXEC_JPR, EXEC_BRZ, EXEC_BRC, EXEC_AWP,
		EXEC_MVR, EXEC_LDA, EXEC_STA, EXEC_INP, EXEC_OUP, EXEC_AND, EXEC_ORR, EXEC_NOT, EXEC_SHL, EXEC_SHR, EXEC_ADD, EXEC_SUB, EXEC_MUL, EXEC_CMP,
		EXEC_MIL, EXEC_MIH, EXEC_SPC, EXEC_JPA,
		
		END_OF_NOP
	);

	signal CURRENT_CU_STATE : CU_STATE_TYPE := FETCH_0;
	signal IS_IMEDIATE      : std_logic;
	signal IS_SECOND_PART   : std_logic;
	signal OPCODE_HELPER1   : std_logic_vector(1 downto 0);
	signal OPCODE_HELPER2   : std_logic_vector(1 downto 0);
	signal OPCODE           : std_logic_vector(3 downto 0);

begin

	process(CLK)
	begin
		if CLK'event and CLK = '1' then
			if EXTERNAL_RESET = '1' then
				WRITE_MEM                <= '0';
				READ_MEM                 <= '0';
				RESET_PC                 <= '1';
				C_RESET                  <= '1';
				Z_RESET                  <= '1';
				WP_RESET                 <= '1';
				ADDRESS_ON_BUS           <= '0';
				RS_ON_ADDRESS_UNIT_RSIDE <= '0';
				RD_ON_ADDRESS_UNIT_RSIDE <= '0';
				IR_LOAD                  <= '0';
				IS_SECOND_PART           <= '0';
				CURRENT_CU_STATE         <= FETCH_0;
			else
				case CURRENT_CU_STATE is
					when FETCH_0 =>
						READ_MEM <= '1';
						-- -- AL_OUT <- PC ----
						RESET_PC         <= '0';
						PC_PLUS_I        <= '0';
						PC_PLUS_1        <= '0';
						R_PLUS_I         <= '0';
						R_PLUS_0         <= '0';
						if MEM_DATA_READY = '1' then
							IR_LOAD          <= '1';
							CURRENT_CU_STATE <= DECODE;
						end if;
					when DECODE =>
						IR_LOAD <= '0';

						if IS_SECOND_PART = '1' then
							OPCODE <= IR_INPUT(7 downto 4);
						else
							OPCODE <= IR_INPUT(15 downto 12);
						end if;

						case OPCODE is
							when "0000" =>
								if IS_SECOND_PART = '1' then
									OPCODE_HELPER1 <= IR_INPUT(3 downto 2);
									OPCODE_HELPER2 <= IR_INPUT(1 downto 0);
								else
									OPCODE_HELPER1 <= IR_INPUT(11 downto 10);
									OPCODE_HELPER2 <= IR_INPUT(9 downto 8);
								end if;

								case OPCODE_HELPER1 is
									when "00" =>
										case OPCODE_HELPER2 is
											when "00" => CURRENT_CU_STATE <= EXEC_NOP;
											when "01" => CURRENT_CU_STATE <= EXEC_HLT;
											when "10" => CURRENT_CU_STATE <= EXEC_SZF;
											when "11" => CURRENT_CU_STATE <= EXEC_CZF;
										end case;
									when "01" =>
										case OPCODE_HELPER2 is
											when "00" => CURRENT_CU_STATE <= EXEC_SCF;
											when "01" => CURRENT_CU_STATE <= EXEC_CCF;
											when "10" => CURRENT_CU_STATE <= EXEC_CWP;
											when "11" => CURRENT_CU_STATE <= EXEC_JPR;
										end case;
									when "10" =>
										case OPCODE_HELPER2 is
											when "00" => CURRENT_CU_STATE <= EXEC_BRZ;
											when "01" => CURRENT_CU_STATE <= EXEC_BRC;
											when "10" => CURRENT_CU_STATE <= EXEC_AWP;
										end case;
									when "11" =>
										null;
								end case;
							when "0001" =>
								CURRENT_CU_STATE <= EXEC_MVR; 
							when "0010" =>
								CURRENT_CU_STATE <= EXEC_LDA;
							when "0011" =>
								CURRENT_CU_STATE <= EXEC_STA;
							when "0100" =>
								CURRENT_CU_STATE <= EXEC_INP;
							when "0101" =>
								CURRENT_CU_STATE <= EXEC_OUP;
							when "0110" =>
								CURRENT_CU_STATE <= EXEC_AND;
							when "0111" =>
								CURRENT_CU_STATE <= EXEC_ORR;
							when "1000" =>
								CURRENT_CU_STATE <= EXEC_NOT;
							when "1001" =>
								CURRENT_CU_STATE <= EXEC_SHL;
							when "1010" =>
								null;
							when "1011" =>
								null;
							when "1100" =>
								null;
							when "1101" =>
								null;
							when "1110" =>
								null;
							when "1111" =>
								null;
						end case;
					when EXEC_NOP =>
						null;
					when EXEC_HLT =>
						null;
					when EXEC_SZF =>
						null;
					when EXEC_CZF =>
						null;
					when EXEC_SCF =>
						null;
					when EXEC_CCF =>
						null;
					when EXEC_CWP =>
						null;
					when EXEC_JPR =>
						null;
					when EXEC_BRZ =>
						null;
					when EXEC_BRC =>
						null;
					when EXEC_AWP =>
						null;
					when EXEC_MVR =>
						null;
					when EXEC_LDA =>
						null;
					when EXEC_STA =>
						null;
					when EXEC_INP =>
						null;
					when EXEC_OUP =>
						null;
					when EXEC_AND =>
						null;
					when EXEC_ORR =>
						null;
					when EXEC_NOT =>
						null;
					when EXEC_SHL =>
						null;
					when EXEC_SHR =>
						null;
					when EXEC_ADD =>
						null;
					when EXEC_SUB =>
						null;
					when EXEC_MUL =>
						null;
					when EXEC_CMP =>
						null;
					when EXEC_MIL =>
						null;
					when EXEC_MIH =>
						null;
					when EXEC_SPC =>
						null;
					when EXEC_JPA =>
						null;
					when END_OF_NOP =>
						null;

				end case;
			end if;

		end if;
	end process;
end architecture;
