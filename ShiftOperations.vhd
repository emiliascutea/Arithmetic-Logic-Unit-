----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2021 07:30:24 PM
-- Design Name: 
-- Module Name: LogicOperations - Behavioral
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

entity ShiftOperations is
  Port (a : in std_logic_vector(31 downto 0);
        b : in std_logic_vector(31 downto 0); 
        op : in std_logic_vector(3 downto 0); 
        result : out std_logic_vector(31 downto 0));
end ShiftOperations;

architecture Behavioral of ShiftOperations is

begin

process(op) 
begin
    case op is 
        when "1000" => -- SHIFT LEFT
            result <= a(30 downto 0) & '0';
        when "1001" => -- SHIFT RIGHT
            result <= '0' & a(31 downto 1);
        when "1010" => -- ROTATE LEFT
            result <= a(30 downto 0) & a(31);
        when others => -- ROTATE RIGHT 
            result <= a(0) & a(31 downto 1);
      end case;
end process;

end Behavioral;
