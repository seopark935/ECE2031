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
    LEDs        : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
    IO_DATA     : IN  STD_LOGIC_VECTOR(15 DOWNTO 0)
    );
END LEDController;

ARCHITECTURE a OF LEDController IS
    SIGNAL morse_pattern       : STD_LOGIC_VECTOR(9 DOWNTO 0) := (OTHERS => '0');
    SIGNAL bit_index        : INTEGER RANGE 0 TO 10 := 0;
    SIGNAL reset_index      : STD_LOGIC := '0';  -- ONLY assigned in LED_CLK process
    SIGNAL reset_index_flag : STD_LOGIC := '0';  -- asserted in CS process
    SIGNAL flash_mode       : STD_LOGIC := '0';
    SIGNAL ascii_val        : STD_LOGIC_VECTOR(7 DOWNTO 0) := (OTHERS => '0');
BEGIN
<<<<<<< Updated upstream
    PROCESS (RESETN, CS)
    BEGIN
        IF (RESETN = '0') THEN
            -- Turn off LEDs at reset (a nice usability feature)
            LEDs <= "0000000000";
        ELSIF (RISING_EDGE(CS)) THEN
            IF WRITE_EN = '1' THEN
                -- If SCOMP is sending data to this peripheral,
                -- use that data directly as the on/off values
                -- for the LEDs.
                LEDs <= IO_DATA(9 DOWNTO 0);
=======

    -- Process 1: Latch new character and Morse code
    PROCESS (RESETN, CS)
    BEGIN
        IF RESETN = '0' THEN
            morse_pattern        <= (OTHERS => '0');
            ascii_val         <= (OTHERS => '0');
            reset_index_flag  <= '0';
        ELSIF RISING_EDGE(CS) THEN
            IF WRITE_EN = '1' THEN
                ascii_val <= IO_DATA(7 DOWNTO 0);
                CASE IO_DATA(7 DOWNTO 0) IS
							  WHEN "01000001" => morse_pattern <= "1011000000"; --a
							  WHEN "01000010" => morse_pattern <= "1101010100"; --b
							  WHEN "01000011" => morse_pattern <= "1101011010"; --c
							  WHEN "01000100" => morse_pattern <= "1101010000"; --d
							  WHEN "01000101" => morse_pattern <= "1000000000"; --e
							  WHEN "01000110" => morse_pattern <= "1010110100"; --f
							  WHEN "01000111" => morse_pattern <= "1101101000"; --g
							  WHEN "01001000" => morse_pattern <= "1010101000"; --h
							  WHEN "01001001" => morse_pattern <= "1010000000"; --i
							  WHEN "01001010" => morse_pattern <= "1101101101"; --j
							  WHEN "01001011" => morse_pattern <= "1101011000"; --k
							  WHEN "01001100" => morse_pattern <= "1010110100"; --l
							  WHEN "01001101" => morse_pattern <= "1101100000"; --m
							  WHEN "01001110" => morse_pattern <= "1101000000"; --n
							  WHEN "01001111" => morse_pattern <= "1101101100"; --o
							  WHEN "01010000" => morse_pattern <= "1011011010"; --p
							  WHEN "01010001" => morse_pattern <= "1101101011"; --q
							  WHEN "01010010" => morse_pattern <= "1011010000"; --r
							  WHEN "01010011" => morse_pattern <= "1010100000"; --s
							  WHEN "01010100" => morse_pattern <= "1100000000"; --t
							  WHEN "01010101" => morse_pattern <= "1010110000"; --u
							  WHEN "01010110" => morse_pattern <= "1010101100"; --v
							  WHEN "01010111" => morse_pattern <= "1011011000"; --w
							  WHEN "01011000" => morse_pattern <= "1101010110"; --x
							  WHEN "01011001" => morse_pattern <= "1101011011"; --y
							  WHEN "01011010" => morse_pattern <= "1101101010"; --z
							  
							  WHEN "01100001" => morse_pattern <= "1011000000";
							  WHEN "01100010" => morse_pattern <= "1101010100";
							  WHEN "01100011" => morse_pattern <= "1101011010";
							  WHEN "01100100" => morse_pattern <= "1101010000";
							  WHEN "01100101" => morse_pattern <= "1000000000";
							  WHEN "01100110" => morse_pattern <= "1010110100";
							  WHEN "01100111" => morse_pattern <= "1101101000";
							  WHEN "01101000" => morse_pattern <= "1010101000";
							  WHEN "01101001" => morse_pattern <= "1010000000";
							  WHEN "01101010" => morse_pattern <= "1101101101";
							  WHEN "01101011" => morse_pattern <= "1101011000";
							  WHEN "01101100" => morse_pattern <= "1010110100";
							  WHEN "01101101" => morse_pattern <= "1101100000";
							  WHEN "01101110" => morse_pattern <= "1101000000";
							  WHEN "01101111" => morse_pattern <= "1101101100";
							  WHEN "01110000" => morse_pattern <= "1011011010";
							  WHEN "01110001" => morse_pattern <= "1101101011";
							  WHEN "01110010" => morse_pattern <= "1011010000";
							  WHEN "01110011" => morse_pattern <= "1010100000";
							  WHEN "01110100" => morse_pattern <= "1100000000";
							  WHEN "01110101" => morse_pattern <= "1010110000";
							  WHEN "01110110" => morse_pattern <= "1010101100";
							  WHEN "01110111" => morse_pattern <= "1011011000";
							  WHEN "01111000" => morse_pattern <= "1101010110";
							  WHEN "01111001" => morse_pattern <= "1101011011";
							  WHEN "01111010" => morse_pattern <= "1101101010";

							  WHEN OTHERS => morse_pattern <= (OTHERS => '0');
                END CASE;
                reset_index_flag <= '1';  -- set flag on new data
>>>>>>> Stashed changes
            END IF;
        END IF;
    END PROCESS;

    -- Process 2: Flash LED bit by bit
    PROCESS (RESETN, LED_CLK)
    BEGIN
        IF RESETN = '0' THEN
            LEDs           <= (OTHERS => '0');
            bit_index      <= 0;
            reset_index    <= '0';
        ELSIF RISING_EDGE(LED_CLK) THEN
            IF reset_index_flag = '1' THEN
                bit_index     <= 0;
                reset_index   <= '1';  -- latch internal reset for one cycle
            ELSIF reset_index = '1' THEN
                reset_index   <= '0';  -- clear after one cycle
            ELSIF FLASH_EN = '1' THEN
                IF bit_index < 10 THEN
                    LEDs(0) <= morse_pattern(bit_index);
                    LEDs(9 DOWNTO 1) <= (OTHERS => '0');
                    bit_index <= bit_index + 1;
                ELSE
                    LEDs <= (OTHERS => '0');  -- done with this character
                END IF;
            ELSE
                LEDs <= morse_pattern;
            END IF;
        END IF;
    END PROCESS;

END a;