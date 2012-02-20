      SUBROUTINE GRDEFF(GRDHT,L)
C
C***  COMPUTES GROUND EFFECTS
C
      COMMON /FLGTCD/ FLC(93)
      COMMON /SUPWH/  GR(303)
      COMMON /BDATA/  BD(275),CIOM(320)
      COMMON /WINGD/  A(195), B(49)
      COMMON /HTDATA/ AHT(195), BHT(49)
      COMMON /CONSNT/ PI, DEG, UNUSED, RAD
      COMMON /SYNTSS/ SYNA(19)
      COMMON /OPTION/ SREF, CBARR, ROUGFC, BLREF
      COMMON /OVERLY/ NLOG, NMACH, I, NALPHA, IG
      COMMON /WINGI/  WINGIN(77)
      COMMON /HTI/    HTIN(131)
      COMMON /FLAPIN/ F(69)
      COMMON /IWING/  PWING, WING(400)
      COMMON /IBW/    PBW, BWI(380)
      COMMON /IBWV/   PBWV, BWV(380)
      COMMON /IBWH/   PBWH, BWH(380)
      COMMON /IBWHV/  PBWHV, BWHV(380)
      COMMON /IDWASH/ PDWASH, DWASH(60)
      COMMON /FLOLOG/ FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1                HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,SUPERS,SUBSON,
     2                TRANSN,HYPERS,SYMFP,ASYFP,TRIMC,TRIM,DAMP,
     3                HYPEF,TRAJET,BUILD,FIRST,DRCONV,PART,
     4                VFPL,VFSC,CTAB
C
      LOGICAL  FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1         HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,SUPERS,SUBSON,
     2         TRANSN,HYPERS,SYMFP,ASYFP,TRIMC,TRIM,DAMP,
     3         HYPEF,TRAJET,BUILD,FIRST,DRCONV,PART,
     4         VFPL,VFSC,CTAB
C
      DIMENSION ROUTID(2),Q47118(2),Q47119(2),Q7122A(3),Q47125(2)
     1     ,QCLWBG(2),QCLHTG(2)
      DIMENSION CW(6),LGH(4),VAR(4),X4717A(13),Y4717A(13),Y4717B(13)
      DIMENSION CT(6),Q47117(2),DELTA(10)
      REAL K,LOLOM1(20),LH,LHOCBR
      DIMENSION DALPHA(20),ALPHWG(20),DDWASH(20),CLHT(20),ALPHAT(20),
     1CLWBG(20),CLG(20),CLHTG(20),DCLWBG(20),DCMWBG(20),CMG(20),DCLHTG
     2(20),DCMHTG(20),DCDLWG(20),CLOCOS(20),BW(20),CMWBG(20)
      EQUIVALENCE (DELTA(1),F(1))
      EQUIVALENCE (CLG(1),BWH(21))
      EQUIVALENCE (CMWBG(1),BWI(41)), (CMG(1),BWH(41))
      EQUIVALENCE (GR(1),DX),(GR(2),DXOB2),(GR(3),H75CR),(GR(4),HW),
     1 (GR(5),HWOB2),(GR(6),HWCR4),(GR(7),HWCOCR),(GR(8),HWMACX),(GR(9),
     2 HWMAC4),(GR(10),HTMACX),(GR(11),HTMAC4),(GR(12),R),(GR(13),SIGMA)
     3 ,(GR(14),HWOCBR),(GR(15),T),(GR(17),DALPHA(1)),
     4 (GR(37),ALPHWG(1)),(GR(57),K),(GR(58),X),(GR(59),BWOB),(GR(60),
     5 BEFF),(GR(61),DDWASH(1)),(GR(81),CLHT(1)),(GR(101),ALPHAT(1)),
     6 (GR(121),BW(1)),(GR(141),LOLOM1(1)),(GR(161),CLHTG(1)),
     7 (GR(181),DCLWBG(1)),(GR(201),DXCP),(GR(202),DCMWBG(1)),
     8 (GR(222),CLOCOS(1)),(GR(242),LH),(GR(243),LHOCBR),
     9 (GR(244),DCLHTG(1)),(GR(264),DCMHTG(1)),(GR(284),DCDLWG(1))
      DIMENSION X218(11),X118(7),Y18(77)
      DIMENSION X219(12),X119(9),Y19(108)
      DIMENSION X222A(6),X122A(4),Y22A(24)
      DIMENSION X225(11),X125(9),Y25(99)
C
C     *********FIGURE 4.7.1-14**********
C     ******** X218=HWOB2 X118=DX Y18=X **********
C
      DATA ROUTID/4HGRDE,4HFF  /,Q47118/4H4.7.,4H1-14/,Q47119/4H4.7.,
     1 4H1-15/,Q7122A/4H4.7.,4H1-18,4HA   /,Q47125/4H4.7.,4H1-21/,
     2 QCLWBG/4HCLWB,4HG   /,QCLHTG/4HCLHT,4HG   /
      DATA X218/0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0/
      DATA X118/1.0,0.5,0.2,0.0,-0.2,-0.5,-1.0/
      DATA Y18/1.4,1.01,0.79,0.62,0.50,0.40,0.33,0.27,0.22,0.18,0.15,
     11.27,0.90,0.69,0.54,0.42,0.33,0.28,0.22,0.18,0.15,0.12,
     21.11,0.78,0.58,0.45,0.35,0.28,0.22,0.18,0.15,0.12,0.099,
     31.00,0.66,0.50,0.38,0.30,0.23,0.19,0.16,0.12,0.10,0.085,
     40.86,0.55,0.40,0.31,0.24,0.19,0.16,0.13,0.10,0.085,0.080,
     50.72,0.41,0.29,0.21,0.16,0.13,0.10,0.080,0.070,0.060,0.050,
     60.60,0.30,0.19,0.12,0.085,0.065,0.045,0.035,0.025,0.020,0.0200/
C
C     *********FIGURE 4.7.1-15**********
C     ******** X219=HWCOCR X119=CLOCOS(J) Y19=LOLOM1(J) *********
C
      DATA X219/.3,.4,.6,.8,1.,1.2,1.4,1.6,1.8,2.,2.2,2.4/
      DATA X119/0.0,5.0,10.0,15.0,18.0,20.0,22.0,24.0,36.0/
      DATA Y19/.40,.27,.145,.090,.060,.04,.030,.022,.015,.013,.010,.010,
     1.25,.16,.065,.035,.017,.007,0.0,-.005,-.007,-.010,-.012,-.016,
     2.11,.060,0.0,-.020,-.030,-.030,-.030,-.030,-.030,-.030,-.030,-.030
     3,-.020,-.040,-.065,-.070,-.070,-.065,-.060,-.055,-.050,-.048,-.045
     4,-.040,-.080,-.10,-.115,-.11,-.098,-.085,-.080,-.070,-.065,-.060,
     5-.060,-.055,-.125,-.135,-.140,-.125,-.115,-.10,-.090,-.085,-.075,
     6-.070,-.065,-.063,-.160,-.165,-.165,-.15,-.13,-.12,-.105,-.095,
     7-.085,-.080,-.070,-.067,-.20,-.20,-.190,-.170,-.148,-.130,-.115,
     8-.10,-.090,-.085,-.077,-.073,-.20,-.20,-.20,-.20,-.20,-.19,-.17,
     9-.155,-0.138,-.127,-.118,-.11/
C
C     *********FIGURE 4.7.1-18A*********
C     ******** X22A=1.0/A(118) X12A=A(120) Y22A=BWOB ************
C
      DATA X222A/1.0,1.5,2.0,3.0,4.0,5.0/
      DATA X122A/4.0,6.0,8.0,10.0/
      DATA Y22A/.825,.79,.77,.745,.725,.715,.853,.805,.77,.740,.715,.70,
     1.88,.82,.77,.73,.703,.69,.895,.825,.77,.725,.695,.68/
C
C     *********FIGURE 4.7.1-21**********
C     ******** X225=HWOCBR X122A=B(J+182) Y25=BW(J) *************
C
      DATA X225/.2,.3,.4,.5,.6,.7,.8,.9,1.0,1.1,1.2/
      DATA X125/0.0,.2,.4,.6,.8,1.0,1.2,1.4,1.6/
      DATA Y25/11*0.0,.92,.59,.41,.31,.23,.19,.15,.11,.09,.08,.07,
     11.92,1.13,.80,.60,.45,.35,.25,.20,.17,.15,.12,
     22.45,1.65,1.15,.81,.60,.43,.35,.23,.20,.16,.12,
     32.6,2.15,1.42,1.0,.70,.50,.37,.25,.19,.15,.14,
     42.6,2.5,1.7,1.15,.78,.52,.37,.22,.14,.09,.04,
     52.6,2.6,1.85,1.20,.76,.46,.29,.18,.08,0.0,-.02,
     62.6,2.6,1.95,1.20,.72,.39,.19,.03,-.02,-.09,-.12,
     72.6,2.6,2.10,1.16,.52,.20,.03,-.07,-.16,-.22,-.26/
      DATA X4717A/0.,.1,.2,.3,.4,.5,.6,.7,.8,.9,1.,1.1,1.2/
      DATA Y4717A/-.145,-.125,-.1,-.08,-.062,-.05,-.038,-.029,-.02,
     1 -.014,-.005,2*0./
      DATA Y4717B/.098,.08,.062,.051,.04,.032,.024,.016,.01,.006,3*0./
      DATA Q47117/4H4.7.,4H1-17 /
      DATA STRA/4HSTRA/
C
      IF(IG.GT.1)GO TO 1010
C
C  STORE BASIC AERO, FREE AIR, FOR MULTIPLE HEIGHTS
C
      DO 1000 J=1,20
         CIOM(J    )= BWI(J    )
         CIOM(J+ 20)= BWI(J+ 20)
         CIOM(J+ 40)= BWI(J+ 40)
         CIOM(J+ 60)= BWI(J+100)
         CIOM(J+ 80)= BWI(J+120)
         CIOM(J+100)= BWH(J    )
         CIOM(J+120)= BWH(J+ 20)
         CIOM(J+140)= BWH(J+ 40)
         CIOM(J+160)= BWH(J+100)
         CIOM(J+180)= BWH(J+120)
         CIOM(J+200)= BWV(J    )
         CIOM(J+220)=BWHV(J    )
         CIOM(J+240)=BWHV(J+ 20)
         CIOM(J+260)=BWHV(J+ 40)
         CIOM(J+280)=BWHV(J+100)
         CIOM(J+300)=BWHV(J+120)
 1000 CONTINUE
C
C  REPLACE BASIC AERO, FREE AIR, FOR MULTIPLE HEIGHTS
C
 1010 DO 1020 J=1,20
         BWI(J    )=CIOM(J    )
         BWI(J+ 20)=CIOM(J+ 20)
         BWI(J+ 40)=CIOM(J+ 40)
         BWI(J+100)=CIOM(J+ 60)
         BWI(J+120)=CIOM(J+ 80)
         BWH(J    )=CIOM(J+100)
         BWH(J+ 20)=CIOM(J+120)
         BWH(J+ 40)=CIOM(J+140)
         BWH(J+100)=CIOM(J+160)
         BWH(J+120)=CIOM(J+180)
         BWV(J    )=CIOM(J+200)
        BWHV(J    )=CIOM(J+220)
        BWHV(J+ 20)=CIOM(J+240)
        BWHV(J+ 40)=CIOM(J+260)
        BWHV(J+100)=CIOM(J+280)
        BWHV(J+120)=CIOM(J+300)
 1020 CONTINUE
      GR(16)=GRDHT
C
C      *************CALCULATE GROUND EFFECT GEOMETRIC PARAMETERS********
C
      TANGI=TAN(WINGIN(13)/RAD)
      TANGO=TAN(WINGIN(14)/RAD)
C
C     ****CALCULATE DELTAX****
C
      IF(STRA.EQ.WINGIN(15))GO TO 1040
      IF(WINGIN(2).LE.0.25*WINGIN(4)) GO TO 1030
      DX=.5*WINGIN(6)-A(92)*(WINGIN(2)-0.25*WINGIN(4))-A(68)*
     1   (WINGIN(4)-WINGIN(2))
      GO TO 1050
 1030 DX=0.50*WINGIN(6)-0.75*WINGIN(4)*A(8)
      GO TO 1050
 1040 DX=0.50*WINGIN(6)-A(44)*0.75*WINGIN(4)
 1050 DXOB2=DX/WINGIN(4)
C
C     ****CALCULATE AVERAGE ELEVATION OF WING ABOVE GROUND (HW)*****
C
      H75CR=GRDHT+SYNA(3)-0.75*WINGIN(6)*TAN(SYNA(4)/RAD)
      IF(WINGIN(13).EQ.UNUSED.AND.WINGIN(14).EQ.UNUSED) GO TO 1070
      IF(WINGIN(13).NE.UNUSED.AND.WINGIN(14).EQ.UNUSED) GO TO 1060
      IF(WINGIN(13).EQ.UNUSED.AND.WINGIN(14).NE.UNUSED) GO TO 1080
      IF(WINGIN(12).LE.0.25*WINGIN(4)) GO TO 1060
      HW=H75CR+0.50*((WINGIN(4)-WINGIN(12))*TANGI
     1   +(WINGIN(12)-0.25*WINGIN(4))*TANGO)
     2   +DX*TAN(SYNA(4)/RAD)*0.50
      GO TO 1090
 1060 HW=H75CR+0.375*WINGIN(4)*TANGI+DX*TAN(SYNA(4)/RAD)*.50
      GO TO 1090
 1070 HW=H75CR+DX*TAN(SYNA(4)/RAD)*.50
      GO TO 1090
 1080 IF(WINGIN(12).LE.0.25*WINGIN(4)) GO TO 1070
      HW=H75CR+0.50*TANGO*(WINGIN(12)-0.25*WINGIN(4))
     1   +DX*TAN(SYNA(4)/RAD)*.50
 1090 HWOB2=HW/WINGIN(4)
C
C     ****CALCULATE ELEVATION OF WING 1/4CR (HWCR4) *****
C
      HWCR4=H75CR+0.50*WINGIN(6)*TAN(SYNA(4)/RAD)
      HWCOCR=HWCR4/WINGIN(6)
C
C     ****CALCULATE WING AND TAIL ELEVATIONS IF TAIL IS PRESENT****
C
      IF(HTPL) GO TO 1100
      GO TO 1180
 1100 CONTINUE
C
C     ****CALCULATE ELEVATION OF WING MAC (HWMAC4)*****
C
      HWMACX=GRDHT+SYNA(3)-A(161)*TAN(SYNA(4)/RAD)
      IF(WINGIN(13).EQ.UNUSED.AND.WINGIN(14).EQ.UNUSED)GO TO 1120
      IF(WINGIN(13).NE.UNUSED.AND.WINGIN(14).EQ.UNUSED) GO TO 1110
      IF(WINGIN(13).EQ.UNUSED.AND.WINGIN(14).NE.UNUSED) GO TO 1130
      IF(A(136).LE.WINGIN(4)-WINGIN(12)) GO TO 1110
      HWMAC4=HWMACX+(WINGIN(4)-WINGIN(12))*TANGI
     1       +(A(136)+WINGIN(12)-WINGIN(4))*TANGO
      GO TO 1140
 1110 HWMAC4=HWMACX+A(136)*TANGI
      GO TO 1140
 1120 HWMAC4=HWMACX
      GO TO 1140
 1130 IF(A(136).LE.WINGIN(4)-WINGIN(12)) GO TO 1120
      HWMAC4=HWMACX+(A(136)+WINGIN(12)-WINGIN(4))*TANGO
 1140 CONTINUE
C
C     ****CALCULATE ELEVATION OF TAIL MAC (HTMAC4)*****
C
      HTMACX=GRDHT+SYNA(7)-AHT(161)*TAN(SYNA(8)/RAD)
      TANGIT=TAN(HTIN(13)/RAD)
      TANGOT=TAN(HTIN(14)/RAD)
      IF(HTIN(13).EQ.UNUSED.AND.HTIN(14).EQ.UNUSED) GO TO 1160
      IF(HTIN(13).NE.UNUSED.AND.HTIN(14).EQ.UNUSED) GO TO 1150
      IF(HTIN(13).EQ.UNUSED.AND.HTIN(14).NE.UNUSED) GO TO 1170
      IF(AHT(136).LE.HTIN(4)-HTIN(12)) GO TO 1150
      HTMAC4=HTMACX+(HTIN(4)-HTIN(12))*TANGIT+(AHT(136)+HTIN(12)
     1       -HTIN(4))*TANGOT
      GO TO 1180
 1150 HTMAC4=HTMACX+AHT(136)*TANGIT
      GO TO 1180
 1160 HTMAC4=HTMACX
      GO TO 1180
 1170 IF(AHT(136).LE.HTIN(4)-HTIN(12)) GO TO 1160
      HTMAC4=HTMACX+(AHT(136)+HTIN(12)-HTIN(4))*TANGOT
 1180 CONTINUE
C
C     **************CALCULATE GROUND EFFECT ON WING LIFT (DELTA ALPHA)**
C
      R=(1.0+HWOB2**2)**.50-HWOB2
      SIGMA=EXP(-2.48*HWOB2**.768)
      HWOCBR=HW/A(122)
      T=(RAD/(8.0*PI))*(HWOCBR/(HWOCBR**2+1.0/64.))
      IF(A(120).LT.3.0) GO TO 1230
      CALL TLINEX(X118,X218,Y18,7,11,DXOB2,HWOB2,X,
     1            0,0,0,0,Q47118,2,ROUTID)
      IF(STRA.EQ.WINGIN(15)) GO TO 1190
      COSL4=(A(91)*WINGIN(2)+A(67)*(WINGIN(4)-WINGIN(2)))/WINGIN(4)
      GO TO 1200
 1190 COSL4=A(43)
 1200 CONTINUE
C
      DDCLF=0.0
      IFTYPE=F(17)+0.5
      IF(IFTYPE.LT.3 .OR. IFTYPE.GT.5)GO TO 1210
C
C     FIG. 4.7.1-17 DEL(DEL-CL) FOR FLAPS
C
      VAR(1)=HWMAC4/WINGIN(6)
      LGH(1)=13
      IF(IFTYPE.EQ.3.OR.IFTYPE.EQ.4)CALL INTERX(1,X4717A,VAR,LGH,
     1   Y4717A,DDCLF,13,13,1,0,0,0,1,0,0,0,Q47117,2,ROUTID)
      IF(IFTYPE.EQ.5)               CALL INTERX(1,X4717A,VAR,LGH,
     1   Y4717B,DDCLF,13,13,1,0,0,0,1,0,0,0,Q47117,2,ROUTID)
 1210 DO 1220 J=1,NALPHA
         IF(.NOT.HTPL) CLWF=BWI(J+20)+WING(L+200)
         IF(  HTPL   ) CLWF=BWI(J+20)
         CLOCOS(J)=RAD*WING(J+20)/(2.0*PI*COSL4**2)
         CALL TLINEX(X119,X219,Y19,9,12,CLOCOS(J),HWCOCR,LOLOM1(J),
     1               0,0,2,2,Q47119,2,ROUTID)
         DALPHA(J)=-(9.12/A(120)+7.16*WINGIN(6)/(2.0*WINGIN(4)))*
     1             CLWF*X-(A(120)*WINGIN(6)/(4.0*BWI(101)
     2             *WINGIN(4)))* LOLOM1(J)*CLWF*R
         ALPHWG(J)=FLC(J+22)+DALPHA(J)-DDCLF*DELTA(L)**2/(2500.
     1             *BWI(J+100))
 1220 CONTINUE
      GO TO 1250
 1230 CONTINUE
C
C     *********GROUND EFFECTS ON LOW ASPECT RATIO WING LIFT******
C
      K=RAD*.0030*HWOCBR*(1.0/(HWOCBR**2+1.0/64.)**2+1.0/(HWOCBR**2
     1  +9.0/64.)**2)
      DO 1240 J=1,NALPHA
         CALL TLINEX(X125,X225,Y25,9,11,WING(J+20),HWOCBR,BW(J),
     1               0,0,2,2,Q47125,2,ROUTID)
         DALPHA(J)=-18.24*BWI(J+20)*SIGMA/A(120)+R*T*BWI(J+20)**2/
     1          (RAD*BWI(101))-R*BW(J)+K*WINGIN(16)
         ALPHWG(J)=FLC(J+22)+DALPHA(J)
 1240 CONTINUE
 1250 CONTINUE
      IF(HTPL) GO TO 1260
      GO TO 1280
 1260 CONTINUE
C
C     *********GROUND EFFECTS ON TAIL ************
C
      CALL TLINEX(X122A,X222A,Y22A,4,6,A(120),1/A(118),BWOB,
     1            2,0,2,1,Q7122A,3,ROUTID)
      BEFF=BWOB*2.0*WINGIN(4)
      DO 1270 J=1,NALPHA
         DDWASH(J)=DWASH(J+20)*(BEFF**2+4.*(HTMAC4-HWMAC4)**2)/(BEFF**2+
     1         4.*(HTMAC4+HWMAC4)**2)
         CLHT(J)=BWH(J+20)-BWI(J+20)
         ALPHAT(J)=FLC(J+22)-DDWASH(J)
 1270 CONTINUE
 1280 CONTINUE
      IW=0
      IT=0
      DO 1300 J=1,NALPHA
         CLWB = BWI(J+20)
         CALL TBFUNX(FLC(J+22),CLWBG(J),DYDX,NALPHA,ALPHWG(1),BWI(21),
     1               CW,IW,MI,NG,1,2,QCLWBG,2,ROUTID)
         DCLWBG(J) = CLWBG(J)-CLWB
         IF(VTPL .OR. VFPL .OR. TVTPAN) BWV(J+20)=CLWBG(J)
         IF(HTPL) GO TO 1290
         GO TO 1300
 1290    CALL TBFUNX(FLC(J+22),CLHTG(J),DYDX,NALPHA,ALPHAT(1),CLHT(1),
     1               CT,IT,MI,NG,1,2,QCLHTG,2,ROUTID)
         CLG(J)=BWV(J+20)+CLHTG(J)
         IF(VTPL .OR. VFPL .OR. TVTPAN) BWHV(J+20)=CLG(J)
 1300 CONTINUE
      DO 1310 J=1,NALPHA
 1310 BWI(J+20)=CLWBG(J)
C
C     **************GROUND EFFECTS ON PITCHING MOMENT ***********
C
      DO 1350 J=1,NALPHA
         DXCP=BWI(121)/BWI(101)
         DCMWBG(J)=DXCP*DCLWBG(J)
         CMWBG(J)=BWI(J+40)+DCMWBG(J)
         IF(VTPL .OR. VFPL .OR. TVTPAN) BWV(J+40)=CMWBG(J)
         IF(HTPL) GO TO 1320
         GO TO 1330
 1320    CONTINUE
C
C     *********GROUND EFFECT ON TAIL CM *****
C
         LH=SYNA(6)+AHT(161)-SYNA(1)
         LHOCBR=LH/A(122)
         DCLHTG(J)=CLHTG(J)-CLHT(J)
         DCMHTG(J)=-DCLHTG(J)*LHOCBR*DWASH(J)
         CMG(J)=BWH(J+40)+DCMHTG(J)
         IF(VTPL .OR. VFPL .OR. TVTPAN) BWHV(J+40)=CMG(J)
 1330    CONTINUE
C
C     **************GROUND EFFECT ON DRAG ***********************
C
         DCDLWG(J)=-SIGMA*WING(J+20)**2/(PI*A(120))-(WING(J)-SIGMA*
     1             WING(J+20)**2/(PI*A(120)))*R*T*WING(J+20)/RAD
         BWI(J)=BWI(J)+DCDLWG(J)
         IF(VTPL .OR. VFPL .OR. TVTPAN) BWV(J)=BWV(J)+DCDLWG(J)
         IF(HTPL) GO TO 1340
         GO TO 1350
 1340    BWH(J)=BWH(J)+DCDLWG(J)
         IF(VTPL .OR. VFPL .OR. TVTPAN) BWHV(J)=BWHV(J)+DCDLWG(J)
 1350 CONTINUE
C
C     CALCULATE CN AND CA
C
      IW = 0
      IT = 0
      DO 1360 J=1,NALPHA
         SA = SIN(FLC(J+22)/RAD)
         CA = COS(FLC(J+22)/RAD)
         BWI(J+60) = BWI(J+20)*CA + BWI(J)*SA
         BWI(J+80) = BWI(J)*CA - BWI(J+20)*SA
         BWV(J+60) = BWV(J+20)*CA + BWV(J)*SA
         BWV(J+80) = BWV(J)*CA - BWV(J+20)*SA
         BWH(J+60) = BWH(J+20)*CA + BWH(J)*SA
         BWH(J+80) = BWH(J)*CA - BWH(J+20)*SA
         BWHV(J+60) = BWHV(J+20)*CA + BWHV(J)*SA
         BWHV(J+80) = BWHV(J)*CA - BWHV(J+20)*SA
C
C     B-W CLA AND CMA
C
         CALL TBFUNX(FLC(J+22),Z,BWI(J+100),NALPHA,FLC(23),BWI(21),
     1               CW,IW,MI,NG,0,0,4HCLA ,1,ROUTID)
         CALL TBFUNX(FLC(J+22),Z,BWI(J+120),NALPHA,FLC(23),BWI(41),
     1               CT,IT,MI,NG,0,0,4HCMA ,1,ROUTID)
 1360 CONTINUE
C
C     B-W-V CLA AND CMA
C
      IW = 0
      IT = 0
      DO 1370 J=1,NALPHA
         CALL TBFUNX(FLC(J+22),Z,BWV(J+100),NALPHA,FLC(23),BWV(21),
     1              CW,IW,MI,NG,0,0,4HCLA ,1,ROUTID)
         CALL TBFUNX(FLC(J+22),Z,BWV(J+120),NALPHA,FLC(23),BWV(41),
     1               CT,IT,MI,NG,0,0,4HCMA ,1,ROUTID)
 1370 CONTINUE
C
C     B-W-H CLA AND CMA
C
      IW = 0
      IT = 0
      DO 1380 J=1,NALPHA
         CALL TBFUNX(FLC(J+22),Z,BWH(J+100),NALPHA,FLC(23),BWH(21),
     1               CW,IW,MI,NG,0,0,4HCLA ,1,ROUTID)
         CALL TBFUNX(FLC(J+22),Z,BWH(J+120),NALPHA,FLC(23),BWH(41),
     1               CT,IT,MI,NG,0,0,4HCMA ,1,ROUTID)
 1380 CONTINUE
C
C     B-W-H-V CLA AND CMA
C
      IW = 0
      IT = 0
      DO 1390 J=1,NALPHA
         CALL TBFUNX(FLC(J+22),Z,BWHV(J+100),NALPHA,FLC(23),BWHV(21),
     1               CW,IW,MI,NG,0,0,4HCLA ,1,ROUTID)
         CALL TBFUNX(FLC(J+22),Z,BWHV(J+120),NALPHA,FLC(23),BWHV(41),
     1               CT,IT,MI,NG,0,0,4HCMA ,1,ROUTID)
 1390 CONTINUE
      RETURN
      END
