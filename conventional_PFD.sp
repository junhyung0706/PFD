*************************************************
**conventional_PFD.sp
**conventional PFD code for REU 
**2024/09/27 Kim Junhyung
*************************************************
.include "/home/under_design6/hspice/mysource/conventional_DFF.sp"
.include "/home/under_design6/hspice/mysource/inverter.sp"

.lib '/home/lib/tsmc018.prm' TT

.param vdd = 1.0 
.param trf = 10p
.param pmos_w = 0.54u
.param pmos_l = 0.18u
.param nmos_w = 0.36u
.param nmos_l = 0.18u
.param nmos_clk_l = 0.18u*2

.option post node list
************************************************

**Set the voltage node from voltage source, vdd, vss, current source
v_vdd		n_vdd		0		vdd
v_vss		n_vss		0		0
v_ref		n_in		n_vss		pulse(0v	vdd	0	trf	trf	500p	1n)
v_clk		n_clk		n_vss		pulse(0v	vdd	0	trf	trf	500p	1n)


$$ PFD Circuit $$
*upper DFF
x_DFF1  n_in   UP      UP_bar  RST     n_vdd   n_vss    conventional_DFF

*lower DFF
x_DFF2  n_clk   DN      DN_bar  RST     n_vdd   n_vss   conventional_DFF

*gate
MP1     n_vdd       UP_bar      n_temp1     n_vdd       pch     L=0.18u     W=0.36u
MP2     n_temp1     DN_bar      n_temp2     n_temp1     pch     L=0.18u     W=0.54u
MN1     n_vss       UP_bar      n_temp2     n_vss       nch     L=0.18u     W=0.36u
MN2     n_vss       DN_bar      n_temp2     n_vss       nch     L=0.18u     W=0.36u

*I5
x_I5    n_temp2     I5_out      n_vdd       n_vss       inverter

*I6
x_I6    I5_out      RST         n_vdd       n_vss       inverter

*************************************************
$$ simulation $$

.tran	0.01p	10n 
*************************************************

.end
