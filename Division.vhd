----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/13/2021 07:36:20 PM
-- Design Name: 
-- Module Name: Division - Behavioral
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

entity Division is
  Port(X : in std_logic_vector(31 downto 0);  
       Y : in std_logic_vector(31 downto 0); 
       clk : in std_logic;
       rst, init : in std_logic;
       done : out std_logic;
       overflow : out std_logic;
       Quotient : out std_logic_vector(31 downto 0);
       Remainder : out std_logic_vector(31 downto 0));
end Division;

architecture Behavioral of Division is

component ControlUnit_Div is
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
end component;

component Adder is
  generic(n : natural);
  Port (x : in std_logic_vector(n-1 downto 0);      
        y : in std_logic_vector(n-1 downto 0);
        AddA : in std_logic;
        SubA : in std_logic;
        sum : out std_logic_vector(n-1 downto 0);
        cout : out std_logic);
end component;

component ShiftRegisterDiv is
  generic(n : natural);
  Port (clk : in std_logic;
        rst : in std_logic;
        enable : in std_logic;
        shiftBit : in std_logic;
        shift : in std_logic;
        data_in : in std_logic_vector(n-1 downto 0);
        data_out : out std_logic_vector(n-1 downto 0) );
end component;

component RegisterN is
  generic(n : natural);
  Port (clk : in std_logic;
        enable : in std_logic;
        rst : in std_logic;
        data_in : in std_logic_vector(n-1 downto 0);
        data_out : out std_logic_vector(n-1 downto 0));
end component;

--signal X : std_logic_vector(n-1 downto 0) := "00000000000000000000000000000110";
--signal Y : std_logic_vector(n-1 downto 0) := "00000000000000000000000000000010";

signal LoadM, LoadQ, LoadA : std_logic;
signal RstA, Shift_A, Shift_Q, shiftBit: std_logic;
signal AddA, SubA : std_logic;
signal Q31, A32 : std_logic;
-- Q dividend, M divisor
signal inM : std_logic_vector(32 downto 0) := '0' & Y;
signal outM, outSum, outA : std_logic_vector(32 downto 0); -- := (others => '0');
signal inQ : std_logic_vector(31 downto 0) := X;
signal outQ : std_logic_vector(31 downto 0);
signal counter : natural;

begin

Adder33 : Adder generic map(n => 33)
                         port map ( x => outA,
                                    y => outM,
                                    AddA => AddA,
                                    SubA => SubA,
                                    sum => outSum,
                                    cout => overflow); 

RegM : RegisterN generic map(n => 33)
                 port map ( clk => clk,
                            enable => LoadM,
                            rst => '0',
                            data_in => inM,
                            data_out => outM);

RegA : ShiftRegisterDiv generic map(n => 33)
                      port map (clk => clk,
                                rst => RstA,
                                enable => LoadA,
                                shiftBit => Q31,
                                shift => Shift_A,
                                data_in => outSum,
                                data_out => outA);

RegQ : ShiftRegisterDiv generic map(n => 32)
                      port map (clk => clk,
                                rst => rst,
                                enable => LoadQ,
                                shiftBit => shiftBit,
                                shift => Shift_Q,
                                data_in => inQ,
                                data_out => outQ); 
                                
Q31 <= outQ(31);   
A32 <= outA(32);                          
                               
Control_Unit : ControlUnit_Div port map ( clk => clk,
                                          rst => rst,
                                          init => '1',
                                          A32 => A32,
                                          LoadA => LoadA,
                                          LoadM => LoadM,
                                          LoadQ => LoadQ,
                                          shiftBit => shiftBit,
                                          Shift_A => Shift_A,
                                          Shift_Q => Shift_Q,
                                          SubA => SubA,
                                          AddA => AddA,
                                          done => done,
                                          RstA => RstA);     
                                          
Quotient <= outQ;
Remainder <= outA(31 downto 0);
                                          
end Behavioral;