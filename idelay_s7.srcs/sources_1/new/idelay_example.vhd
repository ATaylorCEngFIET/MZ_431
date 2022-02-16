

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

Library UNISIM;
use UNISIM.vcomponents.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

entity idelay is
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
end idelay;

architecture Behavioral of idelay is

--  Put the following attribute before the 'begin' statement
--  Specifies group name for associated IDELAYs/ODELAYs and IDELAYCTRL

attribute IODELAY_GROUP : STRING;
attribute IODELAY_GROUP of IDELAYCTRL_inst  : label is "group1";
attribute IODELAY_GROUP of IDELAYE2_inst_1    : label is "group1";
attribute IODELAY_GROUP of IDELAYE2_inst_2    : label is "group1";

begin

   IDELAYCTRL_inst : IDELAYCTRL
   port map (
      RDY => RDY,                       -- 1-bit output: Ready output
      REFCLK => REFCLK,                 -- 1-bit input: Reference clock input
      RST => RST                        -- 1-bit input: Active high reset input
   );
   
   IDELAYE2_inst_1 : IDELAYE2
   generic map (
      CINVCTRL_SEL => "FALSE",          -- Enable dynamic clock inversion (FALSE, TRUE)
      DELAY_SRC => "DATAIN",           -- Delay input (IDATAIN, DATAIN)
      HIGH_PERFORMANCE_MODE => "FALSE", -- Reduced jitter ("TRUE"), Reduced power ("FALSE")
      IDELAY_TYPE => "VAR_LOAD",        -- FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      IDELAY_VALUE => 0,                -- Input delay tap setting (0-31)
      PIPE_SEL => "FALSE",              -- Select pipelined mode, FALSE, TRUE
      REFCLK_FREQUENCY => 200.0,        -- IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
      SIGNAL_PATTERN => "DATA"          -- DATA, CLOCK input signal
   )
   port map (
      CNTVALUEOUT => CNTVALUEOUT_1,       -- 5-bit output: Counter value output
      DATAOUT => DATAOUT_1,             -- 1-bit output: Delayed data output
      C => C,                           -- 1-bit input: Clock input
      CE => CE_1,                         -- 1-bit input: Active high enable increment/decrement input
      CINVCTRL => '0',                  -- 1-bit input: Dynamic clock inversion input
      CNTVALUEIN => CNTVALUEIN_1,       -- 5-bit input: Counter value input
      DATAIN => DATAIN_1,               -- 1-bit input: Internal delay data input
      IDATAIN => '0',                   -- 1-bit input: Data input from the I/O
      INC => INC_1,                     -- 1-bit input: Increment / Decrement tap delay input
      LD => LD,                         -- 1-bit input: Load IDELAY_VALUE input
      LDPIPEEN => LDPIPEEN,             -- 1-bit input: Enable PIPELINE register to load data input
      REGRST => REGRST                  -- 1-bit input: Active-high reset tap-delay input
   );
   
   IDELAYE2_inst_2 : IDELAYE2
   generic map (
      CINVCTRL_SEL => "FALSE",          -- Enable dynamic clock inversion (FALSE, TRUE)
      DELAY_SRC => "DATAIN",           -- Delay input (IDATAIN, DATAIN)
      HIGH_PERFORMANCE_MODE => "FALSE", -- Reduced jitter ("TRUE"), Reduced power ("FALSE")
      IDELAY_TYPE => "VAR_LOAD",        -- FIXED, VARIABLE, VAR_LOAD, VAR_LOAD_PIPE
      IDELAY_VALUE => 0,                -- Input delay tap setting (0-31)
      PIPE_SEL => "FALSE",              -- Select pipelined mode, FALSE, TRUE
      REFCLK_FREQUENCY => 200.0,        -- IDELAYCTRL clock input frequency in MHz (190.0-210.0, 290.0-310.0).
      SIGNAL_PATTERN => "DATA"          -- DATA, CLOCK input signal
   )
   port map (
      CNTVALUEOUT => CNTVALUEOUT_2,       -- 5-bit output: Counter value output
      DATAOUT => DATAOUT_2,             -- 1-bit output: Delayed data output
      C => C,                           -- 1-bit input: Clock input
      CE => CE_2,                         -- 1-bit input: Active high enable increment/decrement input
      CINVCTRL => '0',                  -- 1-bit input: Dynamic clock inversion input
      CNTVALUEIN => CNTVALUEIN_2,       -- 5-bit input: Counter value input
      DATAIN => DATAIN_2,               -- 1-bit input: Internal delay data input
      IDATAIN => '0',                   -- 1-bit input: Data input from the I/O
      INC => INC_2,                     -- 1-bit input: Increment / Decrement tap delay input
      LD => LD,                         -- 1-bit input: Load IDELAY_VALUE input
      LDPIPEEN => LDPIPEEN,             -- 1-bit input: Enable PIPELINE register to load data input
      REGRST => REGRST                  -- 1-bit input: Active-high reset tap-delay input
   );

end Behavioral;