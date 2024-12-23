----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/18/2024 08:39:33 PM
-- Design Name: 
-- Module Name: VGA_tb - Behavioral
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

entity VGA_tb is
--  Port ( );
end VGA_tb;

architecture Behavioral of VGA_tb is
    component VGA is
        Port (
            -- VGA
            vga_clk : in STD_LOGIC;
            vsync   : out STD_LOGIC;
            hsync   : out STD_LOGIC;
            vga_r   : out STD_LOGIC_VECTOR (3 downto 0);
            vga_g   : out STD_LOGIC_VECTOR (3 downto 0);
            vga_b   : out STD_LOGIC_VECTOR (3 downto 0);
            -- Scren buffer
            clkb    : IN STD_LOGIC;
            enb     : IN STD_LOGIC;
            web     : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
            addrb   : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
            dinb    : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
            doutb   : OUT STD_LOGIC_VECTOR(31 DOWNTO 0));
    end component;

    signal vga_clock : STD_LOGIC := '0';

    signal vsync : STD_LOGIC;
    signal hsync : STD_LOGIC;
    signal vga_r : STD_LOGIC_VECTOR (3 downto 0);
    signal vga_g : STD_LOGIC_VECTOR (3 downto 0);
    signal vga_b : STD_LOGIC_VECTOR (3 downto 0);

    constant vga_clk_period : time := 50 ns;

begin
    uut : VGA
    port map (
        -- VGA
        vga_clk => vga_clock,
        vsync   => vsync,
        hsync   => hsync,
        vga_r   => vga_r,
        vga_g   => vga_g,
        vga_b   => vga_b,
        -- Scren buffer
        clkb    => '0',
        enb     => '0',
        web     => (others => '0'),
        addrb   => (others => 'Z'),
        dinb    => (others => 'Z')
    );

    vga_clock <= not vga_clock after vga_clk_period / 2;

end Behavioral;
