----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/29/2021 01:29:22 PM
-- Design Name: 
-- Module Name: Project - Behavioral
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

entity Project is
  Port (clk : in std_logic;
        rst : in std_logic;
        op : in std_logic_vector(3 downto 0);
        Zero : out std_logic;
        --Result : out std_logic_vector(31 downto 0);
        an: out std_logic_vector(3 downto 0);
        cat: out std_logic_vector(6 downto 0));
end Project;

architecture Behavioral of Project is

component Memory is
      Port (address1 : in std_logic_vector(2 downto 0);
            address2 : in std_logic_vector(2 downto 0);
            enable : in std_logic;
            clk: in std_logic;
            AA : out std_logic_vector(31 downto 0);
            RR : out std_logic_vector(31 downto 0));
end component;

component PhaseGenerator is
    Port ( clk : in std_logic;
           rst : in std_logic;
           address1 : out std_logic_vector (2 downto 0);
           address2 : out std_logic_vector (2 downto 0));
end component;

component Control is
  Port (clk : in std_logic;
        op : in std_logic_vector(3 downto 0); 
        sendOp : out std_logic_vector(3 downto 0));
end component;

component Reg is
  Port (clk : in std_logic;
        enable : in std_logic;
        regIn : in std_logic_vector(31 downto 0);
        regOut : out std_logic_vector(31 downto 0));
end component;

component ALU is
  Port (A : in std_logic_vector(31 downto 0); 
        R : in std_logic_vector(31 downto 0);
        clk : in std_logic;
        rst: in std_logic;
        flag : out std_logic;
        Operation : in std_logic_vector(3 downto 0);
        Result : out std_logic_vector(31 downto 0);
        Remain :out std_logic_vector(31 downto 0);
        Mul :out std_logic_vector(31 downto 0);
        doneMul, doneDiv : out std_logic);
end component;

component Display is
  port ( digit: in std_logic_vector(15 downto 0);
         clk: in std_logic;
         an: out std_logic_vector(3 downto 0);
         sseg: out std_logic_vector(6 downto 0));
end component;

component DisplayAll is
  port ( digit: in std_logic_vector(15 downto 0);
         clk: in std_logic;
         an: out std_logic_vector(3 downto 0);
         cat: out std_logic_vector(6 downto 0));
end component;

signal Operation : std_logic_vector(3 downto 0);
signal inA, outA, inR, outR, Res, Remain, Mul: std_logic_vector(31 downto 0);
signal address1, address2 : std_logic_vector(2 downto 0);
signal enable : std_logic := '1';
signal doneMul, doneDiv : std_logic;

signal hardA : std_logic_vector(31 downto 0) := "00000000000000000000000000010010"; --18      --"00000000000000000000000101000000"; -- 340 
signal hardR : std_logic_vector(31 downto 0) := "00000000000000000000000000000110"; --6      --"00000000000000000000000000010001";

begin


Phase_Generator : PhaseGenerator port map ( clk => clk,
                                            rst => rst,
                                            address1 => address1,
                                            address2 => address2);

Memory_Unit : Memory port map ( address1 => address1,
                                address2 => address2,
                                enable => rst,
                                clk => clk,
                                AA => inA,
                                RR => inR);
                                
Control_Unit : Control port map(clk => clk,
                                op => op,
                                sendOp => Operation);

RegisterA : Reg port map (clk => clk,
                          enable => enable,
                          regIn => hardA,
                          regOut => outA); 
                          
RegisterR : Reg port map (clk => clk,
                          enable => '1',
                          regIn => hardR,
                          regOut => outR);

ALU_Unit : ALU port map (A => outA,
                         R => outR,
                         clk => clk,
                         rst => rst,
                         flag => Zero,
                         Operation => Operation,
                         Result => Res,
                         Remain => Remain,
                         Mul => Mul,
                         doneMul => doneMul,
                         doneDiv => doneDiv);  
--Result <= Res;

--SSD : Display port map ( digit(15 downto 8) => Res(7 downto 0),
--                         digit(7 downto 0) => Remain(7 downto 0),
--                         clk => clk,
--                         an => an,
--                         sseg => cat);

SSD : DisplayAll port map ( digit(15 downto 12) => Operation,
                            digit(11 downto 0) => Res(11 downto 0),
                             clk => clk,
                             an => an,
                             cat => cat);

                                                  

end Behavioral;