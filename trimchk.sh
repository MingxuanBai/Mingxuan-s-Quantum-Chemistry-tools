#!/bin/bash
for file in "$@"
do
	echo		"Trimming $file"
### Working around copychk's bug
	cp			"$file" "./TMP_$$.chk"
	echo -e	"./TMP_$$.chk\n./TMP_$$_$$.chk" | ~/g09/copychk
	rm			"./TMP_$$.chk"
	mv -v		"./TMP_$$_$$.chk" $(echo "$file" | gawk '{printf("%s", gensub("[^/]+/([^/]+)$","\\1","G"));}')
### Working around copychk's bug
	case $TEMPLATE in
	"SCAN")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# opt=(modredundant) def2svp geom(allcheck) guess(read) m062x

B	1	16	S	17	-0.1


--------------------------
		;;
	"OPTFREQ_SCRF")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# opt=(loose) def2tzvp geom(allcheck) guess(read) Integral(Grid=UltraFine) m062x scrf(SMD,Solvent=Acetonitrile)



--Link1--
# opt=(tight,maxstep=1) def2tzvp geom(allcheck) guess(read) Integral(Grid=UltraFine) m062x scrf(Checkpoint) scf(Conver=10) freq(noraman,HPModes)  Scale=0.970778999903785



--------------------------
		;;
	"OPT")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# opt=(rcfc,tight) def2tzvp geom(allcheck) guess(read) Integral(Grid=UltraFine) m062x



--------------------------
		;;
	"FREQ_OPT")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# freq(noraman,HPModes) def2svp geom(allcheck) guess(read) Integral(Grid=UltraFine) m062x



--Link1--
# opt=(rcfc,tight) freq(noraman,HPModes) def2tzvp geom(allcheck) guess(read) Integral(Grid=UltraFine) m062x



--------------------------
		;;
	"TS_SCRF")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# def2svp freq(noraman) geom(allcheck) guess(read) Integral(Grid=UltraFine) m062x scrf(SMD,Solvent=Acetonitrile)



--Link1--
# opt=(rcfc,ts,noeigentest,maxstep=2) def2tzvp geom(allcheck) guess(read) Integral(Grid=UltraFine) m062x scrf(SMD,Solvent=Acetonitrile)


--Link1--
# opt=(readfc,tight,ts,noeigentest,maxstep=1) freq(noraman,HPModes) def2tzvp geom(allcheck) guess(read) Integral(Grid=UltraFine) m062x scrf(Checkpoint) scf(Conver=10) Scale=0.970778999903785




--------------------------
		;;
	"TS_SMD")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# opt=(calcfc,ts,noeigentest) def2svp geom(allcheck) guess(read) Integral(Grid=UltraFine) m062x freq(noraman,HPModes) scrf(Checkpoint) Scale=0.969524997013085






--------------------------
		;;
	"TS")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# opt=(rcfc,ts,noeigentest,maxstep=2) def2tzvp geom(allcheck) guess(read) Integral(Grid=UltraFine) iop(1/7=1000) m062x


--Link1--
# opt=(readfc,tight,ts,noeigentest,maxstep=1) freq(noraman,HPModes) def2tzvp geom(allcheck) guess(read) Integral(Grid=UltraFine) m062x scf(Conver=10)




--------------------------
		;;
	"IRC")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# irc(rcfc,tight,MaxPoints=300,StepSize=20,lqa) def2svp geom(allcheck) guess(read) m062x


--------------------------
		;;
	"IRC_HPC")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# irc(rcfc,MaxPoints=400,RecalcFC=(Predictor=15,Corrector=11),StepSize=5,MaxCycle=50) def2svp geom(allcheck) guess(read) m062x scf(Conver=10)


--------------------------
		;;
	"IRC_PHASE")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# irc(rcfc,MaxPoints=800,Phase=(34,41),Reverse,lqa) def2svp geom(allcheck) guess(read) m062x integral=grid=ultrafine


--------------------------
		;;
	"IRC_DOWN")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# irc(calcfc,Downhill,MaxPoints=20,RecalcFC=(Predictor=9,Corrector=4),StepSize=1) def2svp geom(allcheck,NGeom=) m062x Integral(Grid=UltraFine)


--------------------------
		;;
	"TD")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# td(NStates=3) def2svp geom(allcheck) guess(read) m062x IOp(9/40=2)



--------------------------
		;;
	"TD_SCRF")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# td(NStates=3) def2tzvp geom(allcheck) guess(read) m062x IOp(9/40=2) scrf(SMD,Solvent=Acetonitrile) Integral(Grid=UltraFine)



--------------------------
		;;
	"FREQ_SCALE")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# m062x def2tzvp freq(noraman,ReadFC,HPModes) Integral(Grid=UltraFine) geom(allcheck) guess(read) Scale=0.970778999903785


--------------------------
		;;
	"FREQ_SCRF")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# m062x def2tzvp freq(noraman,HPModes) Integral(Grid=UltraFine) geom(allcheck) guess(read) Scale=0.970778999903785 scrf(Checkpoint)


--------------------------
		;;
	"FREQ_SCALE_TEMP_SCRF")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# m062x def2tzvp freq(noraman,ReadFC,HPModes) Integral(Grid=UltraFine) geom(allcheck) guess(read) Scale=0.970778999903785 scrf(Checkpoint) Temperature=278.15


--------------------------
		;;
	"FREQ_SCALE_TEMP_SCRF_ISOT")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# m062x def2tzvp freq(noraman,ReadFC,HPModes,ReadIsotopes) Integral(Grid=UltraFine) geom(allcheck) guess(read) Scale=0.970778999903785 scrf(Checkpoint)

298.15	1.0
1
2
12
12
12
12
12
12
12
1
12
12
14
12
12
1
12
1
1
12
12
1
1
1
1
1
1
1
1
12
12
12
12
12
12
1
12
1
12
12
1
1
12
12
12
12
1
12
12
16
12
12
1
12
1
1
12
1
1
1
1








--------------------------
		;;
	"SVP_FREQ_READISOTOPE")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# m062x def2svp freq(noraman,ReadFC,HPModes,ReadIsotopes) geom(allcheck) guess(read) Scale=0.96872719 scrf(Checkpoint)

298.15	1.0
12
12
12
1
12
1
12
1
12
1
14
14
12
12
12
1
12
2
2
2
2
2
2
12
12
12
1
12
1
12
1
1
1
1
12
12
12
12
12
12
1
12
1
12
12
1
12
12
12
12
1
12
12
32
12
12
1
12
1
1
12
1
1
1
1
1








--------------------------
		;;
	"SVP_FREQ_READISOTOPE_ULTRAFINE")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# m062x def2svp Integral(Grid=UltraFine) freq(noraman,ReadFC,HPModes,ReadIsotopes) geom(allcheck) guess(read) Scale=0.969524997 scrf(Checkpoint)

298.15	1.0
12
12
12
1
12
1
12
1
12
1
14
14
12
12
12
1
12
2
2
2
2
2
2
12
12
12
1
12
1
12
1
1
1
1
12
12
12
12
12
12
1
12
14
12
1
1
12
12
12
12
1
1
1
12
1
12
1
1
1
1







--------------------------
		;;
	"SVP_COUNTERPOISE_ULTRAFINE")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# m062x def2svp integral=grid=ultrafine Counterpoise=2 geom(Checkpoint) scrf(Checkpoint)

SVP_COUNTERPOISE_ULTRAFINE

1 1 1 1 0 1







--------------------------
		;;
	"SVP_SCALE")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# m062x def2svp freq(noraman,ReadFC) geom(allcheck) guess(read) Scale=0.96872719 scrf(Checkpoint)








--------------------------
		;;
	"SP_aug_cc_pvtz")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# m062x aug-cc-pvtz Integral(Grid=UltraFine) geom(allcheck) guess(read) scf(NoIncFock,NoVarAcc,MaxCycle=64) int=acc2e=12


--------------------------
		;;
	"SP_aug_cc_pvtz_SCRF")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# m062x aug-cc-pvtz Integral(Grid=UltraFine) geom(allcheck) guess(read) scrf(Checkpoint) scf(NoIncFock,NoVarAcc,MaxCycle=64) int=acc2e=12


--------------------------
		;;
	"SP")
		cat << -------------------------- > $(echo "$file" | gawk '{print gensub("[^/]+/([^/]+).chk$","\\1","G");}')
# m062x genecp scf(NoIncFock) geom(allcheck) guess(read)

-H
S   3   1.00
     34.061341000            0.60251978000E-02
      5.1235746000           0.45021094000E-01
      1.1646626000           0.20189726000
S   1   1.00
      0.32723041000          1.0000000
S   1   1.00
      0.10307241000          1.0000000
P   1   1.00
      1.4070000000           1.0000000
P   1   1.00
      0.38800000000          1.0000000
P   1   1.00
      0.95774129632E-01            1.0000000
D   1   1.00
      1.0570000000           1.0000000
****
-C
S   6   1.00
  13575.3496820              0.22245814352E-03
   2035.2333680              0.17232738252E-02
    463.22562359             0.89255715314E-02
    131.20019598             0.35727984502E-01
     42.853015891            0.11076259931
     15.584185766            0.24295627626
S   2   1.00
      6.2067138508           0.41440263448
      2.5764896527           0.23744968655
S   1   1.00
      0.57696339419          1.0000000
S   1   1.00
      0.22972831358          1.0000000
S   1   1.00
      0.95164440028E-01            1.0000000
S   1   1.00
      0.48475401370E-01            1.0000000
P   4   1.00
     34.697232244            0.53333657805E-02
      7.9582622826           0.35864109092E-01
      2.3780826883           0.14215873329
      0.81433208183          0.34270471845
P   1   1.00
      0.28887547253          1.0000000
P   1   1.00
      0.10056823671          1.0000000
D   1   1.00
      1.0970000000           1.0000000
D   1   1.00
      0.31800000000          1.0000000
D   1   1.00
      0.90985336424E-01            1.0000000
F   1   1.00
      0.76100000000          1.0000000
****
-N
S   6   1.00
  19730.8006470              0.21887984991E-03
   2957.8958745              0.16960708803E-02
    673.22133595             0.87954603538E-02
    190.68249494             0.35359382605E-01
     62.295441898            0.11095789217
     22.654161182            0.24982972552
S   2   1.00
      8.9791477428           0.40623896148
      3.6863002370           0.24338217176
S   1   1.00
      0.84660076805          1.0000000
S   1   1.00
      0.33647133771          1.0000000
S   1   1.00
      0.13647653675          1.0000000
S   1   1.00
      0.68441605847E-01            1.0000000
P   4   1.00
     49.200380510            0.55552416751E-02
     11.346790537            0.38052379723E-01
      3.4273972411           0.14953671029
      1.1785525134           0.34949305230
P   1   1.00
      0.41642204972          1.0000000
P   1   1.00
      0.14260826011          1.0000000
D   1   1.00
      1.6540000000           1.0000000
D   1   1.00
      0.46900000000          1.0000000
D   1   1.00
      0.12829642058          1.0000000
F   1   1.00
      1.0930000000           1.0000000
****
-O
S   6   1.00
  27032.3826310              0.21726302465E-03
   4052.3871392              0.16838662199E-02
    922.32722710             0.87395616265E-02
    261.24070989             0.35239968808E-01
     85.354641351            0.11153519115
     31.035035245            0.25588953961
S   2   1.00
     12.260860728            0.39768730901
      4.9987076005           0.24627849430
S   1   1.00
      1.1703108158           1.0000000
S   1   1.00
      0.46474740994          1.0000000
S   1   1.00
      0.18504536357          1.0000000
S   1   1.00
      0.70288026270E-01            1.0000000
P   4   1.00
     63.274954801            0.60685103418E-02
     14.627049379            0.41912575824E-01
      4.4501223456           0.16153841088
      1.5275799647           0.35706951311
P   1   1.00
      0.52935117943          1.0000000
P   1   1.00
      0.17478421270          1.0000000
P   1   1.00
      0.51112745706E-01            1.0000000
D   1   1.00
      2.3140000000           1.0000000
D   1   1.00
      0.64500000000          1.0000000
D   1   1.00
      0.14696477366          1.0000000
F   1   1.00
      1.4280000000           1.0000000
****



--------------------------
		;;
	esac
done
# opt=(rcfc,tight) freq(noraman,HPModes) def2tzvp geom(allcheck) guess(read) Integral(Grid=UltraFine) m062x
# opt=(rcfc,tight,ts,noeigentest) freq(noraman,HPModes) def2tzvp geom(allcheck) guess(read) Integral(Grid=UltraFine) m062x
# opt=(rcfc,tight,ts,noeigentest,NoFreeze) freq(noraman,HPModes) def2svp geom(allcheck) guess(read) m062x
# opt=(tight,NoFreeze) freq(noraman,HPModes) def2svp m062x geom(allcheck) guess(read)
# td(NStates=10,50-50) def2tzvp geom(allcheck) guess(read) Integral(Grid=UltraFine) m062x
# irc(rcfc,tight,MaxPoints=1000,StepSize=5,MaxCycle=20,RecalcFC(Predictor=15,Corrector=7)) def2svp geom(allcheck) guess(read) m062x

## freq(anharm,ReadIsotopes) geom(allcheck) guess(read) Integral(Grid=UltraFine) aug-cc-pvtz B2PLYPD3

#298.15	1.0
#16
#1
#2
#16
#1
#1
