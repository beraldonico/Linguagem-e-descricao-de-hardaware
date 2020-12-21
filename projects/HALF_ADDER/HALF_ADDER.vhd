library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity HALF_ADDER IS
	PORT(
		i_A	: in std_logic;
		i_B	: in std_logic;
		o_S	: out std_logic;
		o_C	: out std_logic
	);
end HALF_ADDER;

architecture behavioral of halF_ADDER is


begin
	o_S <= i_A xor i_B;
	o_C <= i_A xor i_B;
end behavioral;