library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Registers is
  port(
    clk     : in std_logic;

    rs_addr : in std_logic_vector(1 downto 0);    -- source register 1 address
    rt_addr : in std_logic_vector(1 downto 0);    -- source register 2 address
    rd_addr : in std_logic_vector(1 downto 0);    -- destination register address
    wr_data : in std_logic_vector(7 downto 0);    -- write data to destination register

    rs      : out std_logic_vector(7 downto 0);   -- source register 1 value
    rt      : out std_logic_vector(7 downto 0)    -- source register 2 value
  );
end Registers;


architecture behavioral of Registers is

  type registerFile is array(0 to 3) of std_logic_vector(7 downto 0);
  --put some initial values to the registers
  --because we don't have load instructions!
  signal reg: registerFile := (
   "00000001",
   "00000010",
   "00000011",
   "00000100"
   );

begin

  process(clk)
  begin
    if falling_edge(clk) then
      reg(to_integer(unsigned(rd_addr))) <= wr_data;
    end if;
  end process;

  rs <= reg(to_integer(unsigned(rs_addr)));
  rt <= reg(to_integer(unsigned(rt_addr)));

end behavioral;
