*************************************************
**conventional_PFD.sp
**conventional PFD code for REU 
**2024/09/27 Kim Junhyung
*************************************************
.include "/home/under_design6/hspice/mysource/conventional_DFF.sp"
.include "/home/under_design6/hspice/mysource/inverter.sp"

.lib '/home/lib/tsmc018.prm' TT

.param  vdd = 1.0 
.param  trf = 10p
.param  pmos_w = 0.54u
.param  pmos_l = 0.18u
.param  nmos_w = 0.36u
.param  nmos_l = 0.18u
.param  nmos_clk_l = 0.09u * 2

.option post node list
.TEMP   25
************************************************

**Set the voltage node from voltage source, vdd, vss, current source
v_vdd		n_vdd		0		vdd
v_vss		n_vss		0		0
v_ref		n_ref		n_vss		pulse(0v	vdd	0	    trf	trf	500p	1n)
v_clk		n_clk		n_vss		pulse(0v	vdd	200p	trf	trf	500p	1n)
v_in1       n_in1       0       vdd
v_in2       n_in2       0       vdd
* Internal nodes
.nodeset v(nodeA)=0 v(nodeB)=0 v(nodeC)=0 v(nodeD)=0 v(RST)=0


$$ PFD Circuit $$
********************************************************************************************
** Upper TSPC DFF
*1st line of main DFF
MPu11   n_vdd   n_in1   nodeA  n_vdd   pch     L=pmos_l     W=pmos_w
MNu12   nodeB   n_ref   nodeA  n_vss   nch     L=nmos_l     W=nmos_w
MNu13   n_vss   n_in1   nodeB  n_vss   nch     L=nmos_l     W=nmos_w
*2nd line of main DFF
MPu21   n_vdd   nodeA   out1    n_vdd   pch    L=pmos_l     W=pmos_w
MNu22   n_vss   nodeB   out1    n_vss   nch    L=nmos_l     W=nmos_w 
MNUrst  n_vss   RST     n_in1   n_vss   nch    L=nmos_l     W=nmos_w
MNUclk  out1_1  n_ref   out1    n_vss   nch     L=nmos_l     W=nmos_w
*3rd line of main DFF
x_ui1   out1_1  UP_bar  n_vdd   n_vss   inverter
x_ui2   UP_bar  n_UP    n_vdd   n_vss   inverter
********************************************************************************************
** Lower TSPC DFF
*1st line of main DFF
MPl11   n_vdd   n_in2    nodeC  n_vdd   pch     L=pmos_l     W=pmos_w
MNl12	nodeD   n_clk   nodeC  n_vss   nch     L=nmos_l     W=nmos_w
MNl13   n_vss   n_in2    nodeD  n_vss   nch     L=nmos_l     W=nmos_w
*2nd line of main DFF
MPl21   n_vdd   nodeC   out2    n_vdd   pch    L=pmos_l     W=pmos_w
MNl22   n_vss   nodeD   out2    n_vss   nch    L=nmos_l     W=nmos_w 
MNLrst  n_vss   RST     n_in2   n_vss   nch    L=nmos_l     W=nmos_w
MNLclk  out2_2  n_ref   out2    n_vss   nch     L=nmos_l     W=nmos_w
*3rd line of main DFF
x_li1   out2_2  DN_bar  n_vdd   n_vss   inverter
x_li2   DN_bar  n_DN    n_vdd   n_vss   inverter
*********************************************************************************************
*gate
MP1         n_vdd       UP_bar      n_temp1     n_vdd       pch     L=pmos_l    W=pmos_w
MP2         n_temp1     DN_bar      n_temp2     n_temp1     pch     L=pmos_l    W=pmos_w
MN1         n_vss       UP_bar      n_temp2     n_vss       nch     L=nmos_l    W=nmos_w
MN2         n_vss       DN_bar      n_temp2     n_vss       nch     L=nmos_l    W=nmos_w
**********************************************************************************************
*I5
x_I5        n_temp2     I5_out      n_vdd       n_vss       inverter

*I6
x_I6        I5_out      RST         n_vdd       n_vss       inverter

*********************************************************************************************
$$ simulation $$

* 전력 소모 측정
.MEASURE TRAN avg_power AVG P(v_vdd) FROM=5n TO=10n

* Setup Time 측정
.MEASURE TRAN tsu_value TRIG v(n_in)=0.9 RISE=1 TARG v(n_clk)=0.9 RISE=1

* Reset Time 측정
.MEASURE TRAN reset_time TRIG v(I5_out)=0.9 RISE=1 TARG v(RST)=0.9 RISE=1

* 트랜지언트 분석 시간 설정
.tran 0.01p 200n

*************************************************

.end
