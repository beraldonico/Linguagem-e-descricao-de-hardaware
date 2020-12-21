library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity CAMINHO_DADOS is
    Generic(
		p_DATA		: integer := 8
	 );
    Port ( 
		i_CLK			: in  STD_LOGIC;
		i_RST			: in  STD_LOGIC;
		i_WE			: in  STD_LOGIC_VECTOR(3 DOWNTO 0);
		i_DATA		: in  STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
		i_SEL_RS1	: in  STD_LOGIC_VECTOR(1 DOWNTO 0);
		i_SEL_RS2	: in  STD_LOGIC_VECTOR(1 DOWNTO 0);
		i_SEL_ULA	: IN  STD_LOGIC_VECTOR(2 downto 0);
		i_SEL_IMED	: in  std_LOGIC;
		i_EN_OUT		: IN  STD_LOGIC;
		o_LED			: out STD_LOGIC_VECTOR(p_DATA-7 DOWNTO 0);
		O_LED7		: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	 );
end CAMINHO_DADOS;


architecture Behavioral of CAMINHO_DADOS is
--==============================================================
	COMPONENT BANCO_REGISTRADORES is
		Generic(
			p_DATA		: integer := 8
		);
		Port ( 
			i_CLK			: in  STD_LOGIC;
			i_RST			: in  STD_LOGIC;
			i_WE			: in  STD_LOGIC_VECTOR(3 DOWNTO 0);
			i_DATA		: in  STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
			i_SEL_RS1	: in  STD_LOGIC_VECTOR(1 DOWNTO 0);
			i_SEL_RS2	: in  STD_LOGIC_VECTOR(1 DOWNTO 0);
			o_RS1			: out STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);				
			o_RS2			: out STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0)	
		);
	end COMPONENT;

	COMPONENT ULA is
		Generic(
			p_DATA	: integer := 16
		);
		Port ( 
			i_SEL		: in  STD_LOGIC_VECTOR(2 DOWNTO 0);
			i_RS1		: in  STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
			i_RS2		: in  STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
			o_ULA		: out STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0)	
		);
	end COMPONENT;	
	
	signal w_RS1	:  STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
	signal w_RS2	:  STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
	signal w_ULA	:  STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
	signal w_DATA	:  STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
	
	COMPONENT REGISTRADOR is
		Generic(
			p_DATA	: integer := 16
		);
		Port ( 
			i_CLK		: in  STD_LOGIC;
			i_RST		: in  STD_LOGIC;
			i_WE		: in  STD_LOGIC;
			i_DATA	: in  STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
			o_DATA	: out STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0)	
		);
	end COMPONENT;
	
	component LED_7SEG IS
	GENERIC(
		p_Data	: INTEGER
	);
	PORT(
		I_CLK 	: IN  STD_LOGIC;
		i_rst 	: in  std_LOGIC;
		I_DATA	: IN  STD_LOGIC_VECTOR(p_Data - 1 DOWNTO 0);
		O_LED		: OUT STD_LOGIC_VECTOR(p_Data - 7 DOWNTO 0);
		O_LED7	: OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
	end COMPONENT;
	signal w_led :STD_LOGIC_VECTOR(p_Data-1 DOWNTO 0);
	
--==============================================================
begin
	
	W_DATA <= i_DATA WHEN (i_SEL_IMED = '0') ELSE w_ULA;
	
	U00 : BANCO_REGISTRADORES 
		 Generic Map (
			p_DATA		=> p_DATA
		 )
		 Port Map ( 
			i_CLK			=> i_CLK,
			i_RST			=> i_RST,
			i_WE			=> i_WE,
			i_DATA		=> W_DATA,
			i_SEL_RS1	=> i_sEL_RS1,
			i_SEL_RS2	=> i_SEL_RS2,
			o_RS1			=> w_RS1,
			o_RS2			=> w_RS2
		 );

	U01 : ULA 
		 Generic Map (
			p_DATA	=> p_DATA
		 )
		 Port Map ( 
			i_SEL		=> i_SEL_ULA,
			i_RS1		=> w_RS1,
			i_RS2		=> w_RS2,
			o_ULA		=> w_ULA
		 );	 

	u02 : REGISTRADOR 
   		Generic Map (
			p_DATA	=> p_DATA
	 	)
    	Port Map  ( 
			i_CLK		=> i_CLK,
			i_RST		=> i_RST,
			i_WE		=> i_EN_OUT,
			i_DATA	=> w_ULA,
			o_DATA	=> w_LED
	 	);
	
	led : LED_7SEG
		GENERIC map(
			p_Data	=> p_data
		)
		PORT map(
			I_CLK 	=> i_clk,
			i_rst		=> i_rst,
			I_DATA	=> w_led,
			O_LED		=> o_led,
			O_LED7	=> o_led7
		);

end Behavioral;