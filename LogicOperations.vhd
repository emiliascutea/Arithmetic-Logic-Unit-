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

entity LogicOperations is
  Port (a : in std_logic_vector(31 downto 0);
        b : in std_logic_vector(31 downto 0); 
        op : in std_logic_vector(3 downto 0); 
        result : out std_logic_vector(31 downto 0));
end LogicOperations;

architecture Behavioral of LogicOperations is

begin

process(op) 
begin
    case op is
        when "0101" => -- AND
            result <= a AND b;
        when "0110" => --OR
            result <= a OR b; 
        when others => -- NOT
            result <= NOT a; 
      end case;
end process;

end Behavioral;
