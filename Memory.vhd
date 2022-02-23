----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2021 07:35:19 PM
-- Design Name: 
-- Module Name: Memory - Behavioral
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
USE IEEE.std_logic_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Memory is
      Port (address1 : in std_logic_vector(2 downto 0);
            address2 : in std_logic_vector(2 downto 0);
            enable : in std_logic;
            clk: in std_logic;
            AA : out std_logic_vector(31 downto 0);
            RR : out std_logic_vector(31 downto 0));
end Memory;

architecture Behavioral of Memory is

type ram_array is array(0 to 7) of std_logic_vector(31 downto 0);
signal ram: ram_array :=(
--"00000000000000000000000000000110",
--"00000000000000000000000000000100",
--"00000000000000000000000000000100",
--"00000000000000000000000000000100",
--"00000000000000000000000000000100",
--"00000000000000000000000000000110",
--"00000000000000000000000000000100",
--"00000000000000000000000000000010");  

"00000000000000000000000000010000",
"00000000000000000000000000001110",
"00000000000000000000000000001100",
"00000000000000000000000000001010",
"00000000000000000000000000001000",
"00000000000000000000000000000110",
"00000000000000000000000000000100",
"00000000000000000000000000000010");  

begin

process(clk)
begin
    if rising_edge(clk) then
        if enable = '1' then
                AA <= ram(conv_integer(address1));
        end if;
        if enable = '1' then
                RR <= ram(conv_integer(address2));
         end if;
     end if;    
end process;


end Behavioral;

