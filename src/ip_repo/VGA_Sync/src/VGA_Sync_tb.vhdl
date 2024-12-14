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
    component VGA_Sync is
        Generic (
            h_sync_pulse  : integer;
            h_sync_neg    : boolean;
            h_front_porch : integer;
            h_active      : integer;
            h_back_porch  : integer;
            v_sync_pulse  : integer;
            v_sync_neg    : boolean;
            v_front_porch : integer;
            v_active      : integer;
            v_back_porch  : integer);
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
        h_active      => 800,
        h_front_porch => 56,
        h_sync_pulse  => 120,
        h_sync_neg    => true,
        h_back_porch  => 64,
        v_active      => 600,
        v_front_porch => 37,
        v_sync_pulse  => 6,
        v_sync_neg    => false,
        v_back_porch  => 23)
    port map (
        clock  => clock,
        hsync  => hsync,
        vsync  => vsync,
        active => active
    );
    
    clock <= not clock after (px_clock_period / 2);
end Behavioral;
