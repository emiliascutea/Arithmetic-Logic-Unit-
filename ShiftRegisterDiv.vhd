----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2021 12:27:57 PM
-- Design Name: 
-- Module Name: ShiftRegisterA - Behavioral
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

entity ShiftRegisterDiv is
  generic(n : natural);
  Port (clk : in std_logic;
        rst : in std_logic;
        enable : in std_logic;
        shiftBit : in std_logic;
        shift : in std_logic;
        data_in : in std_logic_vector(n-1 downto 0);
        data_out : out std_logic_vector(n-1 downto 0) );
end ShiftRegisterDiv;

architecture Behavioral of ShiftRegisterDiv is
signal output : std_logic_vector(n-1 downto 0);

begin
process(clk)
begin
    if rising_edge(clk) then
        if rst = '1' then
            output <= (others => '0');
        else
            if enable = '1' then
                output <= data_in;
            else
                if shift = '1' then
                    output <= output(n-2 downto 0) & shiftBit;
                end if;
            end if;
        end if;
    end if;
end process;

data_out <= output;

end Behavioral;
