----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2021 04:48:01 PM
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

entity ControlUnit is
  Port (clk : in std_logic;
        rst : in std_logic;
        init  : in std_logic;
        Q0 : in std_logic;
        LoadA, LoadB, LoadQ : out std_logic;
        ShiftQA, RstA : out std_logic;
        terminate : out std_logic);
end ControlUnit;

architecture Behavioral of ControlUnit is

type states is (Start, Initialize, CheckQ, Add, Shift, CheckN, Stop); 
signal state : states := Start;

signal count: NATURAL := 32;
signal done : std_logic := '0';

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
                when Initialize => state <= CheckQ;
                                   
                when CheckQ => if Q0 = '1' then
                                  state <= Add;
                               else
                                  state <= Shift; 
                               end if;
                when Add => state <= Shift;

                when Shift => state <= CheckN; 
                
                when CheckN => if count = 0 then
                                  state <= Stop;
                               else
                                  state <= CheckQ;
                               end if;
                when Stop => done <= '1';
                            
            end case;
        end if;
     end if;                      
end process;

process(clk)
begin
    if rising_edge(clk) then
        if state = Start then
            count <= 31;
        else
            if state = Shift then
                count <= count - 1;
            end if;
       end if;
    end if;
end process;

terminate <= done;
LoadA <= '1' when (state = Add) else '0';
LoadB <= '1' when (state = Initialize) else '0';
LoadQ <= '1' when (state = Initialize) else '0';
ShiftQA <= '1' when (state = Shift) else '0'; 
RstA <= '1' when (state = Start or state = Initialize) else '0';

end Behavioral;
