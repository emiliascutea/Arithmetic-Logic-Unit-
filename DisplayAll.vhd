----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/06/2021 12:19:16 PM
-- Design Name: 
-- Module Name: SSD - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DisplayAll is
  port ( digit: in std_logic_vector(15 downto 0);
         clk: in std_logic;
         an: out std_logic_vector(3 downto 0);
         cat: out std_logic_vector(6 downto 0));
end DisplayAll;

architecture Behavioral of DisplayAll is

signal mux_out : std_logic_vector(3 downto 0);
signal counter : std_logic_vector(10 downto 0);
signal selection: std_logic_vector(1 downto 0);
begin

process(clk)
begin
    if rising_edge(clk) then
        counter <= counter + 1;
    end if;
end process;

selection <= counter(10 downto 9);

process(selection,digit)
begin
    case selection is -- despart numarul de 16 biti in cate 4 biti; 4 biti => 0 - F
        when "00" => mux_out <= digit(3 downto 0); 
        when "01" => mux_out <= digit(7 downto 4); 
        when "10" => mux_out <= digit(11 downto 8);
        when others => mux_out <= digit(15 downto 12);
    end case;
 end process;
 
process(selection)
begin
    case selection is
        when "00" => an <= "1110"; 
        when "01" => an <= "1101"; 
        when "10" => an <= "1011";
        when others => an <= "0111";
    end case;
 end process;
 
 process(mux_out)
 begin
    case mux_out is
    -- a b c d e f g
    -- g f e d c b a
        when "0000" => cat <= "1000000"; -- 0
        when "0001" => cat <= "1111001"; -- 1
        when "0010" => cat <= "0100100"; -- 2
        when "0011" => cat <= "0110000"; -- 3
        when "0100" => cat <= "0011011"; -- 4
        when "0101" => cat <= "0010010"; -- 5
        when "0110" => cat <= "0000010"; -- 6
        when "0111" => cat <= "1111000"; -- 7
        when "1000" => cat <= "0000000"; -- 8
        when "1001" => cat <= "0010000"; -- 9 
        when "1010" => cat <= "0001000"; -- A
        when "1011" => cat <= "0000011"; -- b
        when "1100" => cat <= "1000110"; -- C
        when "1101" => cat <= "0100001"; -- d
        when "1110" => cat <= "0000110"; -- E
        when "1111" => cat <= "0001110"; -- F
        when others => cat <= "1111111"; -- OTHERS
    end case;
end process;

end Behavioral;
