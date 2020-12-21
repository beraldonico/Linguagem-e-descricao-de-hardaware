LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_unsigned.ALL;

ENTITY TB_TRABALHO_STMEMORIA IS
	
END ENTITY;

ARCHITECTURE BEHAVIORAL OF TB_TRABALHO_STMEMORIA IS
	COMPONENT TRABALHO_STMEMORIA IS
		GENERIC(
			DATA_LENGTH	: INTEGER := 4;
			ADD_LENGTH 	: INTEGER := 5
		);
		PORT(
			I_CLK		: IN  STD_LOGIC;
			I_BTNW	: IN  STD_LOGIC;
			I_BTNR	: IN  STD_LOGIC;
			I_BTNRST	: IN  STD_LOGIC;
			I_ADD 	: IN  STD_LOGIC_VECTOR(ADD_LENGTH - 1 DOWNTO 0);
			I_DATA	: IN  STD_LOGIC_VECTOR(DATA_LENGTH - 1 DOWNTO 0);
			O_LED7	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT STMEMORIA IS
		PORT(
			I_CLK		: IN  STD_LOGIC;
			I_BTNW	: IN  STD_LOGIC;
			I_BTNR	: IN  STD_LOGIC;
			I_BTNRST	: IN  STD_LOGIC;
			O_WE		: OUT STD_LOGIC
		);
	END COMPONENT;
	
	COMPONENT MEMORIA IS
		GENERIC(
			DATA_LENGTH	: INTEGER;
			ADD_LENGTH	: INTEGER
		);
		PORT(
			I_CLK 	: IN 	STD_LOGIC;
			I_WE		: IN  STD_LOGIC;
			I_ADD 	: IN  STD_LOGIC_VECTOR(ADD_LENGTH - 1 DOWNTO 0);
			I_DATA	: IN  STD_LOGIC_VECTOR(DATA_LENGTH - 1 DOWNTO 0);
			O_DATA	: OUT STD_LOGIC_VECTOR(DATA_LENGTH - 1 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT LED_7SEG IS
		GENERIC(
			DATA_LENGTH	: INTEGER
		);
		PORT(
			I_CLK 	: IN 	STD_LOGIC;
			I_DATA	: IN  STD_LOGIC_VECTOR(DATA_LENGTH - 1 DOWNTO 0);
			O_LED7	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
		);
	END COMPONENT;
	
	SIGNAL W_CLK			: STD_LOGIC;
	SIGNAL W_BTNW			: STD_LOGIC;
	SIGNAL W_BTNR			: STD_LOGIC;
	SIGNAL W_BTNRST		: STD_LOGIC;
	SIGNAL W_ADD 			: STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL W_IDATA			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL W_ODATA 		: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL W_WE				: STD_LOGIC;
	SIGNAL W_LED7			: STD_LOGIC_VECTOR(7 DOWNTO 0);
	
BEGIN
	TBTSTM: TRABALHO_STMEMORIA 
		GENERIC MAP(
			DATA_LENGTH	=> 4,
			ADD_LENGTH 	=> 5
		)
		port map(
			I_CLK		=> W_CLK,
			I_BTNW	=>	W_BTNW,	
			I_BTNR	=> W_BTNR,
			I_BTNRST	=> W_BTNRST,
			I_ADD 	=> W_ADD,
			I_DATA	=> W_IDATA,
			O_LED7	=> W_LED7
		);
	ST : STMEMORIA
		PORT MAP(
			I_CLK	 	=> W_CLK,
			I_BTNR 	=> W_BTNR,
			I_BTNW 	=> W_BTNW,
			I_BTNRST	=> W_BTNRST,
			O_WE	 	=> W_WE
		);
	RAM : MEMORIA
		GENERIC MAP(
			DATA_LENGTH => 4,
			ADD_LENGTH	=> 5
		)
		PORT MAP(
			I_CLK	 => W_CLK,
			I_WE 	 => W_WE,
			I_ADD  => W_ADD,
			I_DATA => W_IDATA,
			O_DATA => W_ODATA
		);
	LED : LED_7SEG
		GENERIC MAP(
			DATA_LENGTH => 4
		)
		PORT MAP(
			I_CLK  => W_CLK,
			I_DATA => W_ODATA,
			O_LED7 => W_LED7
		);
	PROCESS
	BEGIN
		W_CLK <= '0';
		WAIT FOR 10 NS;
		W_CLK <= '1';
		WAIT FOR 10 NS;
	END PROCESS;
	PROCESS
	BEGIN
		W_BTNRST	<= '0';
		W_BTNW	<= '1';
	   W_BTNR	<= '1';
	   W_ADD 	<= "00000";
	   W_IDATA	<= "0000";
		WAIT FOR 100 NS;
		
	   W_BTNW	<= '0';
	   W_BTNR	<= '1';
	   W_BTNRST	<= '1';
	   W_ADD 	<= "00001";
	   W_IDATA	<= "0001";
		WAIT FOR 100 NS;
		
	   W_BTNW	<= '0';
	   W_BTNR	<= '1';
	   W_BTNRST	<= '1';
	   W_ADD 	<= "00010";
	   W_IDATA	<= "0010";
		WAIT FOR 100 NS;
		
	   W_BTNW	<= '1';
	   W_BTNR	<= '0';
	   W_BTNRST	<= '1';
	   W_ADD 	<= "00001";
	   W_IDATA	<= "0001";
		WAIT FOR 100 NS;
		
	   W_BTNW	<= '0';
	   W_BTNR	<= '1';
	   W_BTNRST	<= '1';
	   W_ADD 	<= "00011";
	   W_IDATA	<= "0011";
		WAIT FOR 100 NS;
		
	   W_BTNW	<= '1';
	   W_BTNR	<= '0';
	   W_BTNRST	<= '1';
	   W_ADD 	<= "00010";
	   W_IDATA	<= "0001";
		WAIT FOR 100 NS;
		
	   W_BTNW	<= '1';
	   W_BTNR	<= '0';
	   W_BTNRST	<= '1';
	   W_ADD 	<= "00001";
	   W_IDATA	<= "0010";
		WAIT FOR 100 NS;
		
	   W_BTNW	<= '1';
	   W_BTNR	<= '0';
	   W_BTNRST	<= '1';
	   W_ADD 	<= "00011";
	   W_IDATA	<= "0001";
		WAIT FOR 100 NS;
		
		WAIT;
	END PROCESS;
END ARCHITECTURE;