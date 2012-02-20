      SUBROUTINE LIFTCF(A,B,AIN,AOUT)
C
C***  COMPUTES LIFTING SURFACE CL
C
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA,IG
      COMMON /OPTION/ SREF,CBARR,ROUGFC,BLREF
      COMMON /CONSNT/ CONST(4)
C
      DIMENSION ROUTID(2),Q3355B(3),Q3355A(3),Q13358(3),Q13356(3),
     1          Q13357(3)
      DIMENSION A(195),B(49),AOUT(380),AIN(100)
      DIMENSION AJ(12),TRAT(7),DCNAA(7,12),DC(84)
      DIMENSION A58(11) , CLJ58(11),C58(6)
      DIMENSION AR(71),AI(11) , C90(11),C90I(11) , D(11),TIR(11)
     1          , CAR(6) , CAI(6) , CTIR(6)
      DIMENSION X13356(6)  , X23356(12) , Y13356(12,6)
      DIMENSION X33356(5) , Y33356(8,4,5)
      DIMENSION X13357(11), Y13357(11) , C11357(6)
      DIMENSION WTYPE(4)
C
      EQUIVALENCE (RAD,CONST(4)),(DEG,CONST(2))
      EQUIVALENCE (DC(1),DCNAA(1,1))
      EQUIVALENCE (AR(1),AI(1),TIR(1))
C
      LOGICAL LTABSW
      LOGICAL LOARAT
C
      DATA ROUTID/4HLIFT,4HCF  /,Q3355B/4H4.1.,4H3.3-,4H55B /,
     1                           Q3355A/4H4.1.,4H3.3-,4H55A /,
     2 Q13358/4H4.1.,4H3.3-,4H58  /,Q13356/4H4.1.,4H3.3-,4H56  /,
     3 Q13357/4H4.1.,4H3.3-,4H57  /
C
C     ----4.1.3.3-55(A)
C
      DATA AJ/-4.,-2.,-1.,0.,.15,.25,.5,1.,1.5,2.,2.5,3.0/
      DATA TRAT/.2,.4,.46,.5,.55,.6,1./
      DATA DC/ -.9,-.676,-.607,-.564,-.506,-.452,0. , -.4,-.3,-.27,-.25,
     1-.225,-.2,0. , -.1,-.075,-.065,-.0625,-.0562,-.05,0. , 2*.25,.225,
     2.2083,.1874,.1666,0.,2*.6,.54,.5,.45,.4,0.,2*.75,.675,.625,
     3.562,.5,0. , 2*1.1,.99,.917,.825,.734,0. , 2*1.6,1.44,1.334,1.2,
     41.068,0. , 3*2.,1.852,1.666,1.48,0. , 4*2.35,2.115,1.88,0.  ,
     5 5*2.65,2.36,0. , 6*2.85,0. /
C
C     ----4.1.3.3-58
C
      DATA I58 /0/
      DATA A58 / 0.,2.,4.,6.,8.,10.,12.,14.,16.,18.,20./
      DATA CLJ58 /.0,.11,.238,.375,.521,.68,.85,1.025,1.205,1.39,1.575/
      DATA TIR/0.,.1,.2,.3,.4,.5,.6,.7,.8,.9,1./
      DATA D/0.,-.35,-.7,-1.,-1.27,-1.46,-1.55,-1.4,-1.,-.21,0./
      DATA IC90/0/
      DATA ICTIR/0/
      DATA II90/0/
      DATA C90I/2.,1.4,1.26,1.21,7*1.2/
      DATA C90/2.,1.32,9*1.2/
C
C     ----FIG,4.1.3.3-56 SOLID
C     ----X13356 = ANGLE OF ATTACK
C
      DATA X13356 /0.,4.,8.,12.,16.,20./
C
C     ----X23356 = BETA * TAN(LEADING EDGE SWEEP ANGLE)
C
      DATA X23356/0.,1.,2.,3.,4.,5.,6.,7.,8.,9.,10.,11./
C
C     ----Y13356(NX2,NX1)
C
      DATA Y13356 / 12*0.,
     1             .165,.157,.120,.095,.082,.074,.066,.061,.058,3*.055
     2 , .297,.276,.227,.190,.167,.151,.142,.135,.130,.127,2*.125 ,
     3.425 ,.409,.350,.300,.268,.250,.235,.225,.217,.212,.209,.208,
     4 .568,.545,.480,.420,.377,.348,.327,.311,.301,.296,2*.293   ,
     5 .701,.675,.602,.533,.482,.443,.422,.404,.392,.385,.381,.380 /
C
C     ----FIG 4.1.3.3-56 DASHED  X33356 IS ASPECT RATIO
C
      DATA X33356 /1.,1.5,2.,2.5,3./
      DATA Y33356 / 40*0.,
     1             6*.07,.066,.061 , 3*.087,.085,.081,.074,.066,.061 ,
     2 .117,.113,.105,.095,.082,.074,.066,.061 ,  .145,.142,.120,.095,
     3.082,.074,.066,.061 , .165,.157,.120,.095,.082,.074,.066,.061 ,
     4 5*.145,.142,.138,.135,2*.180,.178,.172,.163,.151,.142,.135 , .215
     5,.214,.206,.190,.167,.155,.142,.135 , .285,.273,.227,.190,.167,
     6.151,.142,.135 , .297,.276,.227,.190,.167,.151,.142,.135 , .425,
     7.409,.350,.300,.268,.250,.235,.225 , .425,.409,.350,.300,.268,.250
     8,.235,.225 , .425,.409,.350,.300,.268,.250,.235,.225 , .425,.409,
     9.350,.300,.268,.250,.235,.225 , .425,.409,.350,.300,.268,.250,.235
     A,.225 /
C
C     ----4.1.3.3-57
C
      DATA I13357 /0/
      DATA X13357 /0.,.1,.2,.3,.4,.5,.6,.7,.8,.9,1./
      DATA Y13357 /5*7.,6.90,6.75,6.50,6.20,5.80,5.30/
      DATA WTYPE/4HSTRA,4HDOUB,4HCRAN,4HCURV /
C
C     ----INITIALIZATION ENTRY
C
      TYPE=AIN(15)
      LOARAT=.FALSE.
      IF(A(7).LT.A(125))LOARAT=.TRUE.
C
C     ----TEST TYPE OF WING
C
      IF(TYPE.NE.WTYPE(1)) GO TO 1090
C
C     ----HERE STRAIGHT TAPERED WING
C
      AJAYC= .3*(A(123)+1.)*A(7)*A(37)*((A(123)+1.)*(A(159)+1.)-
     1        (A(160)/7.)**3)
      AJAY = AJAYC / B(2)
      NEWM = 1
      A(147)=B(43)-B(49)
      CALL ANGLES(1,A(147))
      CNA=AOUT(101)*RAD
      B(45)=(B(44)/(A(149)*A(150))-CNA*A(150))/
     1      ABS(A(149))
      DO 1070 J=1,NALPHA
         IF(B(J+22).LT.B(43)) GO TO 1050
C
C    ----HERE IF ALPHA GT ACLMAX
C
         IF(A(7).LT.A(125)) GO TO 1010
C
C     ----HIGH ASPECT RATIO
C
         IF(NEWM.EQ.0) GO TO 1020
         NEWM = 0
         BU4 = 4./B(2)
         CALL CLMXBS(BU4,CLSMAX,A,B,AIN)
         GO TO 1020
 1010    CLSMAX = B(44)
 1020    TEMP = B(49)/(90.-B(43))
         A(153) = B(J+22)*(1.+TEMP)-90.*TEMP
         CALL ANGLES(1,A(153))
         RAT=ABS(A(151)/A(157))
         CALL TBFUNX(RAT,DJ,DDDR,11,TIR,D,CTIR,ICTIR,MI,NG,
     1               0,0,4HDJ  ,1,ROUTID)
         IF(A(7).GT.1.) GO TO 1030
         CALL TBFUNX(A(7),CNAA90,DCDA,11,AR,C90,CAR,IC90,MI,NG,
     1               0,0,Q3355B,3,ROUTID)
         GO TO 1040
 1030    AINV=1./A(7)
         CALL TBFUNX(AINV,CNAA90,DCDA,11,AI,C90I,CAI,II90,MI,NG,
     1               0,0,Q3355B,3,ROUTID)
         CNAA90=CNAA90*A(3)/SREF
 1040    CNAAJ=B(45)+(CNAA90-B(45))*(1.-RAT)+RAD*DJ *
     1         AOUT(101)/2.3*(B(2)*B(44)/CLSMAX)**2
         GO TO 1060
 1050    A(153) = B(J+22) - B(49)
         CALL ANGLES(1,A(153))
         RAT=ABS(A(157)/A(151))
C
C     ----4.1.3.3-55(A)
C
         CALL TLINEX(AJ,TRAT,DCNAA,12,7,AJAY,RAT,DCAAJ,
     1               2,1,-1,0,Q3355A,3,ROUTID)
         CNAAJ=B(45)+DCAAJ*A(3)/SREF
 1060    AOUT(J+60)=(RAD*AOUT(101)*A(156)+CNAAJ*ABS(A(155)))*A(155)
         AOUT(J+20)=AOUT(J+60)*COS(DEG*B(J+22))
 1070 CONTINUE
      RETURN
C
C     ----TEST TYPES AND ASPECT RATIO
C
 1090 IF(TYPE.NE.WTYPE(4)) GO TO 1110
C
C     ----HERE FOR CURVED HIGH ASPECT RATIO WINGS-CONSTANT FOR MACH NOS
C
      SQBO2=SQRT(AIN(3)/A(29))
      DO 1100 J=1,NALPHA
         CALL TBFUNX(B(J+22),CLJOSQ,DYDX,11,A58,CLJ58,C58,I58,MI,NG,
     1               0,1,Q13358,3,ROUTID)
         AOUT(J+20)=SQBO2*CLJOSQ*A(3)/SREF
         AOUT(J+60) = AOUT(J+20) / COS(DEG*B(J+22))
 1100 CONTINUE
      RETURN
 1110 IF(TYPE.NE.WTYPE(2)) GO TO 1180
C
C     ----HERE IF DOUBLE DELTA,LOW ASPECT RATIO
C
      CON = A(23)/(AIN(3)*A(5)) * RAD
      BTANLE=B(2)*A(62)
      LTABSW=.TRUE.
      IF(A(7).GE.3.0.OR.B(1).LT.0.7.OR.BTANLE.GT.7.0)LTABSW=.FALSE.
      DO 1160 J=1,NALPHA
C
C     ----ALLOW FOR NEGATIVE ALPHA
C
         ALPHA=0.
         IF(B(J+22).LT.0.0)ALPHA=B(J+22)
         B(J+22)=ABS(B(J+22))
         IF(B(J+22).GE.12.0) GO TO 1120
         IF(LTABSW) GO TO 1130
C
C     ----HERE FOR 4.1.3.3-56 SOLID CURVE
C
 1120    CONTINUE
         CALL TLINEX(X13356,X23356,Y13356,6,12,B(J+22),BTANLE,C3356,
     1               2,2,2,1,Q13356,3,ROUTID)
         GO TO 1140
C
C     ----HERE FOR 4.1.3.3-56 DASHED CURVE
C
 1130    CALL TLIN3X(X33356,X23356,X13356,Y33356,5,8,4,A(7),BTANLE,
     1               B(J+22),C3356,2,2,2,2,1,2,Q13356,3,ROUTID)
 1140    AOUT(J+20)=C3356*AOUT(101)*CON
         IF(ALPHA.GE.0.0)GO TO 1150
         B(J+22)=ALPHA
         AOUT(J+20)=-AOUT(J+20)
 1150    AOUT(J+60) = AOUT(J+20) / COS(DEG*B(J+22))
 1160 CONTINUE
 1170 CONTINUE
      RETURN
 1180 IF(TYPE.NE.WTYPE(3)) GO TO 1290
C
C     ----HERE IF CRANKED HIGH ASPECT RATIO
C     ----DETERMINE ALPHA BREAK
C
      TINVS = 1./A(62)
      CALL TBFUNX(TINVS,ABREAK,DYDX,11,X13357,Y13357,C11357,I13357,
     1               MI,NG,0,2,Q13357,3,ROUTID)
C
C     ----CALCULATE (CL)ALPHA=ALPHA BREAK
C
      CON = A(23)/(AIN(3)*A(5)) * RAD
      BTANLE=B(2)*A(62)
      LTABSW=.TRUE.
      IF(A(7).GE.3.0.OR.B(1).LT.0.7.OR.BTANLE.GT.7.0)LTABSW=.FALSE.
      CLBRAK = AOUT(101)* ABREAK
C
C     ----COMPUTE CLA=ALPHA BREAK NONLINEAR
C
      IF(ABREAK.GE.12.0) GO TO 1190
      IF(LTABSW) GO TO 1200
 1190 CONTINUE
      CALL TLINEX(X13356,X23356,Y13356,5,12,ABREAK,BTANLE,CLABNL,
     1            2,2,2,1,Q13356,3,ROUTID)
      GO TO 1210
 1200 CALL TLIN3X(X33356,X23356,X13356,Y33356,5,8,4,A(7),BTANLE,ABREAK,
     1            CLABNL,2,2,2,2,1,2,Q13356,3,ROUTID)
 1210 CLABNL=CLABNL*AOUT(101)*CON
      DO 1270 J=1,NALPHA
         IF(B(J+22).GT.ABREAK) GO TO 1220
         AOUT(J+20)= AOUT(101) * B(J+22)
         AOUT(J+60) = AOUT(J+20) / COS(DEG*B(J+22))
         GO TO 1260
C
C     ----COMPUTE CL NONLINEAR
C
 1220    IF(B(J+22).GE.12.0) GO TO 1230
         IF(LTABSW) GO TO 1240
C
C     ----4.1.3.3-56 SOLID CURVE
C
 1230    CONTINUE
         CALL TLINEX(X13356,X23356,Y13356,6,12,B(J+22),BTANLE,C3356,
     1               2,2,2,1,Q13356,3,ROUTID)
         GO TO 1250
C
C     ----HERE FOR 4.1.3.3-56 DASHED CURVE
C
 1240    CALL TLIN3X(X33356,X23356,X13356,Y33356,5,8,4,A(7),BTANLE,
     1               B(J+22),C3356,2,2,2,2,1,2,Q13356,3,ROUTID)
 1250    AOUT(J+20)=C3356*AOUT(101)*CON
         AOUT(J+20) = CLBRAK + AOUT(J+20) - CLABNL
         AOUT(J+60) = AOUT(J+20) / COS(DEG*B(J+22))
         GO TO 1270
 1260    CONTINUE
 1270 CONTINUE
 1280 CONTINUE
      RETURN
C
C     ----METHOD DOES NOT APPLY
C
 1290 WRITE(6,1300) TYPE,LOARAT
 1300 FORMAT(28H METHOD NOT APPLICABLE-TYPE= ,A4,8H LOW AR= ,L1)
      RETURN
      END
