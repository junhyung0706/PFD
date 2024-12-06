*************************************************
** Sign-Sign Mueller-Muller Phase Detector (SS-MM PD)
** Modified to generate UP and DOWN signals based on sign output.
*************************************************
.subckt SS_MM_PD x1 x2 x3 up down vdd vss

* Parameters for transistors
.param nch_w = 0.6u
.param nch_l = 0.18u
.param pch_w = 0.6u
.param pch_l = 0.18u

* Comparator for sign(x1)
mp_x1_cmp vdd x1 sign_x1 vdd pch W=pch_w L=pch_l
mn_x1_cmp vss x1 sign_x1 vss nch W=nch_w L=nch_l

* Comparator for sign(x2)
mp_x2_cmp vdd x2 sign_x2 vdd pch W=pch_w L=pch_l
mn_x2_cmp vss x2 sign_x2 vss nch W=nch_w L=nch_l

* Comparator for sign(x3)
mp_x3_cmp vdd x3 sign_x3 vdd pch W=pch_w L=pch_l
mn_x3_cmp vss x3 sign_x3 vss nch W=nch_w L=nch_l

* XOR logic for (sign(x1) - sign(x2)) * sign(x3)
mp_xor vdd sign_x1 n_xor sign_x2 pch W=pch_w L=pch_l
mn_xor vss sign_x1 n_xor sign_x2 nch W=nch_w L=nch_l

* Sign output (final phase comparison logic)
mp_sign_out vdd n_xor sign_out vdd pch W=pch_w L=pch_l
mn_sign_out vss n_xor sign_out vss nch W=nch_w L=nch_l

* Convert sign output to UP and DOWN signals
* If sign_out > 0, set UP = 1, DOWN = 0
* If sign_out < 0, set UP = 0, DOWN = 1
mp_up vdd sign_out up vdd pch W=pch_w L=pch_l
mn_down vss sign_out down vss nch W=nch_w L=nch_l

.ends SS_MM_PD
*************************************************


* Testbench for SS-MM PD
*************************************************
.lib '/home/lib/tsmc018.prm' TT

* Power supplies
Vdd vdd 0 1.0V
Vss vss 0 0V

* Input signals (example waveform)
Vx1 x1 0 PULSE(0 1 0 0.1n 0.1n 500p 1n)
Vx2 x2 0 PULSE(0 1 100p 0.1n 0.1n 500p 1n)
Vx3 x3 0 PULSE(0 1 200p 0.1n 0.1n 500p 1n)

* Instantiate the SS-MM PD
XSSMM_PD x1 x2 x3 up down vdd vss SS_MM_PD

* Simulation settings
.tran 0.01n 10n
.option post=2

.end
