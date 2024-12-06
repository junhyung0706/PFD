.subckt PFF d clk q q_bar rst vdd vss

* Internal nodes
.nodeset v(nodeX)=0 v(node12)=0 v(node23)=0
.nodeset v(clk1)=0 v(clk2)=0 v(clk3)=0

* Pulse Generator (PG)
*I1
mn_I1   vss         clk         clk1        vss     nch     L=0.2u      W=0.6u        
mp_I1   vdd         clk         clk1        vdd     pch     L=0.2u      W=0.6u
*I2
mn_I2   vss         clk1        clk2        vss     nch     L=0.6u      W=0.3u  
mp_I2   vdd         clk1        clk2        vdd     pch     L=0.6u      W=0.3u  
*I3
mn_I3   vss         clk2        clk3        vss     nch     L=0.2u      W=0.6u        
mp_I3   vdd         clk2        clk3        vdd     pch     L=0.2u      W=0.6u
  
* NAND logic to generate p_clk
mp_1    n_vdd       clk3        out_nand    n_vdd   pch     L=0.2u      W=0.6u
mp_2    n_vdd       clk         out_nand    n_vdd   pch     L=0.2u      W=0.6u
mn_1    temp_nand   clk3        out_nand    n_vss   nch     L=0.2u      W=0.6u
mn_2    n_vss       clk         temp_nand   n_vss   nch     L=0.2u      W=0.6u

* Inverter to generate reset pulse
mn_rst_inv vss       rst         rst_inv     vss     nch     L=0.2u      W=0.6u
mp_rst_inv vdd       rst         rst_inv     vdd     pch     L=0.2u      W=0.6u

*I4  
mn_I4   vss         out_nand    p_clk       vss     nch     L=0.5u      W=1.5u        
mp_I4   vdd         out_nand    p_clk       vdd     pch     L=0.5u      W=1.5u

* Main Flip-Flop Structure
MP1     vdd         vss         nodeX       vdd     pch     L=0.18u     W=0.36u  
MN1     node12      d           nodeX       vss     nch     L=0.4u      W=0.8u
MN2     node23      Q_fdbk      node12      vss     nch     L=0.6u      W=1.2u
MN3     vss         p_clk       node23      vss     nch     L=0.8u      W=1.6u
MP2     vdd         nodeX       q           vdd     pch     L=1.2u      W=2.4u
MNx     q           p_clk       d           vss     nch     L=0.4u      W=0.8u
MN_RST  vss         rst_inv     q           vss     nch     L=0.2u      W=0.6u

* Feedback Logic
mn_fd1   vss         q          Q_fdbk      vss     nch     L=0.2u      W=0.6u        
mp_fd1   vdd         q          Q_fdbk      vdd     pch     L=0.2u      W=0.6u
mn_fd2   vss         Q_fdbk     q           vss     nch     L=0.2u      W=0.6u        
mp_fd2   vdd         Q_fdbk     q           vdd     pch     L=0.2u      W=0.6u

* Output Inverter
mn_fI    vss         q          q_bar       vss     nch     L=0.5u      W=1.0u        
mp_fI    vdd         q          q_bar       vdd     pch     L=0.5u      W=1.0u

.ends PFF
