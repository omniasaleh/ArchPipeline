LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
ENTITY control IS
PORT( Clk,Rst,flagC,flagN,flagZ        : IN std_logic;
	inst        : in std_logic_vector ( 15 downto 0);
	int : in std_logic;
	outSignal    : out std_logic_vector(16 downto 0);
	aluoperation :out std_logic_vector (3 downto 0)
); 
END control;
architecture  Flowcontrol of control is 

signal otherinst,alu,mem,movAndOther,mov,nop,inport,outport,ldm,ldd,store,ret,reti,jmp,call,pop,push,mul,jmpornot,
 aluexceptnooperand  :std_logic;
begin
movAndOther <=inst(15)nor inst(14);
alu<=(not inst(15)) and inst(14);
mem<=inst(15) and (not inst(14));
otherinst<=inst(15) and inst(14);
MOV <=movANdOther and inst(7);
NOP<= movANdOther and inst(6);
inport<= movANdOther and inst(5);
outport<= movANdOther and inst(4);
LDM <=movANdOther and inst(3);
LDD <= mem and inst(0);
store<= mem  and (not inst (0));
Ret<=otherinst and inst(10);
jmp<=otherinst and inst(9);
pop<=otherinst and inst(7);
push<=otherinst and inst(6);
Reti<=otherinst and inst(2);
call<=otherinst and inst(8);
mul <= alu and ((inst(7) nor inst (6)) and ( inst(5) and inst (4)));
jmpornot <= flagZ when ( inst (4)='0' and inst (3)='0')
else flagN when ( inst (4)='0' and inst (3)='1')
else flagC when ( inst (4)='1' and inst (3)='0')
else '1';
aluexceptNooperand<= alu and not(inst(7) and inst(6) and inst (5));

outSignal(0) <= jmpornot and (jmp or call);--taken
outSignal(1) <=call;--call
outSignal(2) <=int;--int
outSignal(3)<=mem;--mem
outSignal(4)<=alu and (  ( inst(7) and (not inst(6)) and  (not inst (5)) )  );--shf
outSignal(5)<=ldm;--ldm
outSignal(6)<=inport;--inport
outSignal(7)<=outport;--outport
outSignal(8)<=store or call or int or push; --mem WR
outSignal(9)<=ldd or ret or reti or pop;--memRD
outSignal(10)<=ret or reti or pop;--spinc
outSignal(11)<=call or int or push;--spdec
outSignal(12)<=reti;--enflag

outSignal(13)<=ret or reti;--pcen
outSignal(14)<=mov or inport or ldm or aluexceptnooperand or ldd or pop;--rgwb1
outSignal(15)<=mul;--rgwb2
outSignal(16)<=mem or otherinst; -- ghaa lsa htrod regdes

aluoperation <= inst(7)&inst(6)&inst(5)&inst(4) when alu='1'
else "0001" when (mov='1' or ldm='1')
else "0000";

--writeStack<=otherinst and (inst(8) or inst(6) or inst (5));--push,call,int
--readStack <=otherinst and (inst(10) or inst(2) or inst (7));--pop,ret,reti

--aluoperation   <= inst(7)&inst(6)&inst(5)&inst(4) when alu    --aluoperation 
--else ;

end   Flowcontrol;
