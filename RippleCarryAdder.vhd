----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2021 01:15:47 PM
-- Design Name: 
-- Module Name: RippleCarryAdder - Behavioral
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

entity RippleCarryAdder is
  Port (x : in std_logic_vector(31 downto 0); 
        y : in std_logic_vector(31 downto 0); 
        sel : in std_logic_vector(3 downto 0); 
        sum : out std_logic_vector(31 downto 0); 
        cout : out std_logic);
end RippleCarryAdder;

architecture Behavioral of RippleCarryAdder is

component FullAdder is
  Port (x : in std_logic; 
        y : in std_logic; 
        cin :in std_logic; 
        sum : out std_logic; 
        cout : out std_logic);
end component;

component TwoComplement is
  generic(n : natural);
  Port (input : in std_logic_vector(n-1 downto 0); 
        output : out std_logic_vector(n-1 downto 0));
end component;

constant ZERO : std_logic_vector(31 downto 0) := (others => '0');
signal carry : std_logic_vector(31 downto 0);
signal secondOperand : std_logic_vector(31 downto 0) := (others => '0');
signal subtractionOperand : std_logic_vector(31 downto 0);
signal incrementOperand : std_logic_vector(31 downto 0) := ZERO(31 downto 1) & '1';
signal decrementOperand : std_logic_vector(31 downto 0) := (others => '1');

begin

TwoCompl : TwoComplement generic map(n => 32)
                         port map (input => y, output => subtractionOperand); 


process(sel)
begin
    case sel is
        when "0001" => -- ADD 
            secondOperand <= y; 
        when "0010" => -- SUB
            secondOperand <= subtractionOperand;
        when "0011" => -- INC
            secondOperand <= incrementOperand;
        when others => -- DEC
            secondOperand <= decrementOperand;
    end case;
end process;
               
                
FA0 : FullAdder port map(x => x(0), y => secondOperand(0), cin => '0', sum => sum(0), cout => carry(0));
FA1 : FullAdder port map(x => x(1), y => secondOperand(1), cin => carry(0), sum => sum(1), cout => carry(1));
FA2 : FullAdder port map(x => x(2), y => secondOperand(2), cin => carry(1), sum => sum(2), cout => carry(2));
FA3 : FullAdder port map(x => x(3), y => secondOperand(3), cin => carry(2), sum => sum(3), cout => carry(3));
FA4 : FullAdder port map(x => x(4), y => secondOperand(4), cin => carry(3), sum => sum(4), cout => carry(4));
FA5 : FullAdder port map(x => x(5), y => secondOperand(5), cin => carry(4), sum => sum(5), cout => carry(5));
FA6 : FullAdder port map(x => x(6), y => secondOperand(6), cin => carry(5), sum => sum(6), cout => carry(6));
FA7 : FullAdder port map(x => x(7), y => secondOperand(7), cin => carry(6), sum => sum(7), cout => carry(7));
FA8 : FullAdder port map(x => x(8), y => secondOperand(8), cin => carry(7), sum => sum(8), cout => carry(8));
FA9 : FullAdder port map(x => x(9), y => secondOperand(9), cin => carry(8), sum => sum(9), cout => carry(9));
FA10 : FullAdder port map(x => x(10), y => secondOperand(10), cin => carry(9), sum => sum(10), cout => carry(10));
FA11 : FullAdder port map(x => x(11), y => secondOperand(11), cin => carry(10), sum => sum(11), cout => carry(11));
FA12 : FullAdder port map(x => x(12), y => secondOperand(12), cin => carry(11), sum => sum(12), cout => carry(12));
FA13 : FullAdder port map(x => x(13), y => secondOperand(13), cin => carry(12), sum => sum(13), cout => carry(13));
FA14 : FullAdder port map(x => x(14), y => secondOperand(14), cin => carry(13), sum => sum(14), cout => carry(14));
FA15 : FullAdder port map(x => x(15), y => secondOperand(15), cin => carry(14), sum => sum(15), cout => carry(15));
FA16 : FullAdder port map(x => x(16), y => secondOperand(16), cin => carry(15), sum => sum(16), cout => carry(16));
FA17 : FullAdder port map(x => x(17), y => secondOperand(17), cin => carry(16), sum => sum(17), cout => carry(17));
FA18 : FullAdder port map(x => x(18), y => secondOperand(18), cin => carry(17), sum => sum(18), cout => carry(18));
FA19 : FullAdder port map(x => x(19), y => secondOperand(19), cin => carry(18), sum => sum(19), cout => carry(19));
FA20 : FullAdder port map(x => x(20), y => secondOperand(20), cin => carry(19), sum => sum(20), cout => carry(20));
FA21 : FullAdder port map(x => x(21), y => secondOperand(21), cin => carry(20), sum => sum(21), cout => carry(21));
FA22 : FullAdder port map(x => x(22), y => secondOperand(22), cin => carry(21), sum => sum(22), cout => carry(22));
FA23 : FullAdder port map(x => x(23), y => secondOperand(23), cin => carry(22), sum => sum(23), cout => carry(23));
FA24 : FullAdder port map(x => x(24), y => secondOperand(24), cin => carry(23), sum => sum(24), cout => carry(24));
FA25 : FullAdder port map(x => x(25), y => secondOperand(25), cin => carry(24), sum => sum(25), cout => carry(25));
FA26 : FullAdder port map(x => x(26), y => secondOperand(26), cin => carry(25), sum => sum(26), cout => carry(26));
FA27 : FullAdder port map(x => x(27), y => secondOperand(27), cin => carry(26), sum => sum(27), cout => carry(27));
FA28 : FullAdder port map(x => x(28), y => secondOperand(28), cin => carry(27), sum => sum(28), cout => carry(28));
FA29 : FullAdder port map(x => x(29), y => secondOperand(29), cin => carry(28), sum => sum(29), cout => carry(29));
FA30 : FullAdder port map(x => x(30), y => secondOperand(30), cin => carry(29), sum => sum(30), cout => carry(30));
FA31 : FullAdder port map(x => x(31), y => secondOperand(31), cin => carry(30), sum => sum(31), cout => cout);

end Behavioral;