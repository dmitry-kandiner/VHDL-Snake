----------------------------------------------------------------------------------
-- Company: 
-- Engineer:    Dmitry Kandiner 
-- 
-- Create Date: 12/07/2024 08:52:51 AM
-- Design Name: 
-- Module Name: VGA_Signal - Behavioral
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

entity VGA_Signal is
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
end VGA_Signal;

architecture Behavioral of VGA_Signal is
    constant sync_start : integer := 0;
    constant sync_end   : integer := sync_start + sync_width - 1;    
    constant fporch_end : integer := sync_end   + fporch_width;
    constant active_end : integer := fporch_end + active_width;
    constant bporch_end : integer := active_end + bporch_width;
    constant signal_end : integer := bporch_end - 1;

    signal sig_sync   : STD_LOGIC := '1';
    signal sig_end    : STD_LOGIC := '0';
    signal sig_active : STD_LOGIC := '0';
    signal sig_index  : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');

    signal count : integer := sync_start;
begin
    process(clock)
    begin
        if rising_edge(clock) then 
            if enable = '1' then

                if sig_active = '1' then
                    sig_index <= sig_index + 1;
                end if;

                count <= count + 1;
                if (count = sync_end) then
                    sig_sync <= '0';
                elsif (count = fporch_end) then
                    sig_active <= '1';
                elsif (count = active_end) then
                    sig_index <= (others => '0');
                    sig_active <= '0';
                elsif (count = signal_end) then
                    sig_end <= '1';
                elsif (count = bporch_end) then
                    sig_sync <= '1';
                    sig_end <= '0';
                    count <= sync_start; 
                end if;

            end if;
        end if;
    end process;
    
    sync    <= sig_sync;
    lastclk <= sig_end;
    active  <= sig_active;
    index   <= sig_index;
end Behavioral;
