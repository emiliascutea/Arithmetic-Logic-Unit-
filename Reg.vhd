----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/29/2021 01:22:05 PM
-- Design Name: 
-- Module Name: Reg - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Reg is
  Port (clk : in std_logic;
        enable : in std_logic;
        regIn : in std_logic_vector(31 downto 0);
        regOut : out std_logic_vector(31 downto 0));
end Reg;

architecture Behavioral of Reg is

signal output : std_logic_vector(31 downto 0);
begin
process(clk, enable)
begin
    if rising_edge(clk) then
        if enable = '1' then
            output <= regIn;  
        end if;
    end if;
end process;

regOut <= output;
end Behavioral;
