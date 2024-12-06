* inverter.sp

.subckt inverter n_in n_out n_vdd n_vss
MN	n_vss	n_in	n_out	n_vss	nch	L=0.18u	W=0.36u	
MP	n_vdd	n_in	n_out	n_vdd	pch	L=0.18u	W=0.54u
.ends inverter
