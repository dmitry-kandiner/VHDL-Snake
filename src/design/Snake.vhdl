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
        resetn  : in  STD_LOGIC;
        clk_in1 : in  STD_LOGIC;
        clk_mcu : out STD_LOGIC;
        clk_vga : out STD_LOGIC);
    end component;

    component PS2Receiver is 
        Port (
            clk        : in  STD_LOGIC;
            kclk       : in  STD_LOGIC;
            kdata      : in  STD_LOGIC;
            keycodeout : out STD_LOGIC_VECTOR(31 downto 0));
    end component;

    component VGA is
        Port (
            -- VGA
            vga_clk : in  STD_LOGIC;
            vsync   : out STD_LOGIC;
            hsync   : out STD_LOGIC;
            vga_r   : out STD_LOGIC_VECTOR (3 downto 0);
            vga_g   : out STD_LOGIC_VECTOR (3 downto 0);
            vga_b   : out STD_LOGIC_VECTOR (3 downto 0);
            -- Scren buffer
            clkb    : in  STD_LOGIC;
            enb     : in  STD_LOGIC;
            web     : in  STD_LOGIC_VECTOR( 3 DOWNTO 0);
            addrb   : in  STD_LOGIC_VECTOR( 8 DOWNTO 0);
            dinb    : in  STD_LOGIC_VECTOR(31 DOWNTO 0);
            doutb   : out STD_LOGIC_VECTOR(31 DOWNTO 0));
    end component;

    component mcu_0 is
        port (
            Clk              : in  STD_LOGIC;
            reset_rtl        : in  STD_LOGIC;
            VMEM_PORT_0_addr : out STD_LOGIC_VECTOR (0 to 31);
            VMEM_PORT_0_clk  : out STD_LOGIC;
            VMEM_PORT_0_din  : out STD_LOGIC_VECTOR (0 to 31);
            VMEM_PORT_0_dout : in  STD_LOGIC_VECTOR (0 to 31);
            VMEM_PORT_0_en   : out STD_LOGIC;
            VMEM_PORT_0_rst  : out STD_LOGIC;
            VMEM_PORT_0_we   : out STD_LOGIC_VECTOR (0 to  3);
            KBD_IN_0_tri_i   : in  STD_LOGIC_VECTOR (31 downto 0));
    end component;

    signal keycodes : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');

    signal mcu_clock : STD_LOGIC;
    signal vga_clock : STD_LOGIC;

    signal vmem_en   : STD_LOGIC;   
    signal vmem_we   : STD_LOGIC_VECTOR(0 to  3);
    signal vmem_addr : STD_LOGIC_VECTOR(0 to 31);
    signal vmem_din  : STD_LOGIC_VECTOR(0 to 31);
    signal vmem_dout : STD_LOGIC_VECTOR(0 to 31);

    alias vmem_addr_inv : STD_LOGIC_VECTOR(vmem_addr'reverse_range) is vmem_addr;
    alias vmem_din_inv  : STD_LOGIC_VECTOR(vmem_din'reverse_range ) is vmem_din;
    alias vmem_dout_inv : STD_LOGIC_VECTOR(vmem_dout'reverse_range) is vmem_dout;
    alias vmem_we_inv   : STD_LOGIC_VECTOR(vmem_we'reverse_range  ) is vmem_we;

begin
    clocks : clk_wiz_0
    port map ( 
        clk_in1 => sys_clock,
        resetn  => reset,
        clk_vga => vga_clock,
        clk_mcu => mcu_clock
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
        clkb    => mcu_clock,
        enb     => vmem_en,
        web     => vmem_we_inv,
        addrb   => vmem_addr_inv(10 downto 2),
        dinb    => vmem_din_inv,
        doutb   => vmem_dout_inv
    );
    
    mcu : mcu_0
    port map (
        Clk              => mcu_clock,
        reset_rtl        => reset,
        VMEM_PORT_0_addr => vmem_addr,
        VMEM_PORT_0_clk  => mcu_clock,
        VMEM_PORT_0_din  => vmem_din,
        VMEM_PORT_0_dout => vmem_dout,
        VMEM_PORT_0_en   => vmem_en,
        VMEM_PORT_0_we   => vmem_we,
        KBD_IN_0_tri_i   => keycodes
    );
end Behavioral;
