library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity MULTIPLEXADOR is
    Generic(
				p_DATA	: integer := 16
	 );
    Port ( 
				i_SEL		: in  STD_LOGIC_VECTOR(1 DOWNTO 0);
				i_DATA0	: in  STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
				i_DATA1	: in  STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
				i_DATA2	: in  STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
				i_DATA3	: in  STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);				
            o_DATA	: out STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0)	
	 );
end MULTIPLEXADOR;


architecture Behavioral of MULTIPLEXADOR is


begin

	PROCESS(i_SEL, i_DATA0, i_DATA1, i_DATA2, i_DATA3)
	BEGIN
		CASE i_SEL IS
			WHEN "00" => 
				o_DATA <= i_DATA0;
				
			WHEN "01" => 
				o_DATA <= i_DATA1;
				
			WHEN "10" =>
				o_DATA <= i_DATA2;
				
			WHEN OTHERS =>
				o_DATA <= i_DATA3;
				
			END CASE;			
	
	END PROCESS;
	
	
end Behavioral;