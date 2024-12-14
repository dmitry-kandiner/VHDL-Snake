----------------------------------------------------------------------------------
-- Company: 
-- Engineer:    Dmitry Kandiner
-- 
-- Create Date: 12/06/2024 06:39:45 PM
-- Design Name: 
-- Module Name: VGA_Sync_tb - Behavioral
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

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VGA_Sync_tb is
--  Port ( );
end VGA_Sync_tb;

architecture Behavioral of VGA_Sync_tb is
    constant h_sync_pulse  : unsigned( 7 downto 0) := x"78";    -- 120
    constant h_front_porch : unsigned( 7 downto 0) := x"38";    -- 56 
    constant h_active      : unsigned(11 downto 0) := x"320";   -- 800
    constant h_back_porch  : unsigned( 7 downto 0) := x"40";    -- 64 
    constant v_sync_pulse  : unsigned( 7 downto 0) := x"06";    -- 6  
    constant v_front_porch : unsigned( 7 downto 0) := x"25";    -- 37 
    constant v_active      : unsigned(11 downto 0) := x"258";   -- 600
    constant v_back_porch  : unsigned( 7 downto 0) := x"17";    -- 23 
    
    component VGA_Sync is
        Generic (
            h_sync_pulse  : unsigned( 7 downto 0);
            h_front_porch : unsigned( 7 downto 0);
            h_active      : unsigned(11 downto 0);
            h_back_porch  : unsigned( 7 downto 0);
            v_sync_pulse  : unsigned( 7 downto 0);
            v_front_porch : unsigned( 7 downto 0);
            v_active      : unsigned(11 downto 0);
            v_back_porch  : unsigned( 7 downto 0));
        Port (
            clock  : in STD_LOGIC;
            hsync  : out STD_LOGIC;
            vsync  : out STD_LOGIC;
            active : out STD_LOGIC);
    end component;
    
    signal clock : STD_LOGIC := '1';
    signal hsync : std_logic;
    signal vsync : STD_LOGIC;
    signal active : STD_LOGIC;
    
    constant px_clock_period : time := 40ns;
begin
    uut: VGA_Sync
    generic map (
        h_active      => h_active,
        h_front_porch => h_front_porch,
        h_sync_pulse  => h_sync_pulse,
        h_back_porch  => h_back_porch,
        v_active      => v_active,
        v_front_porch => v_front_porch,
        v_sync_pulse  => v_sync_pulse,
        v_back_porch  => v_back_porch)
    port map (
        clock  => clock,
        hsync  => hsync,
        vsync  => vsync,
        active => active
    );
    
    clock <= not clock after (px_clock_period / 2);
end Behavioral;
