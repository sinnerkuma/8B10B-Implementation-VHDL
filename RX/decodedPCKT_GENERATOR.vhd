LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY decodedPCKT_GENERATOR IS
	PORT (ABCDE 	: IN 	STD_LOGIC_VECTOR(4 DOWNTO 0);
			FGH 		: IN 	STD_LOGIC_VECTOR(2 DOWNTO 0);
			BYTECLK	: IN 	STD_LOGIC;
			ABCDEGH	: OUT STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
			readyRX	: OUT STD_LOGIC := '0';
			RESET		: IN	STD_LOGIC
			);
END ENTITY decodedPCKT_GENERATOR;

ARCHITECTURE BEHV OF decodedPCKT_GENERATOR IS
SIGNAL COUNTER 	: INTEGER := 0;
SIGNAL FGH_SIGNAL	: STD_LOGIC_VECTOR(2 DOWNTO 0);
BEGIN
	PROCESS(BYTECLK)
	BEGIN
		IF RESET = '1' THEN
			COUNTER <= 0;
			ABCDEGH(7 DOWNTO 0) <= (OTHERS => '0');
			readyRX <= '0';
			
		ELSIF RISING_EDGE(BYTECLK) THEN
			COUNTER <= COUNTER + 1;
			FGH_SIGNAL <= FGH;
			IF COUNTER >= 7 THEN
				readyRX <= '1';
				ABCDEGH(7 DOWNTO 0) <= ABCDE & FGH_SIGNAL;
			END IF;
		END IF;
	END PROCESS;
END ARCHITECTURE BEHV;