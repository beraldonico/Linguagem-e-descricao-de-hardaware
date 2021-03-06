library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity REGISTRADOR is
    Generic(
				p_DATA	: integer := 16
	 );
    Port ( 
				i_CLK		: in  STD_LOGIC;
			   i_RST   	: in  STD_LOGIC;
				i_WE		: in  STD_LOGIC;
				i_DATA	: in  STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
            o_DATA	: out STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0)	
	 );
end REGISTRADOR;


architecture Behavioral of REGISTRADOR is


begin

	PROCESS(i_CLK)
	BEGIN
		IF RISING_EDGE(i_CLK) THEN
			IF (i_RST = '0') THEN
				o_DATA <= (OTHERS => '0');
			ELSE
				IF (i_WE = '0') THEN
					o_DATA <= i_DATA;
				END IF;
			END IF;
		END IF;
	END PROCESS;
	
	
end Behavioral;