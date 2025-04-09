-- LEDController.VHD
-- 2025.03.09
--
-- This SCOMP peripheral drives ten outputs high or low based on
-- a value from SCOMP.

LIBRARY IEEE;
LIBRARY LPM;

USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE LPM.LPM_COMPONENTS.ALL;

ENTITY LEDController IS
PORT(
    CS          : IN  STD_LOGIC;
    WRITE_EN    : IN  STD_LOGIC;
    RESETN      : IN  STD_LOGIC;
	 LED_CLK     : IN  STD_LOGIC;
    LEDs        : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    IO_DATA     : IN  STD_LOGIC_VECTOR(14 DOWNTO 0);
	 FLASH_EN	 : IN  STD_LOGIC
    );
END LEDController;

ARCHITECTURE a OF LEDController IS
BEGIN
    PROCESS (RESETN, CS, WRITE_EN, IO_DATA, LED_CLK)
    BEGIN
        IF (RESETN = '0') THEN
            -- Turn off LEDs at reset (a nice usability feature)
            LEDs <= "0000000000";
        ELSIF (RISING_EDGE(CS)) THEN
            IF WRITE_EN = '1' THEN
				    CASE IO_DATA(7 DOWNTO 0) IS  -- only uses lower 8 bits
                    WHEN "01000001" => LEDs <= "1011000000"; --a
                    WHEN "01000010" => LEDs <= "1101010100"; --b
                    WHEN "01000011" => LEDs <= "1101011010"; --c
                    WHEN "01000100" => LEDs <= "1101010000"; --d
                    WHEN "01000101" => LEDs <= "1000000000"; --e
                    WHEN "01000110" => LEDs <= "1010110100"; --f
                    WHEN "01000111" => LEDs <= "1101101000"; --g
                    WHEN "01001000" => LEDs <= "1010101000"; --h
                    WHEN "01001001" => LEDs <= "1010000000"; --i
                    WHEN "01001010" => LEDs <= "1101101101"; --j
                    WHEN "01001011" => LEDs <= "1101011000"; --k
                    WHEN "01001100" => LEDs <= "1010110100"; --l
                    WHEN "01001101" => LEDs <= "1101100000"; --m
                    WHEN "01001110" => LEDs <= "1101000000"; --n
                    WHEN "01001111" => LEDs <= "1101101100"; --o
                    WHEN "01010000" => LEDs <= "1011011010"; --p
                    WHEN "01010001" => LEDs <= "1101101011"; --q
                    WHEN "01010010" => LEDs <= "1011010000"; --r
                    WHEN "01010011" => LEDs <= "1010100000"; --s
                    WHEN "01010100" => LEDs <= "1100000000"; --t
                    WHEN "01010101" => LEDs <= "1010110000"; --u
                    WHEN "01010110" => LEDs <= "1010101100"; --v
                    WHEN "01010111" => LEDs <= "1011011000"; --w
                    WHEN "01011000" => LEDs <= "1101010110"; --x
                    WHEN "01011001" => LEDs <= "1101011011"; --y
                    WHEN "01011010" => LEDs <= "1101101010"; --z
                    
                    WHEN "01100001" => LEDs <= "1011000000";
                    WHEN "01100010" => LEDs <= "1101010100";
                    WHEN "01100011" => LEDs <= "1101011010";
                    WHEN "01100100" => LEDs <= "1101010000";
                    WHEN "01100101" => LEDs <= "1000000000";
                    WHEN "01100110" => LEDs <= "1010110100";
                    WHEN "01100111" => LEDs <= "1101101000";
                    WHEN "01101000" => LEDs <= "1010101000";
                    WHEN "01101001" => LEDs <= "1010000000";
                    WHEN "01101010" => LEDs <= "1101101101";
                    WHEN "01101011" => LEDs <= "1101011000";
                    WHEN "01101100" => LEDs <= "1010110100";
                    WHEN "01101101" => LEDs <= "1101100000";
                    WHEN "01101110" => LEDs <= "1101000000";
                    WHEN "01101111" => LEDs <= "1101101100";
                    WHEN "01110000" => LEDs <= "1011011010";
                    WHEN "01110001" => LEDs <= "1101101011";
                    WHEN "01110010" => LEDs <= "1011010000";
                    WHEN "01110011" => LEDs <= "1010100000";
                    WHEN "01110100" => LEDs <= "1100000000";
                    WHEN "01110101" => LEDs <= "1010110000";
                    WHEN "01110110" => LEDs <= "1010101100";
                    WHEN "01110111" => LEDs <= "1011011000";
                    WHEN "01111000" => LEDs <= "1101010110";
                    WHEN "01111001" => LEDs <= "1101011011";
                    WHEN "01111010" => LEDs <= "1101101010";

                    WHEN OTHERS => LEDs <= "0000000000";
                END CASE;
			  END IF;
        END IF;
    END PROCESS;
END a;