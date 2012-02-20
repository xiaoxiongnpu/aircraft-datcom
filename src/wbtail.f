      SUBROUTINE WBTAIL
C
C *** CALCULATE SUBSONIC WING-BODY-TAIL AERO
C
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA,IG
      COMMON /WINGI/  WINGIN(101)
      COMMON /FLGTCD/ FLC(95)
      COMMON /BDATA/  BD(762)
      COMMON /SYNTSS/ XCG,XW,ZW,ALIW,ZCG,XH,ZH,ALIH,XV,VERTUP,HINAX,
     1                XVF,SCALE,ZV,ZVF,YV,YF,PHIV,PHIF
      COMMON /WHWB/   FACT(182),WB(39)
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD
      COMMON /WBHCAL/ WBT(155)
      COMMON /WHAERO/ C(51),D(55),CHT(51),DHT(55),DVT(55),DVF(55)
      COMMON /IBW/    PBW,BW(380)
      COMMON /IBWH/   PBWH,BWH(380)
      COMMON /IWING/  PWING,WING(400)
      COMMON /IDWASH/ PDWASH,DWASH(60)
      COMMON /IBWHV/  PBWHV,BWHV(380)
      COMMON /WINGD/  A(195),B(49)
      COMMON /VTDATA/ AVT(195)
      COMMON /HTDATA/ AHT(195),BHT(49)
      COMMON /OPTION/ SREF,CBARR,ROUGFC,BLREF
      COMMON /IHT/    PHT,HT(380)
      COMMON /HTI/    CHRDTP,SSPNOP,SSPNE,SSPN,CHRDBP,CHRDR,SAVSI,SAVSO,
     1        CHSTAT,SWAFP,TWISTA,SSPNDD,DHDADI,DHDADO,TYPE,TOVC,DELTAY,
     2       XOVC,CLII,ALPHAI,CLALPA(20),CLMAX(20),CMO,LERI,LERO,CAMBER,
     3       TOVCO,XOVCO,CMOT,CLMAXL,CLMAO,TCEFF,KSHARP,XAC(20),RSVD(3),
     4       RLPH(20),SHB(20),SEXT(20)
C
      LOGICAL CANARD
      DIMENSION CCDWB(6),CDH(20),CLH(20),CLAH(20)
      DIMENSION CC(6),CD(6),CE(6),CF(6),QCLHT(1),QCDHT(1),QCLAHT(1)
      DIMENSION X12A1(11),Y12A1(11),C12A1(6)
      DIMENSION X12A2(11),Y12A2(11),C12A2(6)
      DIMENSION ROUTID(2),Q1210A(3),Q1210B(3),Q212A1(4),Q212A2(4),
     1          QCDDER(4),QCDHTD(4),ANG(20)
      DIMENSION X10B(11),Y10B(11),C10B(6)
      DIMENSION X10A(11),Y10A(11),C10A(6),CB(6),QCLTB(1)
      EQUIVALENCE(AKHBI,WBT(150)),(AKBHI,WBT(151))
C
C*********     WING-BODY-TAIL DATA      (DATCOM METHOD)          *******
C
C*********          KH(B) VS D/B                  **********************
C*********          FIGURE 4.3.1.2-10-A           **********************
C
      DATA ROUTID/4HWBTA,4HIL  /,Q1210A/4H4.3.,4H1.2-,4H10-A/,
     1 Q1210B/4H4.3.,4H1.2-,4H10-B/,Q212A1/4H4.3.,4H1.2-,4H12-A,4H1   /,
     2 Q212A2/4H4.3.,4H1.2-,4H12-A,4H2   /
      DATA QCDDER/4HCDWB,4H DER,4HIVAT,4HIVES/
      DATA QCDHTD/4HCDHT,4H DER,4HIVAT,4HIVES/
      DATA QCLHT /4HCLHT/,QCDHT/4HCDHT/,QCLAHT/4HCLAH/
      DATA X10A/0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0/
      DATA Y10A/1.0,1.08,1.16,1.26,1.36,1.46,1.56,1.67,1.78,1.89,2.0/
      DATA I10A/0/
C
C*********          KB(H) VS D/B                  **********************
C*********          FIGURE 4.3.1.2-10-B           **********************
C
      DATA X10B/0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0/
      DATA Y10B/0.0,0.13,0.29,0.45,0.62,0.80,1.0,1.22,1.45,1.70,2.0/
      DATA I10B/0/
      DATA X12A1/0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0/
      DATA Y12A1/1.0,0.97,0.95,4*0.94,0.95,0.96,0.98,0.99/
      DATA I12A1/0/
C
C*********          FIGURE 4.3.1.2-12-A2          **********************
C
      DATA X12A2/0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0/
      DATA Y12A2/0.0,0.11,0.21,0.31,0.41,0.51,0.60,0.70,0.80,0.90,1.0/
      DATA I12A2/0/
      DATA QCLTB / 4HCLTB /
C
C*********     ADDITIONAL TAIL GEOMETRY FOR WBT CALCULATIONS     *******
C
      CANARD = WINGIN(101) .GT. 2.5
      SINAI=0.
      COSAI=1.
      TANAI=0.
      BD(58)=(SSPN-SSPNE)*AHT(62)*COSAI
      BD(84)=XCG-(XH+BD(58))
      BD(762)=ZH-BD(58)*TANAI
      BD(761)=CHT(6)*AHT(10)
      BD(64)=BD(762)-BD(761)*SINAI-ZCG
      BD(63)=XCG-(BD(761)+BD(58)+XH)
      BD(31)=(BD(63)+BD(64)*TANAI)*COSAI
      BD(30)=BD(64)/COSAI-(BD(63)+BD(64)*TANAI)*SINAI
      BD(8)=XH-AHT(161)*COSAI
C
C*********    COMPUTE THE DERIVATIVES OF THE (CD) WB ARRAY        ******
C
      DO 990 J=1,NALPHA
  990 ANG(J) = BHT(J+22)-BHT(49)
      ICDWB=0
      DO 1000 J=1,NALPHA
         ALPAT=BHT(J+22)
         IF(.NOT. CANARD) ALPAT=BHT(J+22)-DWASH(J+20)-BHT(49)
         IY=0
         CALL TBFUNX(ALPAT,CLH(J),DYDX,NALPHA,ANG,HT(21),CD,IY,
     1               MI,NG,1,1,QCLHT,1,ROUTID)
         IZ=0
         CALL TBFUNX(ALPAT,CLAH(J),DYDX,NALPHA,ANG,HT(101),CE,IZ,
     1               MI,NG,1,1,QCLAHT,1,ROUTID)
         IA=0
         CALL TBFUNX(ALPAT,CDH(J),DYDX,NALPHA,ANG,HT(1),CF,IA,
     1               MI,NG,1,1,QCDHT,1,ROUTID)
 1000 CALL TBFUNX(FLC(J+22),YARG,BD(J+94),NALPHA,FLC(23),BW(1),CCDWB,
     1            ICDWB,MI,NG,0,0,QCDDER,4,ROUTID)
 1010 RATIO=(SSPN-SSPNE)/SSPN
C
C*********          FIGURE 4.3.1.2-12-A1
C
      CALL TBFUNX(RATIO,AKHBI,DYDX,11,X12A1,Y12A1,C12A1,I12A1,MI,NG,
     1            0,0,Q212A1,4,ROUTID)
C
C*********          FIGURE 4.3.1.2-12-A2
C
      CALL TBFUNX(RATIO,AKBHI,DYDX,11,X12A2,Y12A2,C12A2,I12A2,MI,NG,
     1            0,0,Q212A2,4,ROUTID)
C
C********      COMPUTE (CL-ALPHA)WBT     ( DATCOM )         ************
C
      CALL TBFUNX(RATIO,WBT(1),DYDX,11,X10A,Y10A,C10A,I10A,MI,NG,
     1            0,0,Q1210A,3,ROUTID)
      CALL TBFUNX(RATIO,WBT(2),DYDX,11,X10B,Y10B,C10B,I10B,MI,NG,
     1            0,0,Q1210B,3,ROUTID)
 1020 WBT(3)=WBT(1)*HT(101)
      WBT(4)=WBT(2)*HT(101)
C
C*********          COMPUTE ((CLALPHA)WBT)J1                     *******
C
      WBT(108)=SSPN-SSPNE
      WBT(109)=XH+AHT(161)
      DO 1110 J=1,NALPHA
         ALPAT=BHT(J+22)
         IF(.NOT. CANARD) ALPAT=BHT(J+22)-DWASH(J+20)
         BWH(J+100)=BW(101)+(WBT(3)+WBT(4))*(1.0-DWASH(J+40))*DWASH(J)
         IF(.NOT. CANARD) GO TO 1030
         ANUM=WING(101)*HT(101)*DWASH(J)*WB(2)*FACT(J+41)*SSPNE
         ADEN=2.0*PI*AHT(7)*(FACT(J+81)/2.0-WINGIN(4)+WINGIN(3))
         WBT(J+25)=(ANUM/ADEN)*RAD*SREF/AHT(3)
         BWH(J+100)=BW(101)+(WBT(3)+WBT(4))*DWASH(J)+WBT(J+25)
         FACT(J+121)=-WBT(J+25)/((WBT(3)+WBT(4))*DWASH(J))
 1030    CONTINUE
C
C************            CALCULATE (CL)WBT                    **********
C
         ALPEF=FLC(J+22)-BHT(49)+((AKHBI+AKBHI)/(WBT(1)+WBT(2)))*ALIH
         ALPAHT=BHT(J+22)-BHT(49)
         IF(.NOT. CANARD) ALPEF=ALPEF-DWASH(J+20)
         IF(.NOT.CANARD)ALPAHT=ALPAHT-DWASH(J+20)
         CALL BODOWG(FLC(23),WBT(109),WBT(108),SSPN,AHT(27),WBT(68),
     1               WBT(46),NALPHA)
         WBT(J+129)=WBT(J+67)*WBT(J+45)*WBT(108)*DWASH(J)*HT(101)*
     1              ALPAHT/SSPN
      ALPA=FLC(J+22)-DWASH(J+20)
      IY=0
      CALL TBFUNX(ALPEF,WBT(J+109),DYDX,NALPHA,ANG,HT(21),CB,IY,MI,NG,
     1            1,1,QCLTB,1,ROUTID)
      WBT(J+109)=WBT(J+109)*DWASH(J)*(WBT(1)+WBT(2))
      IF(.NOT. CANARD) GO TO 1060
      BWH(J+20)=BW(J+20)+WBT(J+109)+WBT(J+129)+WBT(J+25)*FLC(J+22)
      FACT(J+101)=0.0
      IF(ALPAHT .NE. 0.0) FACT(J+101) = (-WBT(J+25)*(B(J+22)-B(49)))/
     1                            (HT(101)*(WBT(1)+WBT(2))*DWASH(J))
      GO TO 1070
 1060 CONTINUE
      BWH(J+20)=BW(J+20)+WBT(J+109)+WBT(J+129)
 1070 CONTINUE
C
C************             CALCULATE (CM)ALPHA WBT             **********
C
      IF(CANARD) ALPA=FLC(J+22)
      SA=SIN(ALPA/RAD)
      CA=COS(ALPA/RAD)
      DXACWB=BW(121)/BW(101)
      APART=(DXACWB)*((-BW(J+20)/RAD+BD(J+94))*SIN(FLC(J+22)/RAD)+
     1      (BW(101)+BW(J)/RAD)*COS(FLC(J+22)/RAD))
      BPART=((BD(70))/CBARR)*((BW(101)+BW(J)/RAD)*SIN(FLC(J+22)
     1      /RAD)+(BW(J+20)/RAD-BD(J+94))*COS(FLC(J+22)/RAD))
      IK=0
      CALL TBFUNX(ALPAT,CDHT,DCDDA,NALPHA,BHT(23),HT(1),CC,IK,MI,NG,
     1            0,0,QCDHTD,4,ROUTID)
      CLHT=(BWH(J+20)-BW(J+20))/DWASH(J)
      DCLDA=WBT(3)+WBT(4)
      IF(.NOT. CANARD) GO TO 1080
      DCLDA=DCLDA+WBT(J+25)/DWASH(J)
 1080 CONTINUE
      CPART=(-CLHT/RAD+DCDDA)*SA
      DPART=(CLHT/RAD-DCDDA)*CA
      EPART=DWASH(J)*(1.0-DWASH(J+40))
      FPART=(DCLDA+CDHT/RAD)*SA
      GPART=(DCLDA+CDHT/RAD)*CA
      WBT(J+87)=(BD(63)/CBARR)*(CPART+GPART)*EPART-(BD(64)/
     1          CBARR)*(FPART+DPART)*EPART
      IF(.NOT. CANARD) GO TO 1090
      WBT(J+87)=WBT(J+87)/(1.0-DWASH(J+40))
 1090 BWH(J+120)=APART-BPART+WBT(J+87)
      IF(BW(J+40) .EQ. 2.*UNUSED) BWH(J+120)=2.*UNUSED
C
C************             CALCULATE (CM)WBT                *************
C
      DCLHT=(((BWH(J+20)-BW(J+20))/DWASH(J)+CDH(J)*SIN(DWASH(J+20)/RAD))
     1   /COS(DWASH(J+20)/RAD))*DWASH(J)
      IF(CANARD)DCLHT=BWH(J+20)-BW(J+20)
      COSA=CA
      SINA=SA
      CDHQ=CDH(J)*DWASH(J)
      CMOHQ=BHT(47)*DWASH(J)
      BWH(J+40)=BW(J+40)+(BD(63)/CBARR)*(DCLHT*COSA+CDHQ*SINA)
     1        +(BD(64)/CBARR)*(CDHQ*COSA-DCLHT*SINA)+CMOHQ
      IF(BW(J+40) .EQ. 2.*UNUSED)BWH(J+40)=2.*UNUSED
C
C**** VERTICAL TAIL CDO FROM VT DRAG SUBROUTINE
C
      WBT(66)=DVT(20)+DVF(20)
C
C**** CALCULATE CD0 WING BODY HORIZONTAL AND VERTICAL TAIL *************
C
 1100 WBT(67)=WB(17)+BHT(46)+WBT(66)
C
C*********     COMPUTE (CD)WBT AT ANGLE-OF-ATTACK                *******
C*********     SINGLE VERTICAL TAIL (UPPER PANEL)                *******
C
      EPS=DWASH(J+20)
      IF(CANARD)EPS=0.
      BWHV(J)=BW(J)+WBT(66)+(CDH(J)*COS(EPS/RAD)+CLH(J)*
     1        SIN(EPS/RAD))*DWASH(J)
      BWH(J)=BWHV(J)-WBT(66)
 1110 CONTINUE
      RETURN
      END
