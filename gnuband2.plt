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
set xrange [29+1:10]
set yrange [-10:5]
set ylabel "Energy (eV)" font "Times-Roman,15" offset -2,0
set xtics autojustify font "Times-Roman,15" 
set ytics autojustify font "Times-Roman,15"
set ytics nomirror in scale 1.5,1.5 
set ytics -14,2,10
set mytics 1

set xtics ("L" (1+29),"{/Symbol G}" 101+29,"X" 201+29,"X" 999+29,"{/Symbol G}" 999+29,"X" 999+29,"X" 999+29,"A" 999+29,"A" 999+29,"A" 999+29,"A" 999+29,"A" 999+29,"A" 999+29,"A" +29)offset 0,-1

set arrow from 1+29, -10 to 1+29, 5  nohead
set arrow from 101+29, -10 to 101+29, 5  nohead
set arrow from 201+29, -10 to 201+29, 5  nohead
set arrow from 999+29, -10 to 999+29, 5  nohead
set arrow from 999+29, -10 to 999+29, 5  nohead
set arrow from 999+29, -10 to 999+29, 5  nohead
set arrow from 999+29, -10 to 999+29, 5  nohead
set arrow from 999+29, -10 to 999+29, 5  nohead
set arrow from 999+29, -10 to 999+29, 5  nohead
set arrow from 999+29, -10 to 999+29, 5  nohead
set arrow from 999+29, -10 to 999+29, 5  nohead
set arrow from 999+29, -10 to 999+29, 5  nohead

#set grid xtics lc rgb "black" lt 1 lw 2
#plot  1.9132-1.9132 lc rgb "black"
#band(n) = sprintf ("band%d.dat", n) 
#plot for [i=1:11:1] band(i) using ($2-1.9132) with lines lt 1 lw 1 lc rgb "blue" ,#for [i=13:14] band(i) using ($2-1.9132) with lines lt 1 dt 1 lw 1 lc rgb "blue",#for [i=15:13:1] band(i) using ($2-1.9132) with lines lt 1 lw 1 lc rgb "blue"
plot "band.dat" using ($1):($2-1.9132) with lines lt 1 lw 1 lc rgb "blue"

#set nomultiplot
#set size 10.3,10.3
#set encoding utf8
#set label font "Times-Roman,15" 
#set label 1 "(a)L" at 150,0.5
#set label 1 "(a)" at graph 0, graph 0
#show label
