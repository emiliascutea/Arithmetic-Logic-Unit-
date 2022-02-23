----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2021 03:56:05 PM
-- Design Name: 
-- Module Name: RegisterN - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL; 
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RegisterN is
  generic (n : natural);
  Port (clk : in std_logic;  
        rst : in std_logic;   
        enable : in std_logic;   
        data_in : in std_logic_vector(n-1 downto 0);   
        data_out : out std_logic_vector(n-1 downto 0));
end RegisterN;

architecture Behavioral of RegisterN is

begin
process(clk, rst, enable)
begin
    if rising_edge(clk) then
        if rst = '1' then
            data_out <= (others => '0');
        else
            if enable = '1' then
                data_out <= data_in;
            end if;
        end if;
    end if;
end process;

end Behavioral;
