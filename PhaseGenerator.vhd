----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/01/2021 08:10:01 PM
-- Design Name: 
-- Module Name: PhaseGenerator - Behavioral
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

entity PhaseGenerator is
    Port ( clk : in std_logic;
           rst : in std_logic;
           address1 : out std_logic_vector (2 downto 0);
           address2 : out std_logic_vector (2 downto 0));
end PhaseGenerator;

architecture Behavioral of PhaseGenerator is

signal counter1 : std_logic_vector(2 downto 0) :="000";
signal counter2 : std_logic_vector(2 downto 0) :="111";

begin
process(clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            if counter1 = "111" then 
                counter1 <= "000";
            else 
                counter1 <= counter1 + 1;
            end if;
            
            if counter2 = "000" then
                counter2 <= "111";
            else
                counter2 <= counter2 -1;
            end if;
        end if;
    end if;
end process;

address1 <= counter1;
address2 <= counter2;

end Behavioral;
