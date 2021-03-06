library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity BANCO_REGISTRADORES is
    Generic(
				p_DATA	: integer := 8
	 );
    Port ( 
				i_CLK			: in  STD_LOGIC;
			   i_RST   		: in  STD_LOGIC;
				i_WE			: in  STD_LOGIC_VECTOR(3 DOWNTO 0);
				i_DATA		: in  STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);
				i_SEL_RS1	: in  STD_LOGIC_VECTOR(1 DOWNTO 0);
				i_SEL_RS2	: in  STD_LOGIC_VECTOR(1 DOWNTO 0);
            o_RS1    	: out STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0);				
            o_RS2    	: out STD_LOGIC_VECTOR(p_DATA-1 DOWNTO 0)	
	 );
end BANCO_REGISTRADORES;


architecture Behavioral of BANCO_REGISTRADORES is
--==============================================================

	COMPONENT REGISTRADOR is
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
	end COMPONENT;
	
	comPONENT MULTIPLEXADOR is
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
	end comPONENT;

	signal w_DOUT0 	: std_LOGIC_VECTOR(p_DATA-1 downto 0);
	signal w_DOUT1 	: std_LOGIC_VECTOR(p_DATA-1 downto 0);
	signal w_DOUT2 	: std_LOGIC_VECTOR(p_DATA-1 downto 0);
	signal w_DOUT3 	: std_LOGIC_VECTOR(p_DATA-1 downto 0);
	
--==============================================================
begin
	--
	-- Banco de registradores.
	--
	UR0 : REGISTRADOR 
		 Generic Map(
						p_DATA	=> p_DATA
		 )
		 Port Map( 
						i_CLK		=> i_CLK,
						i_RST   	=> i_RST,
						i_WE		=> i_WE(0),
						i_DATA	=> i_DATA,
						o_DATA	=> w_DOUT0
		 );
	
	UR1 : REGISTRADOR 
		 Generic Map(
						p_DATA	=> p_DATA
		 )
		 Port Map( 
						i_CLK		=> i_CLK,
						i_RST   	=> i_RST,
						i_WE		=> i_WE(1),
						i_DATA	=> i_DATA,
						o_DATA	=> w_DOUT1
		 );
	
	UR2 : REGISTRADOR 
		 Generic Map(
						p_DATA	=> p_DATA
		 )
		 Port Map( 
						i_CLK		=> i_CLK,
						i_RST   	=> i_RST,
						i_WE		=> i_WE(2),
						i_DATA	=> i_DATA,
						o_DATA	=> w_DOUT2
		 );
	
	UR3 : REGISTRADOR 
		 Generic Map(
						p_DATA	=> p_DATA
		 )
		 Port Map( 
						i_CLK		=> i_CLK,
						i_RST   	=> i_RST,
						i_WE		=> i_WE(3),
						i_DATA	=> i_DATA,
						o_DATA	=> w_DOUT3
		 );
--
-- Multiplexadores.
--
	MUX1 : MULTIPLEXADOR 
    Generic Map(
					p_DATA => p_DATA
	 )
    Port Map( 
				i_SEL		=> i_SEL_RS1,
				i_DATA0	=> w_DOUT0,
				i_DATA1	=> w_DOUT1,
				i_DATA2	=> w_DOUT2,
				i_DATA3	=> w_DOUT3,
            o_DATA	=> o_RS1
	 );	

	MUX2 : MULTIPLEXADOR 
    Generic Map(
					p_DATA => p_DATA
	 )
    Port Map( 
				i_SEL		=> i_SEL_RS2,
				i_DATA0	=> w_DOUT0,
				i_DATA1	=> w_DOUT1,
				i_DATA2	=> w_DOUT2,
				i_DATA3	=> w_DOUT3,
            o_DATA	=> o_RS2
	 );		 
end Behavioral;