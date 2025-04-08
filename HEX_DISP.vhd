LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;

-- Hexadecimal to 7 Segment Decoder for LED Display
--  1) when free held low, displays latched data
--  2) when free held high, constantly displays input (free-run)
--  3) data is latched on rising edge of CS

ENTITY HEX_DISP IS
  PORT( hex_val  : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
        cs       : IN STD_LOGIC := '0';
        free     : IN STD_LOGIC := '0';
        resetn   : IN STD_LOGIC := '1';
        segments : OUT STD_LOGIC_VECTOR(6 DOWNTO 0));
END HEX_DISP;

ARCHITECTURE a OF HEX_DISP IS
  SIGNAL latched_hex : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL hex_d       : STD_LOGIC_VECTOR(3 DOWNTO 0);

BEGIN

  PROCESS (resetn, cs)
  BEGIN
    IF (resetn = '0') THEN
      latched_hex <= "0000";
    ELSIF ( RISING_EDGE(cs) ) THEN
      latched_hex <= hex_val;
    END IF;
  END PROCESS;
  
  WITH free SELECT
    hex_d  <= latched_hex WHEN '0',
              hex_val     WHEN '1';
           
  WITH hex_d SELECT
    segments <= "1000000" WHEN "0000",
                "1111001" WHEN "0001",
                "0100100" WHEN "0010",
                "0110000" WHEN "0011",
                "0011001" WHEN "0100",
                "0010010" WHEN "0101",
                "0000010" WHEN "0110",
                "1111000" WHEN "0111",
                "0000000" WHEN "1000",
                "0010000" WHEN "1001", 
                "0001000" WHEN "1010",
                "0000011" WHEN "1011", 
                "1000110" WHEN "1100", 
                "0100001" WHEN "1101", 
                "0000110" WHEN "1110", 
                "0001110" WHEN "1111",

                "0001000" WHEN "01000001";
                "1100000" WHEN "01000010";
                "0110001" WHEN "01000011";
                "1000010" WHEN "01000100";
                "0110000" WHEN "01000101";
                "0111000" WHEN "01000110";
                "0000100" WHEN "01000111";
                "1001000" WHEN "01001000";
                "1001111" WHEN "01001001";
                "1000111" WHEN "01001010";
                "1111000" WHEN "01001011";
                "1110001" WHEN "01001100";
                "0101011" WHEN "01001101";
                "0001001" WHEN "01001110";
                "0000001" WHEN "01001111";
                "0011000" WHEN "01010000";
                "0001100" WHEN "01010001";
                "0111001" WHEN "01010010";
                "0100100" WHEN "01010011";
                "1110000" WHEN "01010100";
                "1000001" WHEN "01010101";
                "1100011" WHEN "01010110";
                "1010101" WHEN "01010111";
                "1001110" WHEN "01011000";
                "1000100" WHEN "01011001";
                "0100010" WHEN "01011010";

                "0001000" WHEN "01100001";
                "1100000" WHEN "01100010";
                "0110001" WHEN "01100011";
                "1000010" WHEN "01100100";
                "0110000" WHEN "01100101";
                "0111000" WHEN "01100110";
                "0000100" WHEN "01100111";
                "1001000" WHEN "01101000";
                "1001111" WHEN "01101001";
                "1000111" WHEN "01101010";
                "1111000" WHEN "01101011";
                "1110001" WHEN "01101100";
                "0101011" WHEN "01101101";
                "0001001" WHEN "01101110";
                "0000001" WHEN "01101111";
                "0011000" WHEN "01110000";
                "0001100" WHEN "01110001";
                "0111001" WHEN "01110010";
                "0100100" WHEN "01110011";
                "1110000" WHEN "01110100";
                "1000001" WHEN "01110101";
                "1100011" WHEN "01110110";
                "1010101" WHEN "01110111";
                "1001110" WHEN "01111000";
                "1000100" WHEN "01111001";
                "0100010" WHEN "01111010";

                "0111111" WHEN OTHERS;
END a;

