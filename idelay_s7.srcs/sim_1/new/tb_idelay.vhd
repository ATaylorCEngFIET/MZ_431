----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 09.02.2022 12:02:34
-- Design Name: 
-- Module Name: tb_idelay - Behavioral
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

entity tb_idelay is
--  Port ( );
end tb_idelay;

architecture Behavioral of tb_idelay is

component idelay is
  Port ( 
    REFCLK : in std_logic;
    RDY : out std_logic;
    RST : in std_logic;
    
    
    CNTVALUEOUT_1 : out std_logic_vector(4 downto 0);   -- 5-bit output: Counter value output
    CNTVALUEOUT_2 : out std_logic_vector(4 downto 0);   -- 5-bit output: Counter value output
    DATAOUT_1 : out std_logic;                          -- 1-bit output: Delayed data output
    DATAOUT_2 : out std_logic;                          -- 1-bit output: Delayed data output
    C : in std_logic;                                   -- 1-bit input: Clock input
    CE_1 : in std_logic;                                -- 1-bit input: Active high enable increment/decrement input
    CE_2 : in std_logic;                                -- 1-bit input: Active high enable increment/decrement input
    CNTVALUEIN_1 : in std_logic_vector(4 downto 0);     -- 5-bit input: Counter value input
    CNTVALUEIN_2 : in std_logic_vector(4 downto 0);     -- 5-bit input: Counter value input
    DATAIN_1 : in std_logic;                            -- 1-bit input: Internal delay data input
    DATAIN_2 : in std_logic;                            -- 1-bit input: Internal delay data input
    --IDATAIN => IDATAIN,                               -- 1-bit input: Data input from the I/O
    INC_1 : in std_logic;                               -- 1-bit input: Increment / Decrement tap delay input
    INC_2 : in std_logic;                               -- 1-bit input: Increment / Decrement tap delay input
    LD : in std_logic;                                  -- 1-bit input: Load IDELAY_VALUE input
    LDPIPEEN : in std_logic;                            -- 1-bit input: Enable PIPELINE register to load data input
    REGRST : in std_logic                               -- 1-bit input: Active-high reset tap-delay input   
  );
end component idelay;


constant clk_period     : time :=  5 ns;
 
signal    refclk        : std_logic := '0';
signal    RDY           :  std_logic :='0';
signal    RST           :  std_logic :='0';  
signal    CNTVALUEOUT_1 :  std_logic_vector(4 downto 0):=(others=>'0');
signal    CNTVALUEOUT_2 :  std_logic_vector(4 downto 0):=(others=>'0');    
signal    DATAOUT_1     :  std_logic:='0';                        
signal    DATAOUT_2     :  std_logic:='0';                        
signal    CE_1          :  std_logic:='0';   
signal    CE_2          :  std_logic:='0';                       
signal    CNTVALUEIN_1  :  std_logic_vector(4 downto 0):=(others=>'0');     
signal    CNTVALUEIN_2  :  std_logic_vector(4 downto 0):=(others=>'0');     
signal    DATAIN_1      :  std_logic:='0';                        
signal    DATAIN_2      :  std_logic:='0';                         
signal    INC_1         :  std_logic:='0'; 
signal    INC_2         :  std_logic:='0';                        
signal    LD            :  std_logic:='0';                        
signal    LDPIPEEN      :  std_logic:='0';                        
signal    REGRST        :  std_logic:='0';                         

begin

uut: idelay port map ( 
    REFCLK => refclk,
    RDY => rdy,
    RST => rst,
    
    
    CNTVALUEOUT_1 => CNTVALUEOUT_1,
    CNTVALUEOUT_2 => CNTVALUEOUT_2,
    DATAOUT_1 => DATAOUT_1,                         
    DATAOUT_2 => DATAOUT_2,                
    C => refclk,                             
    CE_1 => CE_1, 
    CE_2 => CE_2,                            
    CNTVALUEIN_1 => CNTVALUEIN_1,
    CNTVALUEIN_2 => CNTVALUEIN_2,
    DATAIN_1 => DATAIN_1,                        
    DATAIN_2 => DATAIN_2,                       
    --IDATAIN => IDATAIN,                          
    INC_1 => INC_1,
    INC_2 => INC_2,                            
    LD => LD,                             
    LDPIPEEN =>  LDPIPEEN,                    
    REGRST =>  LDPIPEEN                     
  );

refclk <= not refclk after (clk_period/2);

uut_stim: process 
begin
    wait for (10 * clk_period);
    RST <= '1'; 
    wait for (20 * clk_period); 
    RST <= '0';
    wait until (rdy = '1');
    wait for (10 * clk_period);
    
    report "no delay" severity NOTE;
    wait until rising_edge(refclk);
    DATAIN_1 <= '1';
    DATAIN_2 <= '1';
    wait until rising_edge(refclk);
    DATAIN_1 <= '0';
    DATAIN_2 <= '0';
    --wait until rising_edge(DATAOUT_1);
    wait for 10*clk_period;
    
    report "Same Delay" severity NOTE;
    CNTVALUEIN_1 <= "00010";
    CNTVALUEIN_2 <= "00010";
    wait until rising_edge(refclk);
    LD <= '1';
    wait until rising_edge(refclk);
    LD <= '0';
    wait for 10*clk_period;
    
    wait until rising_edge(refclk);
    DATAIN_1 <= '1';
    DATAIN_2 <= '1';
    wait until rising_edge(refclk);
    DATAIN_1 <= '0';
    DATAIN_2 <= '0';
    --wait until rising_edge(DATAOUT_1);
    wait for 10*clk_period;
    
    report "Increment Delay on channel 2" severity NOTE;
    wait until rising_edge(refclk);
    CE_2 <= '1';
    INC_2 <= '1';
    wait until rising_edge(refclk);
    CE_2 <= '0';
    INC_2 <= '0';
    wait for 10*clk_period;
    
    wait until rising_edge(refclk);
    DATAIN_1 <= '1';
    DATAIN_2 <= '1';
    wait until rising_edge(refclk);
    DATAIN_1 <= '0';
    DATAIN_2 <= '0';
    --wait until rising_edge(DATAOUT_1);
    wait for 10*clk_period;
    
    report "Decrement Delay on channel 2" severity NOTE;
    wait until rising_edge(refclk);
    CE_2 <= '1';
    INC_2 <= '0';
    wait until rising_edge(refclk);
    CE_2 <= '0';
    INC_2 <= '0';
    wait for 10*clk_period;
    
    wait until rising_edge(refclk);
    DATAIN_1 <= '1';
    DATAIN_2 <= '1';
    wait until rising_edge(refclk);
    DATAIN_1 <= '0';
    DATAIN_2 <= '0';
    --wait until rising_edge(DATAOUT_1);
    wait for 10*clk_period;
    
    report "Large Delay" severity NOTE;
    CNTVALUEIN_1 <= "00010";
    CNTVALUEIN_2 <= "11111";
    wait until rising_edge(refclk);
    LD <= '1';
    wait until rising_edge(refclk);
    LD <= '0';
    wait for 10*clk_period;
    
    wait until rising_edge(refclk);
    DATAIN_1 <= '1';
    DATAIN_2 <= '1';
    wait until rising_edge(refclk);
    DATAIN_1 <= '0';
    DATAIN_2 <= '0';
   -- wait until rising_edge(DATAOUT_2);
    wait for 10*clk_period;
    
    report "simulation complete" severity FAILURE;
end process;


end Behavioral;
