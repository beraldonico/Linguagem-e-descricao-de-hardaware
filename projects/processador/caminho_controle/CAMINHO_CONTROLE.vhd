LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.NUMERIC_STD.ALL;

ENTITY CAMINHO_CONTROLE IS
	GENERIC(
		P_DATA	: INTEGER	:= 16
	);
	PORT(
		I_CLK			:  IN STD_LOGIC;
		I_RST			:  IN STD_LOGIC;
		--			ACESSO A ROM		  --
		O_ADD			: OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
		I_INST		:  IN STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0);
		--			ACCESO AO CAMINHO DE DADOS			--
		O_WE			: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		O_DATA		: OUT STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0);
		O_SEL_RS1	: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		O_SEL_RS2	: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		O_SEL_ULA	: OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
		O_SEL_IMED	: OUT STD_LOGIC;
		O_EN_OUT		: OUT STD_LOGIC;
		O_LED			: OUT STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0)
	);
END ENTITY;

ARCHITECTURE BEHAVIORAL OF CAMINHO_CONTROLE IS
	TYPE STATE_TYPE IS (ST_FETCH, ST_EXECUTE);
	SIGNAL STATE : STATE_TYPE;

	COMPONENT BANCO_DE_REGISTRADORES IS
		GENERIC(
			P_DATA	: INTEGER := 8
		);
		PORT(
			I_CLK			:  IN STD_LOGIC;
			I_RST			:  IN STD_LOGIC;
			I_WE			:  IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			I_DATA		:  IN STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0);
			I_SEL_RS1	:	IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			I_SEL_RS2	:	IN STD_LOGIC_VECTOR(1 DOWNTO 0);
			O_RS1			: OUT STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0);
			O_RS2			: OUT STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0)
		);
	END COMPONENT;
	
	COMPONENT ULA IS
		GENERIC(
			P_DATA	:	INTEGER := 16
		);
		PORT(
			I_SEL	:  IN STD_LOGIC_VECTOR(2 DOWNTO 0);
			I_RS1	:  IN STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0);
			I_RS2	:  IN STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0);
			O_ULA	: OUT STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0)
		);
	END COMPONENT;
	
	SIGNAL W_RS1	: STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0);
	SIGNAL W_RS2	: STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0);
	SIGNAL W_ULA	: STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0);
	SIGNAL W_DATA	: STD_LOGIC_VECTOR(P_DATA - 1 DOWNTO 0);
	
	COMPONENT REGISTRADOR IS
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
	END COMPONENT;
	
BEGIN
	PROCESS(I_CLK, I_RST)
		VARIABLE V_CONT : STD_LOGIC_VECTOR(9 DOWNTO 0);
	BEGIN
		IF(I_RST = '0') THEN
			O_ADD			<= (OTHERS => '0');
		   O_WE			<= (OTHERS => '1');
		   O_DATA		<= (OTHERS => '0');
		   O_SEL_RS1	<= (OTHERS => '0');
		   O_SEL_RS2	<= (OTHERS => '0');
		   O_SEL_ULA	<= (OTHERS => '0');
		   O_SEL_IMED	<= '0';
			O_EN_OUT		<= '1';
			V_CONT 		:= (OTHERS => '0');
			STATE <= ST_FETCH;
		ELSIF FALLING_EDGE (I_CLK) THEN
			CASE STATE IS
				WHEN ST_FETCH 		=>
					--STOP--
					IF(I_INST(P_DATA - 1 DOWNTO P_DATA - 4) = X"0") THEN
						STATE <= ST_FETCH;
					--LDI--
					ELSIF(I_INST(P_DATA - 1 DOWNTO P_DATA - 4) = X"1") THEN
						IF (I_INST(P_DATA - 5 DOWNTO P_DATA - 6) = "00") THEN
							O_WE <= "1110";
						ELSIF (I_INST(P_DATA - 5 DOWNTO P_DATA - 6) = "01") THEN
							O_WE <= "1101";
						ELSIF (I_INST(P_DATA - 5 DOWNTO P_DATA - 6) = "10") THEN
							O_WE <= "1011";
						ELSIF (I_INST(P_DATA - 5 DOWNTO P_DATA - 6) = "11") THEN
							O_WE <= "0111";
						END IF;
						STATE <= ST_EXECUTE;
					--ADD--
					ELSIF(I_INST(P_DATA - 1 DOWNTO P_DATA - 4) = X"2") THEN
						O_SEL_RS1 <= I_INST(P_DATA - 5 DOWNTO P_DATA - 6);
						O_SEL_RS2 <= I_INST(P_DATA - 7 DOWNTO P_DATA - 8);
						IF (I_INST(P_DATA - 9 DOWNTO P_DATA - 10) = "00") THEN
							O_WE <= "1110";
						ELSIF (I_INST(P_DATA - 9 DOWNTO P_DATA - 10) = "01") THEN
							O_WE <= "1101";
						ELSIF (I_INST(P_DATA - 9 DOWNTO P_DATA - 10) = "10") THEN
							O_WE <= "1011";
						ELSIF (I_INST(P_DATA - 9 DOWNTO P_DATA - 10) = "11") THEN
							O_WE <= "0111";
						END IF;
						O_SEL_IMED <= '1';
						O_SEL_ULA <= "000";
						STATE <= ST_FETCH;
					--SUB--
					ELSIF(I_INST(P_DATA - 1 DOWNTO P_DATA - 4) = X"3") THEN
						O_SEL_RS1 <= I_INST(P_DATA - 5 DOWNTO P_DATA - 6);
						O_SEL_RS2 <= I_INST(P_DATA - 7 DOWNTO P_DATA - 8);
						IF (I_INST(P_DATA - 9 DOWNTO P_DATA - 10) = "00") THEN
							O_WE <= "1110";
						ELSIF (I_INST(P_DATA - 9 DOWNTO P_DATA - 10) = "01") THEN
							O_WE <= "1101";
						ELSIF (I_INST(P_DATA - 9 DOWNTO P_DATA - 10) = "10") THEN
							O_WE <= "1011";
						ELSIF (I_INST(P_DATA - 9 DOWNTO P_DATA - 10) = "11") THEN
							O_WE <= "0111";
						END IF;
						O_SEL_IMED <= '1';
						O_SEL_ULA <= "001";
						STATE <= ST_FETCH;
					--OUT--
					ELSIF(I_INST(P_DATA - 1 DOWNTO P_DATA - 4) = X"4") THEN
						O_EN_OUT <= '0';
						STATE <= ST_EXECUTE;
					END IF;
				WHEN ST_EXECUTE 	=>
					O_WE <= "1111";
					O_EN_OUT <= '1';
					V_CONT := V_CONT + 1;
					O_ADD <= V_CONT;
					STATE <= ST_FETCH;
				WHEN OTHERS 		=>
					STATE <= ST_FETCH;
			END CASE;
		END IF;
	END PROCESS;


END ARCHITECTURE;