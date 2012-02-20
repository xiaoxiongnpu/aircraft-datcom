      SUBROUTINE M33O41
C
C**  EXEX FOR OVERLAY 33, SUBSONIC HORIZONTAL TAIL CM
C
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA,IG,IJKDUM(3),NOVLY
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD
      COMMON /HTDATA/ AHT(195),BHT(49)
      COMMON /WHAERO/ C(51),D(55),CHT(51)
      COMMON /IHT/    PHT, HT(380)
      COMMON /HTI/    HTIN(154)
      COMMON /FLGTCD/ FLC(95)
      COMMON /EXPER/  KK(106),KHT
      DIMENSION C1(6), C3(6), ROUTID(2)
      LOGICAL FLAG,KHT
      DATA ROUTID / 4HM33O, 4H41   /
      DATA STRA/ 4HSTRA /
      NOVLY=33
      CALL CMALPH(AHT,BHT,CHT,HTIN,HT)
      CALL CACALC(BHT,HT)
      CALL EXSUBT
      IN = 0
      CLA=HT(101)
      CMA=HT(121)
      IM = 0
      DO 1010 J=1,NALPHA
         CA = COS(FLC(J+22)/RAD)
         SA = SIN(FLC(J+22)/RAD)
         HT(J+60) = HT(J+20)*CA + HT(J)*SA
         HT(J+80) = HT(J)*CA - HT(J+20)*SA
         CALL TBFUNX(FLC(J+22),X,HT(J+100),NALPHA,FLC(23),HT(21),
     1               C1,IN,MI,NG,0,0,4HCLA ,1,ROUTID)
         CALL TBFUNX(FLC(J+22),X,HT(J+120),NALPHA,FLC(23),HT(41),
     1               C3,IM,MI,NG,0,0,4HCMA ,1,ROUTID)
 1010 CONTINUE
      IN=0
      IM=0
      IF(KHT)CALL TBFUNX(0.,X,CLA,NALPHA,FLC(23),HT(21),C1,IN,MI,NG,
     1 0,0,4HCLAH,1,ROUTID)
      IF(KHT)CALL TBFUNX(0.,X,CMA,NALPHA,FLC(23),HT(41),C1,IM,MI,NG,
     1 0,0,4HCMAH,1,ROUTID)
C
C***  IF THE H.T. LIFT DEVIATES FROM THE LINEAR VALUE BY
C***  7.5 PERCENT OR MORE SET CM AND CMA TO NA (2*UNUSED)
C
      IF(AHT(7) .LE. (6./AHT(124)) .AND. HTIN(15) .EQ. STRA) GO TO 1030
      IF(KHT) GO TO 1030
      FLAG=.FALSE.
      DO 1020 J=2,NALPHA
         DEL = 100.*ABS(HT(J+100)/HT(101)-1.0)
         IF(DEL .GT. 7.5) FLAG=.TRUE.
         IF(FLAG) HT(J+40)  = 2.0*UNUSED
         IF(FLAG) HT(J+120)=2.0*UNUSED
 1020 CONTINUE
      HT(101)=CLA
      HT(121)=CMA
 1030 CONTINUE
      RETURN
      END
