# VASPbandplot
====  
a shell script to plot band structure from EIGENVAL and OUTCAR file  
run in the work directory of VASP or copy EIGENVAL (OUTCAR if use Gap.sh) to current directory  

Dependencies:  
gnuplot  
awk  

There are 3 ways to set the zero in plot (by EFERMI), uncomment for your choice:  
1. for metals, read fermi energy from OUTCAR  
2. for insulators, set as the VBM  
3. set by hand as you wish  
