----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2024 08:49:10 PM
-- Design Name: 
-- Module Name: Snake - Behavioral
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

entity Snake is
    Port (
        sys_clock : in STD_LOGIC;
        reset     : in STD_LOGIC;
        PS2_CLK   : in STD_LOGIC;
        PS2_DATA  : in STD_LOGIC;
        vga_r     : out STD_LOGIC_VECTOR(3 downto 0);
        vga_g     : out STD_LOGIC_VECTOR(3 downto 0);
        vga_b     : out STD_LOGIC_VECTOR(3 downto 0);
        vga_hs    : out STD_LOGIC;
        vga_vs    : out STD_LOGIC);
end Snake;

architecture Behavioral of Snake is
    component clk_wiz_0
    port (
        resetn      : in     std_logic;
        clk_in1     : in     std_logic;
        clk_mcu     : out    std_logic;
        clk_vga     : out    std_logic);
    end component;

    component PS2Receiver is 
        Port (
            clk        : in STD_LOGIC;
            kclk       : in STD_LOGIC;
            kdata      : in STD_LOGIC;
            keycodeout : out STD_LOGIC_VECTOR(31 downto 0));
    end component;

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
            web     : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            addrb   : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            dinb    : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            doutb   : OUT STD_LOGIC_VECTOR(7 DOWNTO 0));
    end component;

    signal keycodes : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

    signal vga_clock : STD_LOGIC;

begin
    clocks : clk_wiz_0
    port map ( 
        clk_in1 => sys_clock,
        resetn  => reset,
        clk_vga => vga_clock
    );
    
    kbd : PS2Receiver
    port map (
        clk   => sys_clock,
        kclk  => PS2_CLK,
        kdata => PS2_DATA,
        keycodeout => keycodes
    );

    display : VGA
    port map (
        -- VGA
        vga_clk => vga_clock,
        vsync   => vga_vs,
        hsync   => vga_hs,
        vga_r   => vga_r,
        vga_g   => vga_g,
        vga_b   => vga_b,
        -- Screen buffer
        clkb    => '0',
        enb     => '0',
        web     => (others => '0'),
        addrb   => (others => 'Z'),
        dinb    => (others => 'Z')
    );

end Behavioral;
