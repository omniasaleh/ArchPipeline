LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

ENTITY decode IS
PORT( Clk,Rst,flagC,flagN,flagZ,stall,wB1,wb2        : IN std_logic;
	FEDE         : in std_logic_vector ( 26 downto 0);
	writeadd1,writeadd2 : in std_logic_vector (2 downto 0);
	outSignal    : out std_logic_vector(16 downto 0);
	aluoperation :out std_logic_vector (3 downto 0);
	data1,data2         : out std_logic_vector (15 downto 0);
	outadd1,outadd2     : out std_logic_vector (2 downto 0);
	inportdata,indata1,indata2 : in std_logic_vector (15 downto 0);
	immforldm : in std_logic_vector (15 downto 0);
	ackint :out std_logic
	--seldata1,seldata2  : std_logic_vector (1 dowtn to 0);
	--EMval,MWval        : std_logic_vector (15 dowtn to 0)
); 
END decode;
architecture  Flowdecode of  decode IS

component control IS
PORT( Clk,Rst,flagC,flagN,flagZ        : IN std_logic;
	inst        : in std_logic_vector ( 15 downto 0);
	int         : in std_logic;
	outSignal    : out std_logic_vector(16 downto 0);
	aluoperation :out std_logic_vector (3 downto 0)
); 
END component control;
component registerfiledecoding IS
PORT( Clk,Rst,wB1,wb2        : IN std_logic;
	add1,add2,writeadd1,writeadd2        : in std_logic_vector (2 downto 0);
	indata1,indata2    : in std_logic_vector(15 downto 0);
	
	outdata1,outdata2    : out std_logic_vector(15 downto 0)
); 
END component  registerfiledecoding;
signal signals : std_logic_vector(16 downto 0);
signal inputadd2 : std_logic_vector (2 downto 0);
signal out1,out2,out1b,out2b,out2bldm,out2bshf :std_logic_vector (15 downto 0);
signal pcinc :std_logic_vector (9 downto 0);
signal pc   : std_logic_vector (9 downto 0);
signal inst : std_logic_vector (15 downto 0);
signal int :std_logic;
signal outadd2b : std_logic_vector (2 downto 0);
begin
inst<=FEDE( 15 downto 0);
pc  <= FEDE(25 downto 16);
int<=FEDE(26);
controlunit : control port map (clk,rst,flagc,flagn,flagz,inst,int,signals,aluoperation);
inputadd2<= inst(10 downto 8) when signals(16)='0' --regdes
else inst( 13 downto 11);
registerfile:registerfiledecoding  port map (clk,rst,WB1,WB2,inst( 13 downto 11),inputadd2,writeadd1,writeadd2,indata1,
indata2,out1,out2
);
out1b<=out1 when (signals(3)='0' and signals(6) ='0')--mem,inport
else inportdata when (signals(3)='0' and signals(6)='1')
else "000000"&inst(10 downto 1);

out2bldm<= out2b when signals(5)='0'--ldm
else  immforldm;

pcinc<= std_logic_vector (unsigned (pc)+1);
out2bshf<= out2bldm when signals(4)='0'--shf
else "000000000000"&inst(3 downto 0);

out2b <= out2 when (signals(2)='0' and signals(1)='0')--int,call
else "000000"&pcinc  when (signals(2)='0' and signals(1)='1')
else "000000"&pc;

data1<=out1b;
data2<=out2bshf;
outsignal<="00000000000000000" when stall='1'
else signals;
outadd1<=inst(13 downto 11);
outadd2b<=inputadd2;
outadd2<=outadd2b when signals(1)='0'
else "111";
ackint<=signals(2);
END architecture  Flowdecode;
