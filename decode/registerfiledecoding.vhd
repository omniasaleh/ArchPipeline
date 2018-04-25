LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY registerfiledecoding IS
PORT( Clk,Rst,wB1,wb2        : IN std_logic;
	add1,add2,writeadd1,writeadd2        : in std_logic_vector (2 downto 0);
	indata1,indata2   : in std_logic_vector(15 downto 0);
	
	outdata1,outdata2    : out std_logic_vector(15 downto 0)
); 

END registerfiledecoding;
ARCHITECTURE   dataflow of registerfiledecoding IS
component my_nDFFrising IS
GENERIC ( n : integer := 16);
PORT( Clk,Rst        : IN std_logic;
		  EN : IN STD_LOGIC;
		   d : IN std_logic_vector(n-1 DOWNTO 0);
		   q : OUT std_logic_vector(n-1 DOWNTO 0));
END component my_nDFFrising;
signal outr0,outr1,outr2,outr3,outr4,outr5,inr0,inr1,inr2,inr3,inr4,inr5 :std_logic_vector (15 downto 0);
signal en0,en1,en2,en3,en4,en5 :std_logic;
signal is10,is11,is12,is13,is14,is15,is20,is21,is22,is23,is24,is25 :std_logic;
begin 

r0:my_nDFFrising  port map (clk,rst,en0,inr0,outr0);
r1:my_nDFFrising  port map (clk,rst,en1,inr1,outr1);
r2:my_nDFFrising  port map (clk,rst,en2,inr2,outr2);
r3:my_nDFFrising  port map (clk,rst,en3,inr3,outr3);
r4:my_nDFFrising  port map (clk,rst,en4,inr4,outr4);
r5:my_nDFFrising  port map (clk,rst,en5,inr5,outr5);

outdata1<= outr0 when add1="000"
else outr1 when add1="001"
else outr2 when add1="010"
else outr3 when add1="011"
else outr4 when add1="100"
else outr5;

outdata2<= outr0 when add2="000"
else outr1 when add2="001"
else outr2 when add2="010"
else outr3 when add2="011"
else outr4 when add2="100"
else outr5;

inr0<= indata1 when is10='1'
else indata2 when is20='1'
else "0000000000000000";

inr1<= indata1 when is11='1'
else indata2 when is21='1'
else "0000000000000000";

inr2<= indata1 when is12='1'
else indata2 when is22='1'
else "0000000000000000";

inr3<= indata1 when is13='1'
else indata2 when is23='1'
else"0000000000000000";

inr4<= indata1 when is14='1'
else indata2 when is24='1'
else "0000000000000000";

inr5<= indata1 when is15='1'
else indata2 when is25='1'
else "0000000000000000";

is10<= '1' when writeadd1="000"
else '0';

is11<= '1' when writeadd1="001"
else '0';

is12<= '1' when writeadd1="010"
else '0';

is13<= '1' when writeadd1="011"
else '0';

is14<= '1' when writeadd1="100"
else '0';

is15<= '1' when writeadd1="101"
else '0';

is20<= '1' when writeadd2="000"
else '0';

is21<= '1' when writeadd2="001"
else '0';

is22<= '1' when writeadd2="010"
else '0';

is23<= '1' when writeadd2="011"
else '0';

is24<= '1' when writeadd2="100"
else '0';

is25<= '1' when writeadd2="101"
else '0';

en0<= '1' when ( is10 ='1' and wb1='1' )or( is20='1'  and wb2='1')
else '0';

en1<= '1' when ( is11='1'  and wb1='1' )or( is21='1'  and wb2='1')
else '0';

en2<= '1' when ( is12 ='1' and wb1='1' )or( is22='1'  and wb2='1')
else '0';

en3<= '1' when ( is13 ='1' and wb1='1' )or( is23='1'  and wb2='1')
else '0';

en4<= '1' when ( is14='1'  and wb1='1' )or( is24='1'  and wb2='1')
else '0';

en5<= '1' when ( is15 ='1' and wb1='1' )or( is25='1'  and wb2='1')
else '0';

END ARCHITECTURE   dataflow;
