----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2021 02:32:56 PM
-- Design Name: 
-- Module Name: ALU - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU is
  Port (A : in std_logic_vector(31 downto 0); 
        R : in std_logic_vector(31 downto 0);
        clk : in std_logic;
        rst: in std_logic;
        Operation : in std_logic_vector(3 downto 0);
        flag : out std_logic;
        Result : out std_logic_vector(31 downto 0);
        Remain : out std_logic_vector(31 downto 0);
        Mul : out std_logic_vector(31 downto 0);
        doneMul, doneDiv : out std_logic);
end ALU;

architecture Behavioral of ALU is

component RippleCarryAdder is
  Port (x : in std_logic_vector(31 downto 0); 
        y : in std_logic_vector(31 downto 0); 
        sel : in std_logic_vector(3 downto 0); 
        sum : out std_logic_vector(31 downto 0); 
        cout : out std_logic);
end component;

component LogicOperations is
  Port (a : in std_logic_vector(31 downto 0);
        b : in std_logic_vector(31 downto 0); 
        op : in std_logic_vector(3 downto 0); 
        result : out std_logic_vector(31 downto 0));
end component;

component ShiftOperations is
  Port (a : in std_logic_vector(31 downto 0);
        b : in std_logic_vector(31 downto 0); 
        op : in std_logic_vector(3 downto 0); 
        result : out std_logic_vector(31 downto 0));
end component;

component Multiplication is
 Port (X : in std_logic_vector(31 downto 0);  
       Y : in std_logic_vector(31 downto 0); 
       clk : in std_logic;
       rst, init : in std_logic;
       terminate : out std_logic;
       Res : out std_logic_vector(31 downto 0));
end component;

component Division is
  Port(X : in std_logic_vector(31 downto 0);  
       Y : in std_logic_vector(31 downto 0); 
       clk : in std_logic;
       rst, init : in std_logic;
       done : out std_logic;
       overflow : out std_logic;
       Quotient : out std_logic_vector(31 downto 0);
       Remainder : out std_logic_vector(31 downto 0));
end component;

-- signals used for internal purpose, in port maps, as temporary results
signal arithmeticOp, logicOp, shiftOp, quotient, remainder, Res : std_logic_vector(31 downto 0);
signal multiplicationOp : std_logic_vector(31 downto 0);
signal cout: std_logic;

begin
                                                        
-- port maps for ALU operations
ArithmeticalOp : RippleCarryAdder port map(x => A, 
                                           y => R, 
                                           sel => Operation, 
                                           sum => arithmeticOp, 
                                           cout => cout); -- arithmetic op : add, sub, inc, dec

LogicalOp : LogicOperations port map(a => A, 
                                     b => R, 
                                     op => Operation , 
                                     result => logicOp); -- logic op : and, or, not

ShiftRotateOp : ShiftOperations port map(a => A, 
                                         b => R, 
                                         op => Operation , 
                                         result => shiftOp); -- shift op : shift left, shift right, rotate left, rotate right

MultiplicationsOp : Multiplication port map (X => A, 
                                             Y => R,
                                             clk => clk,
                                             rst => rst,
                                             init => '1',
                                             terminate => doneMul,
                                             Res => multiplicationOp);
                                            
DivisionOp : Division port map(X => A,
                               Y => R,
                               clk => clk,
                               rst => rst,
                               init => '1',
                               done => doneDiv,
                               overflow => cout,
                               Quotient => quotient,
                               Remainder => remainder);                                            
                                            
-- process to choose which operation to display on the 7 segment display
process(Operation, arithmeticOp,logicOp, shiftOp, multiplicationOp, quotient, remainder)
begin
   -- if clk'event and clk = '1' then
        case Operation is
            when "0001" => -- ADD
                Res <= arithmeticOp(31 downto 0); 
            when "0010" => -- SUB
                Res <= arithmeticOp(31 downto 0); 
            when "0011" => -- INC
                Res <= arithmeticOp(31 downto 0); 
            when "0100" => -- DEC
                Res <= arithmeticOp(31 downto 0); 
            when "0101" => -- AND
                Res <= logicOp(31 downto 0);
            when "0110" => -- OR
                Res <= logicOp(31 downto 0);
            when "0111" => -- NOT
                Res <= logicOp(31 downto 0);
            when "1000" => -- SHIFT LEFT
                Res <= shiftOp(31 downto 0);
            when "1001" => -- SR
                Res <= shiftOp(31 downto 0);
            when "1010" => -- RL
                Res <= shiftOp(31 downto 0);
            when "1011" => -- RR
                Res <= shiftOp(31 downto 0);
            when "1100" => -- MUL
                Res <= '0' & multiplicationOp(31 downto 1);
            when others => -- DIV
                Res <= quotient(31 downto 0);
                Remain <= remainder(31 downto 0);
        end case;
  --  end if; 
    if Res = 0 then
        flag <= '1';
    else 
        flag <= '0';
    end if; 
    
end process;

Result <= Res;
Mul <= multiplicationOp;


end Behavioral;
