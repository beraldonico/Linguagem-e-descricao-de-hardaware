LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY REGISTRADOR IS
	GENERIC(
		P_DATA	: INTEGER := 16
	);
	PORT(
		I_CLK		:  IN STD_LOGIC;
		I_RST		:  IN STD_LOGIC;
		I_WE		:  IN STD_LOGIC;
		I_DATA	:  IN STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0);
		O_DATA	: OUT STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0) 
	);
END ENTITY;

ARCHITECTURE BEHAVIORAL OF REGISTRADOR IS

BEGIN
	PROCESS(I_CLK)
	BEGIN
		IF RISING_EDGE(I_CLK) THEN
			IF(I_RST = '0') THEN
				O_DATA <= (OTHERS => '0');
			ELSE
				IF(I_WE = '0') THEN
					O_DATA <= I_DATA;
				END IF;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE;