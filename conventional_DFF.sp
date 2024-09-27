*conventional_DFF.sp

.subckt conventional_DFF F_ref UP UP_bar RST n_vdd n_vss
*I1
MN1     n_vss   F_ref   I1_out  n_vss   nch     L=0.18u     W=0.36u
MP1     n_vdd   F_ref   I1_out  n_vdd   pch     L=0.18u     W=0.54u

*I2
MN2     n_vss   I1_out   I2_out  n_vss  nch     L=0.18u     W=0.36u
MP2     n_vdd   I1_out   I2_out  n_vdd  pch     L=0.18u     W=0.54u

*1st line of main DFF
MP11	n_vdd	I2_out  node_A  n_vdd   pch     L=0.18u     W=0.54u
MN11	n_vss   RST     node_A  n_vss   nch     L=0.18u     W=0.36u

*2nd line of main DFF
MP12    n_vdd   node_A  UP_bar  n_vdd   pch     L=0.18u     W=0.54u
MN12    n_temp  F_ref   UP_bar  n_temp  nch     L=0.18u     W=0.36u
MN13    n_vss   node_A  n_temp  n_vss   nch     L=0.18u     W=0.36u

*3rd line of main DFF
MP13    n_vdd   UP_bar  UP      n_vdd   pch     L=0.18u     W=0.54u
MN14    n_vss   UP_bar  UP      n_vss   nch     L=0.18u     W=0.36u

.ends conventional_DFF
