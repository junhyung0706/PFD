* DFF2.sp

.subckt DFF2 d clk rst q vdd vss

* Internal nodes
.nodeset v(n_int1)=0 v(n_int2)=0 v(n_clk_bar)=0

$$ ultra low power DFF
***********
mp1     vdd     d       node1   vdd     pch     l=0.18u     w=0.54u
mp2     vdd     node1   q       vdd     pch     l=0.18u     w=0.54u
mn1     node2   clk     node1   vss     nch     l=0.18u     w=0.36u
mn2     vss     d       node2   vss     nch     l=0.18u     w=0.36u
mn3     vss     node2   q       vss     nch     l=0.18u     w=0.36u
mn_rst  vss     rst     q       vss     nch     l=0.18u     w=0.36u
************
.ends DFF2
