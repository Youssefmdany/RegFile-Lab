library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;  

entity RegFile is
    Port (
        clk         : in  STD_LOGIC;
        regWrite    : in  STD_LOGIC;
        readReg1    : in  STD_LOGIC_VECTOR(4 downto 0);
        readReg2    : in  STD_LOGIC_VECTOR(4 downto 0);
        writeReg    : in  STD_LOGIC_VECTOR(4 downto 0);
        writeData   : in  STD_LOGIC_VECTOR(31 downto 0);
        readData1   : out STD_LOGIC_VECTOR(31 downto 0);
        readData2   : out STD_LOGIC_VECTOR(31 downto 0)
    );
end RegFile;

architecture Behav of RegFile is
    type reg_array is array (0 to 31) of STD_LOGIC_VECTOR(31 downto 0);
    signal registers : reg_array := (others => (others => '0'));
begin

    process(clk)
    begin
        if rising_edge(clk) then
     
            if regWrite = '1' then
                registers(to_integer(unsigned(writeReg))) <= writeData;
            end if;
        end if;
    end process;



    process(clk)
    begin
        if falling_edge(clk) then
     
          readData1 <= registers(to_integer(unsigned(readReg1)));
          readData2 <= registers(to_integer(unsigned(readReg2)));
          
        end if;
    end process;



end Behav;




library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RegFile_tb is

end RegFile_tb;

architecture Behav_tb of RegFile_tb is

    component RegFile
        Port (
            clk         : in  STD_LOGIC;
            regWrite    : in  STD_LOGIC;
            readReg1    : in  STD_LOGIC_VECTOR(4 downto 0);
            readReg2    : in  STD_LOGIC_VECTOR(4 downto 0);
            writeReg    : in  STD_LOGIC_VECTOR(4 downto 0);
            writeData   : in  STD_LOGIC_VECTOR(31 downto 0);
            readData1   : out STD_LOGIC_VECTOR(31 downto 0);
            readData2   : out STD_LOGIC_VECTOR(31 downto 0)
        );
    end component;

    signal clk         : STD_LOGIC := '0';
    signal regWrite    : STD_LOGIC := '0';
    signal readReg1    : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal readReg2    : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal writeReg    : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
    signal writeData   : STD_LOGIC_VECTOR(31 downto 0) := (others => '0');
    signal readData1   : STD_LOGIC_VECTOR(31 downto 0);
    signal readData2   : STD_LOGIC_VECTOR(31 downto 0);


begin

    RegFile_inst: RegFile
        Port map (
            clk => clk,
            regWrite => regWrite,
            readReg1 => readReg1,
            readReg2 => readReg2,
            writeReg => writeReg,
            writeData => writeData,
            readData1 => readData1,
            readData2 => readData2
        );

    process
    begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
    end process;

   process
    begin

        wait for 20 ns;
 
        writeReg <= "00001";
        writeData <= X"ABBAABBA";
        regWrite <= '1';
        wait for 12 ns;

        regWrite <= '0';
        readReg1 <= "00001";
        wait for 12 ns;

  
        writeReg <= "00010";
        writeData <= X"FFFFFFFF";
        regWrite <= '1';
        wait for 12 ns;

        regWrite <= '0';
        readReg2 <= "00010";
        wait for 12 ns;

        writeReg <= "00011";
        writeData <= X"01010101";
        regWrite <= '1';
        readReg1 <= "00011";
        wait for 12 ns;

        readReg1 <= "00100";
        wait for 12 ns;

        writeReg <= "00101";
        writeData <= X"CACACACA";
        regWrite <= '0';
        wait for 12 ns;


        readReg1 <= "00101";
        wait for 12 ns;



        writeReg <= "10000";
        writeData <= X"11110000";
        regWrite <= '0';
        wait for 12 ns;


        readReg1 <= "10000";
        wait for 12 ns;
    
        wait;
    end process;

end Behav_tb;
