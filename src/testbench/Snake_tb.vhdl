----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/20/2024 10:25:28 AM
-- Design Name: 
-- Module Name: Snake_tb - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Snake_tb is
--  Port ( );
end Snake_tb;

architecture Behavioral of Snake_tb is
    component Snake is
        Port (
            sys_clock : in STD_LOGIC;
            reset     : in STD_LOGIC;
            vga_r     : out STD_LOGIC_VECTOR(3 downto 0);
            vga_g     : out STD_LOGIC_VECTOR(3 downto 0);
            vga_b     : out STD_LOGIC_VECTOR(3 downto 0);
            vga_hs    : out STD_LOGIC;
            vga_vs    : out STD_LOGIC);
    end component;

    signal sys_clock : STD_LOGIC := '0';
    signal vga_r     : STD_LOGIC_VECTOR(3 downto 0);
    signal vga_g     : STD_LOGIC_VECTOR(3 downto 0);
    signal vga_b     : STD_LOGIC_VECTOR(3 downto 0);
    signal vga_hs    : STD_LOGIC;
    signal vga_vs    : STD_LOGIC;

    constant sys_clock_period : time := 10ns;
begin
    uut : Snake 
    port map (
        sys_clock => sys_clock,
        reset     => '1',
        vga_r     => vga_r, 
        vga_g     => vga_g, 
        vga_b     => vga_b, 
        vga_hs    => vga_hs, 
        vga_vs    => vga_vs 
    );

    sys_clock <= not sys_clock after sys_clock_period / 2;
    
end Behavioral;
