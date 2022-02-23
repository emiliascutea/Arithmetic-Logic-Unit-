----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/29/2021 01:15:59 PM
-- Design Name: 
-- Module Name: Control - Behavioral
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

entity Control is
  Port (clk : in std_logic;
        op : in std_logic_vector(3 downto 0); 
        sendOp : out std_logic_vector(3 downto 0));
end Control;

architecture Behavioral of Control is

begin
process(clk)
begin
    if rising_edge(clk) then
        sendOp <= op;
    end if;
end process;

end Behavioral;
