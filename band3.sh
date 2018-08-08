#!/bin/bash 
# a shell script to plot band structure from EIGENVAL and OUTCAR file 
# run in the work directory of VASP or copy EIGENVAL KPOINTS OUTCAR to current directory

# i/o and binary file
eig_file='EIGENVAL'
band_file='band.dat'
kpt_file='kpt.dat'
gnu_file='gnuband2.plt'
GNUBIN="$HOME/bin/gnuplot"  # set to your gnuplot directory

# variable read from file
VALENT=`awk 'NR==6{print $1}' $eig_file`
  NKPT=`awk 'NR==6{print $2}' $eig_file`
 NBAND=`awk 'NR==6{print $3}' $eig_file`
 
# the zero in plot are set by EFERMI, uncomment for your choice
# EFERMI from OUTCAR
EFERMI=`grep  "E-fermi" OUTCAR|tail -1|awk '{print $3}'`  
# EFERMI from Gap.sh as the VBM
#VBM=`$HOME/bin/Gap.sh |awk '/VBM/{print $4}'`  # set to your Gap.sh directory
#EFERMI=$VBM
# EFERMI from hand
#EFERMI=6.396555

#variable set by hand
START=29 #skip leading k-points for HSE-manner of k-points
ymin=-10;ymax=5
# set to your xtics
xt1=1;xt2=101;xt3=201;xt4=999;xt5=999;xt6=999;xt7=999;xt8=999;xt9=999;xt10=999;xt11=999;xt12=999;xt13=999

echo -n "" > $band_file
for (( c=1; c <= NBAND; c++ ))
do
	awk '/ '"$c"' /{if(NR>6) print(NR-6-$1-2)/('"$NBAND"'+2)+1" "$2}' $eig_file >> $band_file
	echo "" >> $band_file
done

echo "reading $eig_file..."
echo "number of valent electrons=$VALENT"
echo "number of k points=" $NKPT
echo "number of bands=" $NBAND
echo "E-fermi=" $EFERMI " (from OUTCAR)"
echo "x range= `awk 'BEGIN{print '"$START"'+'"$xt1"'}'`:$NKPT"
echo "y range= $ymin:$ymax"

export GNUPLOT_PS_DIR="$HOME/download/gnuplot-5.0.0/term/PostScript"
cat > $gnu_file <<EOF
reset
#set terminal pngcairo size 380,880 enhanced font 'Times-Roman,15'
#set output "pict.png"
#set terminal postscript eps enhanced  "Times-Roman" 20 dashed
#set output 'band.eps'
#set terminal pdfcairo size 2.2in,4in enhanced font 'Times-Roman,15' 
#set output 'band.pdf'
set terminal svg size 380,880 enhanced font 'Times-Roman,15'
set output "pict.svg"

set label "(a)" at graph 0.05,graph 0.96

set bmargin 5
set tmargin 2
set lmargin 8
set rmargin 5

set label "(b)" at graph 0.05,graph 0.9
unset key
set multiplot
set xrange [$START+$xt1:$NKPT]
set yrange [$ymin:$ymax]
set ylabel "Energy (eV)" font "Times-Roman,15" offset -2,0
set xtics autojustify font "Times-Roman,15" 
set ytics autojustify font "Times-Roman,15"
set ytics nomirror in scale 1.5,1.5 
set ytics -14,2,10
set mytics 1

set xtics (\
"L" ($xt1+$START),\
"{/Symbol G}" $xt2+$START,\
"X" $xt3+$START,\
"X" $xt4+$START,\
"{/Symbol G}" $xt5+$START,\
"X" $xt6+$START,\
"X" $xt7+$START,\
"A" $xt8+$START,\
"A" $xt9+$START,\
"A" $xt10+$START,\
"A" $xt11+$START,\
"A" $xt12+$START,\
"A" $xt13+$START,\
"A" $xt14+$START)\
offset 0,-1

set arrow from $xt1+$START, $ymin to $xt1+$START, $ymax  nohead
set arrow from $xt2+$START, $ymin to $xt2+$START, $ymax  nohead
set arrow from $xt3+$START, $ymin to $xt3+$START, $ymax  nohead
set arrow from $xt4+$START, $ymin to $xt4+$START, $ymax  nohead
set arrow from $xt5+$START, $ymin to $xt5+$START, $ymax  nohead
set arrow from $xt6+$START, $ymin to $xt6+$START, $ymax  nohead
set arrow from $xt7+$START, $ymin to $xt7+$START, $ymax  nohead
set arrow from $xt8+$START, $ymin to $xt8+$START, $ymax  nohead
set arrow from $xt9+$START, $ymin to $xt9+$START, $ymax  nohead
set arrow from $xt10+$START, $ymin to $xt10+$START, $ymax  nohead
set arrow from $xt11+$START, $ymin to $xt11+$START, $ymax  nohead
set arrow from $xt12+$START, $ymin to $xt12+$START, $ymax  nohead

#set grid xtics lc rgb "black" lt 1 lw 2
#plot  $EFERMI-$EFERMI lc rgb "black"
#band(n) = sprintf ("band%d.dat", n) 
#plot for [i=1:11:1] band(i) using (\$2-$EFERMI) with lines lt 1 lw 1 lc rgb "blue" ,\
#for [i=13:14] band(i) using (\$2-$EFERMI) with lines lt 1 dt 1 lw 1 lc rgb "blue",\
#for [i=15:$NBAND:1] band(i) using (\$2-$EFERMI) with lines lt 1 lw 1 lc rgb "blue"\

plot "$band_file" using (\$1):(\$2-$EFERMI) with lines lt 1 lw 1 lc rgb "blue"

#set nomultiplot
#set size 10.3,10.3
#set encoding utf8
#set label font "Times-Roman,15" 
#set label 1 "(a)L" at 150,0.5
#set label 1 "(a)" at graph 0, graph 0
#show label
EOF

$GNUBIN $gnu_file

