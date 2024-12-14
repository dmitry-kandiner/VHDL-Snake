----------------------------------------------------------------------------------
-- Company: 
-- Engineer:    Dmitry Kandiner
-- 
-- Create Date: 12/06/2024 06:38:32 PM
-- Design Name: 
-- Module Name: VGA_Sync - Behavioral
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

-- Based on data from http://www.tinyvga.com/vga-timing
entity VGA_Sync is
    -- 640x480@73Hz, vsync-, hsync-, pixel clock 31.5MHz 
    Generic (
        h_sync_pulse  : integer := 40;
        h_sync_neg    : boolean := true; 
        h_front_porch : integer := 24; 
        h_active      : integer := 640;
        h_back_porch  : integer := 128;
        v_sync_pulse  : integer := 2;  
        v_sync_neg    : boolean := true; 
        v_front_porch : integer := 9;  
        v_active      : integer := 480;
        v_back_porch  : integer := 29); 
    Port (
        clock  : in STD_LOGIC;
        hsync  : out STD_LOGIC;
        vsync  : out STD_LOGIC;
        active : out STD_LOGIC;
        row    : out STD_LOGIC_VECTOR(11 downto 0);
        column : out STD_LOGIC_VECTOR(11 downto 0));
end VGA_Sync;

architecture Behavioral of VGA_Sync is
    component VGA_Signal is
        Generic (
            sync_width   : integer; 
            fporch_width : integer; 
            active_width : integer;
            bporch_width : integer); 
        Port (
            clock   : in STD_LOGIC;
            enable  : in STD_LOGIC;
            sync    : out STD_LOGIC;
            lastclk : out STD_LOGIC;
            active  : out STD_LOGIC;
            index   : out STD_LOGIC_VECTOR(11 downto 0));
    end component;
    
    signal h_sync    : STD_LOGIC := '0';
    signal v_sync    : STD_LOGIC := '0';
    signal h_display : STD_LOGIC := '0';   
    signal v_display : STD_LOGIC := '0'; 
    signal sig_row   : STD_LOGIC_VECTOR(11 downto 0);  
    signal sig_col   : STD_LOGIC_VECTOR(11 downto 0);  

    signal line_end  : STD_LOGIC := '0';   
begin
    h_signal : VGA_Signal
    generic map (
        sync_width   => h_sync_pulse,
        fporch_width => h_front_porch,
        active_width => h_active,
        bporch_width => h_back_porch)
    port map (
        clock   => clock,
        enable  => '1',
        sync    => h_sync,
        lastclk => line_end,
        active  => h_display,
        index   => sig_col);

    v_signal : VGA_Signal
    generic map (
        sync_width   => v_sync_pulse,
        fporch_width => v_front_porch,
        active_width => v_active,
        bporch_width => v_back_porch)
    port map (
        clock  => clock,
        enable => line_end,
        sync   => v_sync,
        active => v_display,
        index   => sig_row);
        
    hsync  <= h_sync when h_sync_neg = false else not h_sync; 
    vsync  <= v_sync when v_sync_neg = false else not v_sync;
    active <= h_display and v_display;
    row    <= sig_row;
    column <= sig_col; 
end Behavioral;
