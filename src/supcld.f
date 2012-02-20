      SUBROUTINE SUPCLD
C
C  THIS ROUTINE YIELDS THE SUPERSONIC WING ACCELERATION DERIVATIVE,CLAD
C
      INTEGER Y14111,D14111,D24111,D34111,D3A111,Y1A111,D1A111,D2A111
      REAL MACOE
      REAL MACH,LSTAR,LAMDA
      COMMON /OVERLY/ NLOG,NMACH,IM,NALPHA
      COMMON /OPTION/ SR,CBARR,RUFF,BLREF
      COMMON /CONSNT/ PI,DR,UNUSED,RAD
      COMMON /FLGTCD/ FLC(93)
      COMMON /SUPWH/  SLG(141)
      COMMON /POWR/   DYN(213)
      COMMON /WINGD/  A(195)
      COMMON /IWING/  PWING, WING(400)
      COMMON /WINGI/  WINGIN(101)
      COMMON /FLOLOG/ FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,
     1                HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,
     2                SUPERS,SUBSON,TRANSN,HYPERS,
     3                SYMFP,ASYFP,TRIMC,TRIM
      LOGICAL FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1        HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,
     2        SUPERS,SUBSON,TRANSN,HYPERS,
     3        SYMFP,ASYFP,TRIMC,TRIM
      DIMENSION ROUTID(2)
      DIMENSION Q71417(3),Q14111(3)
      DIMENSION I2A417(4),I2B417(4),I2C417(4)
      DIMENSION X2A417(16),Y1A417(16)
      DIMENSION X2B417(26),Y1B417(26)
      DIMENSION X2C417(15),Y1C417(15)
      DIMENSION X24111(15),X14111(7),X34111(5),Y14111(263)
      DIMENSION D14111( 99),D24111( 95),D34111(69)
      DIMENSION X2A111(15),X1A111(7),X3A111(5),Y1A111(263)
      DIMENSION D1A111( 99),D2A111( 95),D3A111( 69)
      EQUIVALENCE (D14111(1),Y14111(1)),(D24111(1),Y14111(100))
      EQUIVALENCE (D34111(1),Y14111(195))
      EQUIVALENCE (D1A111(1),Y1A111(1)),(D2A111(1),Y1A111(100))
      EQUIVALENCE (D3A111(1),Y1A111(195))
      EQUIVALENCE (MACOE,A(16)),(LSTAR,A(29)),
     1            (XACCR,SLG(134)),(CRSTR,A(10)),
     2            (ASTRW,A(7)),(LAMDA ,A(27)),(BETA,SLG(1)),
     3            (TANLE,A(62)),(SW,A(3))
      EQUIVALENCE (EPPBC,DYN(9)),(GBC,DYN(10)),(XACCRB,DYN(14)),
     1       (F2N,DYN(24)),(F3X,DYN(25)),(F1N,DYN(23)),(CLAD1,DYN(22)),
     2       (CLAD2,DYN(16)),(CLADWH,WING(241))
      DATA Q71417 /4H7.1.,4H4.1-,4H7   /
      DATA Q14111 /4H7.1.,4H4.1-,4H11  /
      DATA I2A417 /16,3*0/, I2B417 /26,3*0/, I2C417 /15,3*0/
C
C                       FIGURE 7141-7  F1(N)
C
      DATA X2A417
     1 / -1., -.8, -.6, -.4, -.2, 0., .2, .4, .5, .6, .7, .8, .85, .9,
     2    .95, 1.0  /
      DATA Y1A417
     1 / 1.7, 1.57, 1.42, 1.3, 1.17, 1., .87, .7, .65, .56, .45, .37,
     2   .33, .23, .2, 0. /
C
C                      FIGURE 7141-7  F2(N)
C
      DATA X2B417
     1 / -1., -.9, -.8, -.7, -.6, -.5, -.4, -.3, -.2, -.1, 0., .1, .2,
     2   .3, .4, .45, .5, .55, .6, .65, .7, .75, .8, .85, .9, .95 /
      DATA Y1B417
     1 / 1.2, 1.19, 1.18, 1.17, 1.16, 1.14, 1.13, 1.1, 1.08, 1.05, 1.,
     2   1., 1., 1., 1.01, 1.03, 1.05, 1.07, 1.12, 1.15, 1.2, 1.28,
     3   1.37, 1.5, 1.75, 2.5  /
C
C                       FIGURE 7141-7 F3(X)
C
      DATA X2C417
     1 / -1.0, -.8, -.6, -.4, -.2, 0., .2, .3, .4, .5, .6, .7, .8, .85 ,
     2     1./
      DATA Y1C417
     1 /.66, .7, .75, .83, .92,1.02,1.19,1.34,1.52,1.83,2.3,3.2,5.25,
     2 7.3 , 14. /
      DATA X24111/0.,8.,12.,16.,20.,24.,28.,32.,34.,36.,38.,40.,42.,44.,
     145./
      DATA X14111/3.,4.,5.,6.,8.,12.,20./
      DATA X34111/0.,.25,.5,.75,1./
      DATA X2A111/0.,8.,12.,16.,20.,24.,28.,32.,34.,36.,38.,40.,42.,44.,
     145./
      DATA X1A111/3.,4.,5.,6.,8.,12.,20./
      DATA X3A111/0.,.25,.5,.75,1./
C
C        IN THE FOLLOWING DATA STATEMENTS 2 FLOATING POINT NUMBERS,WITH
C        3 SIGNIFICANT DIGITS EACH,ARE PACKED IN 1 FIXED POINT WORD.
C
C        THE FORMAT IS AS FOLLOWS-
C
C        SIGN1,NS2,NSPS,NP1,NP2,ND1,ND2
C
C        WHERE-
C
C        SIGN1 IS THE ACTUAL SIGN OF THE 1ST NUMBER
C        NS2   REPRESENTS THE SIGN OF THE 2ND NUMBER.0 IF + , 1 IF -
C        NSPS  REPRESENTS THE SIGNS OF THE POWERS OF 10 FOR BOTH NUMBERS
C             0 IF ++ , 1 IF -- , 2 IF +- , 3 IF -+
C        NP1   IS THE POWER OF 10 FOR THE 1ST NUMBER. LIMITED TO 1 DIGIT
C        NP2   IS THE POWER OF 10 FOR THE 2ND NUMBER. LIMITED TO 1 DIGIT
C        ND1  3 DIGITS OF THE 1ST NUMBER (DECIMAL POINT AT END)
C        ND2  3 DIGITS OF THE 2ND NUMBER (DECIMAL POINT AT END)
C
      DATA D14111/  203000220,  133300360,  133400440,  133470480,
     1  133480480,  133470460,  133430400,  330390000,  133190250,
     2  133300340,  133360360,  133340320,  133300270,  133210140,
     3  340600000,  203000170,  133220250,  133280270,  133250200,
     4  133160100, 1144400500,-1133130220, -330260000,  133150180,
     5  133200220,  133200140,  340500000,-1133100210,-1133390600,
     6-1132840100,  203000110,  133140140,  134110600,-1143400200,
     7-1133300460,-1133670990,-1122139190, -320220000,  144700700,
     8 1144400300,-1133200300,-1133600800,-1122120160,-1122220320,
     9-1122450500,  204000300,-1144100800,-1133210500,-1132700120,
     A-1122160210,-1122290460,-1121670105, -114132500,  133240290,
     B  133330350,  133350340,  133320300,  133300300,  133300300,
     C  133310310,  143300180,  133210220,  133210200,  134140500,
     D 1204000700,-1133150230,-1133300350, -134380300,  133140160,
     E  133150130, 1144800200,-1133170280,-1133400550,-1133690800,
     F-1133890920,  143200120,  114120100, 1144800200,-1133150370,
     G-1133510700,-1132920120,-1122142165, -124173100,  144800700,
     H 1144200500,-1133170370,-1133700940,-1122124165,-1122220279,
     I-1122320350,  144100400, 1204000700,-1133200400,-1132700120,
     J-1122150200,-1122280390,-1122530700, -320800000,-1144100600/
      DATA D24111/
     1-1133170350,-1132500100,-1122170230,-1122320450,-1122650950,
     2-1111150197,  133240320,  133340350,  133330320,  133310340,
     3  133360380,  133410440,  133470500,  133510170,  133220220,
     4  133200160,  330100000,-1133100150,-1133200230,-1133230220,
     5-1133200190,  133110140,  113150120, 1144500500,-1133200440,
     6-1133570700,-1133790850,-1133910960, -124100900,  133120100,
     7 1144500300,-1133180400,-1133700910,-1122112132,-1122150166,
     8-1122180189,  143600100, 1144400400,-1133150340,-1132650100,
     9-1122150200,-1122250300,-1122330380, -124400400, 1144400300,
     A-1133130300,-1132600100,-1122160220,-1122300400,-1122530700,
     B-1122830920, 1144200100,-1143900220,-1133410700,-1122130210,
     C-1122300390,-1122550850,-1111126190, -113228360,  133400400,
     D  133380370,  133370390,  133430450,  133470520,  133560600,
     E  133630650,  133280280,  133250210,  134150600,-1143500130,
     F-1133160180,-1133200210,-1133220220, -133220200,  133200150,
     G  330100000,-1133130320,-1133550630,-1133700750,-1133820870,
     H-1133900920,  133150150,  134100300,-1133100270,-1133550900,
     I-1122106124,-1122140158,-1122172190, -123199120,  134100400,
     J-1143700220,-1133450800,-1122140180,-1122240300,-1122330370/
      DATA D34111/
     1-1122400400,  144800400,-1143400160,-1133350700,-1122110200,
     2-1122260360,-1122490630,-1122770900, -124990400,-1143100100,
     3-1133250500,-1122100140,-1122240330,-1122480680,-1121980140,
     4-1111200245,  133440420,  133390380,  133370380,  133400400,
     5  133400400,
     6  133420430,  133230160,  134100100,-1133150370,-1132670110,
     7-1122134156,-1122175193,-1122210230, -123240160,  134120400,
     8-1133100280,-1133550800,-1122150210,-1122260310,-1122350420,
     9-1122470500,  134120600,-1143400180,-1133400710,-1122130220,
     A-1122290390,-1122500660,-1121800100, -114110700, 1203000100,
     B-1133270520,-1132900140,-1122300430,-1122660950,-1111131178,
     C-1111235270,  133440450,  133460330,  133310280,  133200130,
     D 1144500600,-1133140180,-1133220250,-1133300320,-1133330350,
     E  133270230,  133180100,-1143400200,-1133420690,-1133800900,
     F-1122100110,-1122120128, -320130000/
      DATA D1A111/  122400385,  122378375,  122370365,  122365362,
     1  122362365,  122365366,  122368370,  122372400,  122388383,
     2  122380377,  122375375,  122376378,  122380382,  122385390,
     3  122395401,  122400389,  122386385,  122382382,  122382385,
     4  122390395,  122398405,  122410420,  122426400,  122391388,
     5  122387387,  122387390,  122396401,  122405411,  122421430,
     6  122444450,  122400393,  122392390,  122394396,  122402410,
     7  122417426,  122435450,  122467485,  122495400,  122396396,
     8  122397402,  122407417,  122432442,  122457470,  122495520,
     9  122555574,  122400399,  122400405,  122410420,  122435455,
     A  122470485,  122510552,  122605675,  122717394,  122385380,
     B  122378377,  122378379,  122382384,  122388391,  122394400,
     C  122406409,  122396389,  122386385,  122385390,  122391398,
     D  122402407,  122413420,  122430447,  122455398,  122393392,
     E  122393395,  122401410,  122420427,  122437448,  122461480,
     F  122500513,  122397391,  122390392,  122392395,  122401410,
     G  122416424,  122432442,  122455472,  122482398,  122395395,
     H  122398402,  122410420,  122435445,  122458474,  122498523,
     I  122558572,  122399398,  122400403,  122410420,  122432452,
     J  122467485,  122509540,  122582640,  122675399,  122400403/
      DATA D2A111/
     1  122408416,  122429447,  122471488,  122512548,  122600675,
     2  122780840,  122381376,  122375375,  122377380,  122385390,
     3  122395400,  122403410,  122417425,  122429387,  122384384,
     4  122385387,  122395402,  122410417,  122425433,  122442454,
     5  122467475,  122391388,  122387390,  122395403,  122412425,
     6  122433445,  122455471,  122490508,  122520392,  122390390,
     7  122395400,  122408418,  122435446,  122459475,  122498520,
     8  122543557,  122395394,  122395400,  122406415,  122428450,
     9  122462480,  122505533,  122567602,  122625397,  122397400,
     A  122405412,  122425442,  122465483,  122507540,  122575625,
     B  122680720,  122398399,  122402410,  122418433,  122453483,
     C  122502530,  122574627,  122710850,  122935367,  122367368,
     D  122370373,  122379384,  122392395,  122400405,  122411419,
     E  122429433,  122377377,  122379382,  122387393,  122404416,
     F  122425432,  122440453,  122467480,  122488382,  122383385,
     G  122389395,  122403416,  122433444,  122456471,  122488506,
     H  122527539,  122386387,  122389393,  122400411,  122426445,
     I  122458473,  122492514,  122540566,  122580390,  122392395,
     J  122400408,  122420437,  122460476,  122496520,  122553592/
      DATA D3A111/
     1  122633658,  122394396,  122399403,  122415428,  122448475,
     2  122496522,  122558600,  122662750,  122780396,  122399403,
     3  122412421,  122437459,  122490513,  122547590,  122660770,
     4  121910100,  122356357,  122361365,  122370378,  122389400,
     5  122405411,  122416420,  122428433,  122440365,  122370373,
     6  122377383,  122392409,  122430440,  122444458,  122466478,
     7  122490495,  122372376,  122380385,  122392402,  122418440,
     8  122452470,  122485500,  122520540,  122550378,  122382385,
     9  122392400,  122411425,  122450460,  122480508,  122530555,
     A  122585600,  122383388,  122392397,  122407420,  122440470,
     B  122490520,  122550580,  122620670,  122685388,  122393397,
     C  122404413,  122425450,  122480504,  122540574,  122624695,
     D  122770820,  122394398,  122404411,  122421435,  122465492,
     E  122520558,  122600660,  122725940,  310105000/
      DATA ROUTID/4HSUPC,4HLD  /
C
      IF(TANLE.EQ.0.)TANLE=.00001
      COTLE=1./TANLE
      BCOTLE=BETA*COTLE
      ACOTBC=RAD*ATAN(1./BCOTLE)
      XACCRB=XACCR*CRSTR/CBARR
      SAVE=MACOE*SW/(CBARR*SR)
      BA=BETA*ASTRW
      EN=1.-4.*COTLE/ASTRW
C
C    ---- SUPERSONIC WING ACCELERATION DERIVATIVE,CLAD ----
C
      MACH=FLC(IM+2)
      QLAMDA=9.
      IF(BCOTLE.GE.1.)GO TO 1060
      IF(LAMDA.NE.0.)GO TO 1010
C
C           -- FIGURE 7.1.4.1-7 F1(N) --
C
 1000 CALL INTERX(1,X2A417,EN,I2A417,Y1A417,F1N,16,16,1,0,0,0,1,0,0,0,
     1            Q71417,3,ROUTID)
C
C           -- FIGURE 7.1.4.1-7 F2(N) --
C
      CALL INTERX(1,X2B417,EN,I2B417,Y1B417,F2N,26,26,1,0,0,0,1,0,0,0,
     1            Q71417,3,ROUTID)
C
C           -- FIGURE 7.1.4.1-7 F3(X) --
C
      CALL INTERX(1,X2C417,EN,I2C417,Y1C417,F3X,15,15,2,0,0,0,2,0,0,0,
     1            Q71417,3,ROUTID)
      F3X=F3X*(1.-EN)
      CLADWH=-.027414*ASTRW*MACH**2/BETA**2*(-3.*GBC*F3X+2.*EPPBC*F2N+
     1       EPPBC*F1N/MACH**2)*SAVE
      IF(QLAMDA.LT.5.)GO TO 1040
      GO TO 1070
 1010 IF(LAMDA.LT.0.25)GO TO 1030
C
C           -- CALCA IS THE EQUATION SHOWN BY FIGURE 7.1.4.1-8 --
C
 1020 CALL CALCA(DYN,A,WINGIN)
      CLADWH=SAVE/(RAD*BETA**2)*(MACH**2*CLAD1-CLAD2)
      IF(QLAMDA.LT.0.25)GO TO 1050
      GO TO 1070
 1030 CONTINUE
      QLAMDA=LAMDA
      LAMDA=0.
      GO TO 1000
 1040 CLD1=CLADWH
      LAMDA=.25
      GO TO 1020
 1050 CLADWH=(CLADWH-CLD1)*4.*QLAMDA+CLD1
      GO TO 1070
C
C           -- FIGURE 7.1.4.1-11A,B,C,D,E,F,G,H,I,J,K,L,M,N,O --
C
 1060 CALL TLIP3X(X14111,X24111,X34111,Y14111,7,15,5,BA,ACOTBC,LAMDA,
     1            BCLAD1,2,1,0,1,1,0,Q14111,3,ROUTID)
      CALL TLIP3X(X1A111,X2A111,X3A111,Y1A111,7,15,5,BA,ACOTBC,LAMDA,
     1            BCLAD2,2,1,0,2,1,0,Q14111,3,ROUTID)
      CLADWH=SAVE/(RAD*BETA**3)*(MACH**2*BCLAD1-BCLAD2)
 1070 CONTINUE
      IF(TANLE.EQ..00001)TANLE=0.
      RETURN
      END
