----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2021 03:20:32 PM
-- Design Name: 
-- Module Name: Mul32 - Behavioral
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

entity Multiplication is
 Port (X : in std_logic_vector(31 downto 0);  
       Y : in std_logic_vector(31 downto 0); 
       clk : in std_logic;
       rst, init : in std_logic;
       terminate : out std_logic;
       Res : out std_logic_vector(31 downto 0));
end Multiplication;

architecture Behavioral of Multiplication is

component ControlUnit is                                                   
  Port (clk : in std_logic;                                             
        rst : in std_logic;                                             
        init  : in std_logic;                                           
        Q0 : in std_logic;                                              
        LoadA, LoadB, LoadQ, ShiftQA, RstA : out std_logic;       
        terminate : out std_logic);                                     
end component;      

component RegisterN is
  generic (n : natural);
  Port (clk : in std_logic;  
        rst : in std_logic;   
        enable : in std_logic;   
        data_in : in std_logic_vector(31 downto 0);   
        data_out : out std_logic_vector(31 downto 0));
end component;                                                  

component ShiftRegisterN is
  Port (clk : in std_logic;  
        rst : in std_logic; 
        enable : in std_logic; 
        shiftBit : in std_logic;  
        load : in std_logic;
        data_in : in std_logic_vector(31 downto 0);  
        data_out : out std_logic_vector(31 downto 0));
end component;

component RippleCarryAdder is
  Port (x : in std_logic_vector(31 downto 0); 
        y : in std_logic_vector(31 downto 0); 
        sel : in std_logic_vector(3 downto 0); 
        sum : out std_logic_vector(31 downto 0); 
        cout : out std_logic);
end component;

signal outA, outB, outQ, outSum:  std_logic_vector(31 downto 0);
signal cout : std_logic;

signal LoadA, LoadB, LoadQ : std_logic;
signal RstA, ShiftQA : std_logic;


begin
Adder : RippleCarryAdder port map( x => outA, 
                                   y => outB, 
                                   sel => "0001",
                                   sum => outSum, 
                                   cout => cout);
                                   
regB : RegisterN generic map(n => 32) 
                 port map (clk => clk,  
                           rst => '0',   
                           enable => LoadB,
                           data_in => X,   
                           data_out => outB);
                           
regA : ShiftRegisterN port map  (clk => clk, 
                                 rst => RstA,  
                                 enable => ShiftQA, 
                                 shiftBit => '0',  
                                 load => LoadA,
                                 data_in => outSum,  
                                 data_out => outA);

regQ : ShiftRegisterN port map  (clk => clk, 
                                 rst => rst,  
                                 enable => ShiftQA, 
                                 shiftBit => outA(0),  
                                 load => LoadQ,
                                 data_in => Y,  
                                 data_out => outQ);
                                 
Command : ControlUnit port map (clk => clk,                                         
                                rst => rst,                                          
                                init => '1',                                     
                                Q0 => outQ(0),                                       
                                LoadA => LoadA,
                                LoadB => LoadB,
                                LoadQ => LoadQ,
                                ShiftQA => ShiftQA,
                                RstA => RstA,
                                terminate => terminate);                                  

Res <= outQ;

end Behavioral;