LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY ULA IS
	GENERIC(
		P_DATA	:	INTEGER := 16
	);
	PORT(
		I_SEL	:  IN STD_LOGIC_VECTOR(2 DOWNTO 0);
		I_RS1	:  IN STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0);
		I_RS2	:  IN STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0);
		O_ULA	: OUT STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE BEHAVIORAL OF ULA IS

BEGIN
	PROCESS(I_SEL, I_RS1, I_RS2)
	BEGIN
		CASE I_SEL IS
			WHEN "000" =>
				O_ULA <= I_RS1 + I_RS2;
			WHEN "001" =>
				O_ULA <= I_RS1 - I_RS2;
			WHEN "010" =>
				O_ULA <= I_RS1 AND I_RS2;
			WHEN "011" =>
				O_ULA <= I_RS1 OR I_RS2;
			WHEN "100" =>
				O_ULA <= I_RS1 XOR I_RS2;
			WHEN "101" =>
				O_ULA <= NOT I_RS1;
			WHEN "110" =>
				O_ULA <= NOT I_RS2;
			WHEN "111" =>
				O_ULA <= NOT(I_RS1 + I_RS2);
			WHEN OTHERS	=>
				NULL;
		END CASE;
	END PROCESS;
END ARCHITECTURE;