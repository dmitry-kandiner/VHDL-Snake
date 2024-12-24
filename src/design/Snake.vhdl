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
            web     : in  STD_LOGIC_VECTOR( 0 DOWNTO 0);
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

    signal vga_en   : STD_LOGIC;
    signal vga_we   : STD_LOGIC_VECTOR( 0 downto 0);
    signal vga_addr : STD_LOGIC_VECTOR( 8 downto 0);
    signal vga_din  : STD_LOGIC_VECTOR(31 downto 0);
    signal vga_dout : STD_LOGIC_VECTOR(31 downto 0);

    alias vga_dout_inv : STD_LOGIC_VECTOR(vga_dout'reverse_range ) is vga_dout;

    signal vmem_en   : STD_LOGIC;   
    signal vmem_we   : STD_LOGIC_VECTOR(0 to  3);
    signal vmem_addr : STD_LOGIC_VECTOR(0 to 31);
    signal vmem_din  : STD_LOGIC_VECTOR(0 to 31);
    signal vmem_dout : STD_LOGIC_VECTOR(0 to 31);

    alias vmem_addr_inv : STD_LOGIC_VECTOR(vmem_addr'reverse_range) is vmem_addr;
    alias vmem_din_inv  : STD_LOGIC_VECTOR(vmem_din'reverse_range ) is vmem_din;

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
        enb     => vga_en,
        web     => vga_we,
        addrb   => vga_addr,
        dinb    => vga_din,
        doutb   => vga_dout
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

    process (mcu_clock)
    begin
        if rising_edge(mcu_clock) then
            vga_en    <= vmem_en;
            vga_addr  <= vmem_addr_inv(8 downto 0);
            vga_din   <= vmem_din_inv;
            vga_we(0) <= vmem_we(0) or vmem_we(1) or vmem_we(2) or vmem_we(3);
            if vmem_we(0) /= '1' then vga_din( 7 downto  0) <= (others => 'Z'); end if;
            if vmem_we(1) /= '1' then vga_din(15 downto  8) <= (others => 'Z'); end if;
            if vmem_we(2) /= '1' then vga_din(23 downto 16) <= (others => 'Z'); end if;
            if vmem_we(3) /= '1' then vga_din(31 downto 24) <= (others => 'Z'); end if;
            vmem_dout <= vga_dout_inv;
        end if;
    end process;

end Behavioral;
