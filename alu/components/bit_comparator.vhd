--------------------------------------------------------------------------------
-- Author:              SeyedMostafa Meshkati
--------------------------------------------------------------------------------
-- Create Date:         08-04-2017
-- Package Name:        alu_component
-- Module Name:         COMPARISION_COMPONENT
--------------------------------------------------------------------------------

library IEEE;

use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity BIT_COMPARATOR is
    port(
        INPUT1   : in std_logic;
        INPUT2   : in std_logic;
        EQUAL    : out std_logic;
        GREATER : out std_logic;
        LOWER    : out std_logic
    );
end entity;

architecture BIT_COMPARATOR_ARCH of BIT_COMPARATOR is
begin
    EQUAL   <= INPUT1 xnor INPUT2;
    GREATER <= INPUT1 and (not INPUT2);
    LOWER   <= (not INPUT1) and INPUT2;
end architecture;