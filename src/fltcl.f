      SUBROUTINE FLTCL(FOT,IFOT,NTRIM,CLUT,CDUT,CMUT,DELT,
     1                 DCLT,DCLMT,DCDIT,DCDMT,CDHT,CLT,CDT,
     2                 ICASE)
C
      COMMON /OPTION/   SREF,CBARR,ROUGFC,BLREF
      COMMON /CONSNT/   PI,DEG,UNUSED,RAD
      COMMON /FLGTCD/   FLC(156),WT,GAM,NALT,LOOP
      COMMON /OVERLY/   NLOG,NMACH,IM,NALPHA,IG,NF,LF,IALT
      COMMON /CASEID/   JCASE(175),IDIM
C
      DIMENSION FOT(46),IFOT(11),CLUT(20),CDUT(20),CMUT(20)
      DIMENSION DELT(20),DCLT(20),DCLMT(20),DCDIT(20),DCDMT(20)
      DIMENSION CDHT(20),CLT(20),CDT(20)
      DIMENSION CWT(20),MACH(20),PINF(20)
      DIMENSION ALP(1),CL(1),CD(1),CLUE(1),CDUE(1),CMUE(1)
      DIMENSION DELE(1),DCLE(1),CLME(1),CLIE(1),CDME(1),CHDE(1)
      DIMENSION CHAE(1),WDIM(4),ROUTID(2),CC(6)
C
      LOGICAL FLAG
      REAL MACH
      EQUIVALENCE (MACH(1),FLC(3)),(PINF(1),FLC(74))
C
      DATA WDIM / 4H LB., 4H LB., 4H N. , 4H N. /
      DATA ROUTID / 4HFLTC, 4HL   /
C
C***  ICASE = 1 - TRIM WITH FLAPS
C***  ICASE = 2 - ALL MOVEABLE HORIZONTAL TAIL TRIM
C
      IF(ICASE .NE. 1) GO TO 1010
        DO 1000 I=1,NTRIM
          CLT(I) = CLUT(I)+DCLT(I)
          CDT(I) = CDUT(I)+DCDMT(I)+DCDIT(I)
 1000   CONTINUE
 1010 CONTINUE
C
C*** CALCULATE CW AND TEST FOR CWT RANGE
C
      QS = SREF*(0.7*PINF(IALT)*MACH(IM)**2)
      CW = WT/QS
      DO 1020 I=1,NTRIM
        CWT(I) = CLT(I)*COS(GAM/RAD)-CDT(I)*SIN(GAM/RAD)
 1020 CONTINUE
      FLAG = (CW .GT. CWT(NTRIM)) .OR. (CW .LT. CWT(1))
      IF(FLAG) WRITE(6,1060)WT,WDIM(IDIM),CW
C
C***  FIND EQUILIBRIUM ANGLE OF ATTACK AND TRIM DATA
C
      IF(FLAG) GO TO 1050
        IN=0
        CALL TBFUNX(CW,ALP(1),DYDX,NTRIM,CWT,FLC(23),CC,IN,
     1              MI,NG,0,0,4HALPE,1,ROUTID)
        IN=0
        CALL TBFUNX(ALP(1),CL(1),DYDX,NTRIM,FLC(23),CLT,CC,IN,
     1              MI,NG,0,0,4HCLTE,1,ROUTID)
        IN=0
        CALL TBFUNX(ALP(1),CD(1),DYDX,NTRIM,FLC(23),CDT,CC,IN,
     1              MI,NG,0,0,4HCDTE,1,ROUTID)
        IF(ICASE .NE. 1)GO TO 1030
          IN = 0
          CALL TBFUNX(ALP(1),CLUE(1),DYDX,NTRIM,FLC(23),CLUT,CC,IN,
     1                MI,NG,0,0,4HCLUE,1,ROUTID)
          IN = 0
          CALL TBFUNX(ALP(1),CDUE(1),DYDX,NTRIM,FLC(23),CDUT,CC,IN,
     1                MI,NG,0,0,4HCDUE,1,ROUTID)
          IN = 0
          CALL TBFUNX(ALP(1),CMUE(1),DYDX,NTRIM,FLC(23),CMUT,CC,IN,
     1                MI,NG,0,0,4HCMUE,1,ROUTID)
          IN = 0
          CALL TBFUNX(ALP(1),DELE(1),DYDX,NTRIM,FLC(23),DELT,CC,IN,
     1                MI,NG,0,0,4HDELE,1,ROUTID)
          IN = 0
          CALL TBFUNX(ALP(1),DCLE(1),DYDX,NTRIM,FLC(23),DCLT,CC,IN,
     1                MI,NG,0,0,4HDCLE,1,ROUTID)
          IN = 0
          CALL TBFUNX(ALP(1),CLME(1),DYDX,NTRIM,FLC(23),DCLMT,CC,IN,
     1                MI,NG,0,0,4HCLME,1,ROUTID)
          IN = 0
          CALL TBFUNX(ALP(1),CLIE(1),DYDX,NTRIM,FLC(23),DCLIT,CC,IN,
     1                MI,NG,0,0,4HCLIE,1,ROUTID)
          IN = 0
          CALL TBFUNX(ALP(1),CDME(1),DYDX,NTRIM,FLC(23),DCDMT,CC,IN,
     1                MI,NG,0,0,4HCDME,1,ROUTID)
          IN = 0
          CALL TBFUNX(ALP(1),CHDE(1),DYDX,NTRIM,FLC(23),CHDT,CC,IN,
     1                MI,NG,0,0,4HCHDE,1,ROUTID)
          CHAE(1) = 0.0
          WRITE(6,1070)
          CALL SWRITE(11,FOT,46,IFOT,1,ALP,CLUE,CDUE,CMUE,
     1                DELE,DCLE,CLME,CDIE,CDME,CHAE,CHDE,
     2                X,X,X,NDM,NAF)
 1030   CONTINUE
        IF(ICASE .NE. 2) GO TO 1040
          WRITE(6,1070)
          WRITE(6,1080) ALP(1),CL,CD
 1040   CONTINUE
 1050 CONTINUE
      RETURN
 1060 FORMAT(39H0*** REQUIRED LIFT COEFFICIENT EXCEEDS ,
     1       18HRANGE OF TRIM DATA  /
     2       22H0*** VEHICLE WEIGHT = ,F9.2,A4/
     3       36H0*** LEVEL FLIGHT LIFT COEFFICIENT = ,F8.5)
 1070 FORMAT(1H )
 1080 FORMAT(1H0,52X,F5.1,3X,F6.3,3X,F6.3)
      END
