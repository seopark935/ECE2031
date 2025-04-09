LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

-- Hexadecimal to 7 Segment Decoder for LED Display
--  1) when free held low, displays latched data
--  2) when free held high, constantly displays input (free-run)
--  3) data is latched on rising edge of CS

ENTITY HEX_DISP IS PORT( 
		  hex_val  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        cs       : IN STD_LOGIC := '0';
        free     : IN STD_LOGIC := '0';
        resetn   : IN STD_LOGIC := '1';
        segments : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END HEX_DISP;

ARCHITECTURE a OF HEX_DISP IS
  SIGNAL latched_hex : STD_LOGIC_VECTOR(7 DOWNTO 0);
  SIGNAL hex_d       : STD_LOGIC_VECTOR(7 DOWNTO 0);

BEGIN

  PROCESS (resetn, cs)
  BEGIN
    IF (resetn = '0') THEN
      latched_hex <= "00000000";
    ELSIF ( RISING_EDGE(cs) ) THEN
      latched_hex <= hex_val;
    END IF;
  END PROCESS;
  
  WITH free SELECT
    hex_d  <= latched_hex WHEN '0',
              hex_val     WHEN '1';
           
  WITH hex_d SELECT
    segments <= "0100000" WHEN "01000001", -- a
                "0000011" WHEN "01000010", -- b
                "0100111" WHEN "01000011", -- c
                "0100001" WHEN "01000100", -- d
                "0000110" WHEN "01000101", -- e
                "0001110" WHEN "01000110", -- f
                "1000010" WHEN "01000111", -- g
                "0001011" WHEN "01001000", -- h
                "1101110" WHEN "01001001", -- i
                "1110010" WHEN "01001010", -- j
                "0001010" WHEN "01001011", -- k
                "1000111" WHEN "01001100", -- l
                "0101010" WHEN "01001101", -- m
                "0101011" WHEN "01001110", -- n
                "0100011" WHEN "01001111", -- o
                "0001100" WHEN "01010000", -- p
                "0011000" WHEN "01010001", -- q
                "0101111" WHEN "01010010", -- r
                "1010010" WHEN "01010011", -- s
                "0000111" WHEN "01010100", -- t
                "1100011" WHEN "01010101", -- u
                "1010101" WHEN "01010110", -- v
                "0010101" WHEN "01010111", -- w
                "1101011" WHEN "01011000", -- x
                "0010001" WHEN "01011001", -- y
                "1100100" WHEN "01011010", -- z
					 
                "0001000" WHEN "01100001", -- a
                "1100000" WHEN "01100010",
                "0110001" WHEN "01100011",
                "1000010" WHEN "01100100",
                "0110000" WHEN "01100101",
                "0111000" WHEN "01100110",
                "0000100" WHEN "01100111",
                "1001000" WHEN "01101000",
                "1001111" WHEN "01101001",
                "1000111" WHEN "01101010",
                "1111000" WHEN "01101011",
                "1110001" WHEN "01101100",
                "0101011" WHEN "01101101",
                "0001001" WHEN "01101110",
                "0000001" WHEN "01101111",
                "0011000" WHEN "01110000",
                "0001100" WHEN "01110001",
                "0111001" WHEN "01110010",
                "0100100" WHEN "01110011",
                "1110000" WHEN "01110100",
                "1000001" WHEN "01110101",
                "1100011" WHEN "01110110",
                "1010101" WHEN "01110111",
                "1001110" WHEN "01111000",
                "1000100" WHEN "01111001",
                "0100010" WHEN "01111010",
                "0111111" WHEN OTHERS;
END a;

