----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2021 01:00:14 PM
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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

entity ControlUnit_Div is
  Port (clk : in std_logic;
        rst : in std_logic;
        init : in std_logic;
        A32 : in std_logic;
        LoadA, LoadM, LoadQ : out std_logic;
        shiftBit : out std_logic;
        Shift_A : out std_logic;
        Shift_Q : out std_logic;
        SubA : out std_logic;
        AddA : out std_logic;
        done : out std_logic;
        RstA : out std_logic);
end ControlUnit_Div;

architecture Behavioral of ControlUnit_Div is

type states is (Start, Initialize, ShiftA, ShiftQ0, ShiftQ1,Subtract, CheckSign, Add, CheckN, Stop);
signal state : states := Start;

signal terminated : std_logic := '0';
signal count : natural := 32;
begin

process(clk)
begin
    if clk'event and clk = '1' then
        if rst = '1' then
            state <= Start;
        else
            case state is
                when Start => 
                    if init = '1' then
                        state <= Initialize;
                    end if;
                when Initialize => state <= ShiftA;
                when ShiftA => state <= Subtract;
                when Subtract => state <= CheckSign;
                when CheckSign =>
                    if A32 = '1' then
                        state <= ShiftQ0;
                    else
                        state <= ShiftQ1;
                    end if;
                when ShiftQ0 =>
                    state <= Add;
                when ShiftQ1 =>
                    state <= CheckN;
                when Add => state <= CheckN;
                when CheckN =>
                    if count = 0 then
                        state <= Stop;
                    else
                        state <= ShiftA;
                    end if;
                when Stop => terminated <= '1'; 
            end case;
        end if;
    end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
        if state = Start then
            count <= 32;
        else
            if state = CheckSign then
                count <= count - 1;
            end if;
        end if;
    end if;
end process;

done <= terminated;
LoadA <= '1' when (state = Add or state = Subtract) else '0';
LoadM <= '1' when (state = Initialize) else '0';
LoadQ <= '1' when (state = Initialize) else '0';
RstA <= '1' when (state = Initialize) else '0';
AddA <= '1' when (state = Add) else '0';
SubA <= '1' when (state = Subtract) else '0';
Shift_A <= '1' when (state = ShiftA) else '0';
Shift_Q <= '1' when (state = ShiftQ0 or state = ShiftQ1) else '0';
shiftBit <= '1' when (state = ShiftQ1) else '0';

end Behavioral;