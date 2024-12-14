----------------------------------------------------------------------------------
-- Company: 
-- Engineer:    Dmitry Kandiner
-- 
-- Create Date: 12/14/2024 09:14:38 PM
-- Design Name: 
-- Module Name: VGA_Chargen - Behavioral
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

entity VGA_Chargen is
    Port ( char   : in  STD_LOGIC_VECTOR (6 downto 0);
           row    : in  STD_LOGIC_VECTOR (3 downto 0);
           column : in  STD_LOGIC_VECTOR (3 downto 0);
           vga_r  : out STD_LOGIC_VECTOR (3 downto 0);
           vga_g  : out STD_LOGIC_VECTOR (3 downto 0);
           vga_b  : out STD_LOGIC_VECTOR (3 downto 0));
end VGA_Chargen;

architecture Behavioral of VGA_Chargen is
    COMPONENT chargen_rom_0
    PORT (
        a   : IN  STD_LOGIC_VECTOR(14 DOWNTO 0);
        spo : OUT STD_LOGIC_VECTOR(11 DOWNTO 0));
    END COMPONENT;

    signal address : STD_LOGIC_VECTOR(14 DOWNTO 0);
    signal color   : STD_LOGIC_VECTOR(11 DOWNTO 0);

begin
    chargen_rom : chargen_rom_0
    PORT MAP (
        a => address,
        spo => color
    );

    address <= char & row & column;
    vga_r <= color(11 downto 8);
    vga_g <= color( 7 downto 4);
    vga_b <= color( 3 downto 0);
end Behavioral;
