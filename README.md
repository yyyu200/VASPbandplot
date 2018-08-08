# VASPbandplot
====  
a shell script to plot band structure from EIGENVAL (OUTCAR if use fermi level) file  
run in the work directory of VASP or copy EIGENVAL to current directory  

Dependencies:  
gnuplot  
awk  
optional : Gap.sh ( see https://github.com/eveshower/VASPGap )

There are 3 ways to set the zero in plot (by EFERMI), uncomment for your choice:  
1. for metals, read fermi level from OUTCAR  
2. for insulators, set as the VBM  
3. set by hand as you wish  
