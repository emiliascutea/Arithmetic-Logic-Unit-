----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2021 04:12:34 PM
-- Design Name: 
-- Module Name: ShiftRegisterN - Behavioral
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

entity ShiftRegisterN is
  Port (clk : in std_logic;  
        rst : in std_logic; 
        enable : in std_logic; 
        shiftBit : in std_logic;  
        load : in std_logic;
        data_in : in std_logic_vector(31 downto 0);  
        data_out : out std_logic_vector(31 downto 0));
end ShiftRegisterN;

architecture Behavioral of ShiftRegisterN is

signal output : std_logic_vector(31 downto 0);
begin

process(clk, rst, load, enable)
begin
    if rising_edge(clk) then
        if rst = '1' then
            output <= ( others => '0');
        else
            if load = '1' then
                output <= data_in;
            else
                if enable = '1' then
                    output <= shiftBit & output(31 downto 1);
                end if;
            end if;
        end if;
    end if;
end process;

data_out <= output;

end Behavioral;
