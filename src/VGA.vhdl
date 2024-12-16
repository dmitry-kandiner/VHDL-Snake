----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/16/2024 08:49:10 PM
-- Design Name: 
-- Module Name: VGA - Behavioral
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
use IEEE.NUMERIC_STD.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA is
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
end VGA;

architecture Behavioral of VGA is
    component VGA_Chargen is
        Port ( char   : in  STD_LOGIC_VECTOR (6 downto 0);
               row    : in  STD_LOGIC_VECTOR (3 downto 0);
               column : in  STD_LOGIC_VECTOR (3 downto 0);
               vga_r  : out STD_LOGIC_VECTOR (3 downto 0);
               vga_g  : out STD_LOGIC_VECTOR (3 downto 0);
               vga_b  : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    component VGA_Sync_0 is
        Port (
            clock  : in STD_LOGIC;
            hsync  : out STD_LOGIC;
            vsync  : out STD_LOGIC;
            active : out STD_LOGIC;
            row    : out STD_LOGIC_VECTOR(11 downto 0);
            column : out STD_LOGIC_VECTOR(11 downto 0));
    end component;

    COMPONENT blk_mem_gen_0
        PORT (
            clka  : IN STD_LOGIC;
            wea   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            addra : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            dina  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);

            clkb  : IN STD_LOGIC;
            enb   : IN STD_LOGIC;
            web   : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
            addrb : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
            dinb  : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
            doutb : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)); 
        END COMPONENT;
    
    signal char        : STD_LOGIC_VECTOR (7 downto 0);
    signal char_row    : STD_LOGIC_VECTOR (3 downto 0);
    signal char_column : STD_LOGIC_VECTOR (3 downto 0);
    signal char_r      : STD_LOGIC_VECTOR (3 downto 0);
    signal char_g      : STD_LOGIC_VECTOR (3 downto 0);
    signal char_b      : STD_LOGIC_VECTOR (3 downto 0);
    
    signal active      : STD_LOGIC;
    signal disp_row    : STD_LOGIC_VECTOR(11 downto 0);
    signal disp_column : STD_LOGIC_VECTOR(11 downto 0);

    signal scr_buff_addr   : STD_LOGIC_VECTOR(10 DOWNTO 0) := (others => '0');
    signal scr_buff_column : unsigned(7 downto 0);
    signal scr_buff_row    : unsigned(7 downto 0);
    
begin
    chargen : VGA_Chargen
    PORT MAP (
        char   => char(6 downto 0),   
        row    => char_row,   
        column => char_column, 
        vga_r  => char_r,
        vga_g  => char_g,  
        vga_b  => char_b  
    );
    
    sync : VGA_Sync_0
    PORT MAP (
        clock  => vga_clk,
        hsync  => hsync,
        vsync  => vsync,
        active => active,
        row    => disp_row,
        column => disp_column
    );
    
    scr_buff : blk_mem_gen_0
    PORT MAP (
        clka  => vga_clk,
        wea   => (others => '0'),
        addra => scr_buff_addr,
        dina  => (others => 'Z'),
        douta => char,

        clkb  => clkb,
        enb   => '0',
        web   => web,
        addrb => addrb,
        dinb  => dinb,
        doutb => doutb
    );

    process(vga_clk)
    begin
        if rising_edge(vga_clk) then
            if active = '1' then    -- Update VGA colors output
                vga_r <= char_r;
                vga_g <= char_g;
                vga_b <= char_b;
            else
                vga_r <= (others => '0');
                vga_g <= (others => '0');
                vga_b <= (others => '0');
            end if;

            char_column <= disp_column(3 downto 0);
            char_row    <= disp_row   (3 downto 0);

--            scr_buff_column <= unsigned(disp_column(11 downto 4));
--            scr_buff_row    <= unsigned(disp_row   (11 downto 4));
--            scr_buff_addr   <= std_logic_vector(40 * scr_buff_row + scr_buff_column);
        end if;
    end process;    

end Behavioral;
