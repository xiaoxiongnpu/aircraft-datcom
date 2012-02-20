      SUBROUTINE TLIN3X(X1,X2,X3,Y,NX1,NX2,NX3,XA1,XA2,XA3,YA,LX1L,LX2L,
     1LX3L,LX1U,LX2U,LX3U,MESS,NMSS,ROUT)
C
C***  LINEAR INTERPOLATION FOR Y=F(X1,X2,X3)
C
      DIMENSION Y(NX1,NX2,NX3),X1(NX1),X2(NX2),X3(NX3),
     1          DA(3),MESS(20),ROUT(2)
      DIMENSION MSSCL(17),RMSCL(17)
      EQUIVALENCE (RMSCL(1),MSSCL(1))
      LOGICAL NOIN3,NAS3,X3A,X3B,MSSG3,EX3,LG(7)
      EQUIVALENCE (NOIN3,LG(1)),(X3A,LG(2)),(X3B,LG(3)),(MSSG3,LG(4)),
     1      (EX3,LG(5)),(DA(1),D0),(DA(2),D1),(DA(3),D2),(NAS3,LG(6))
      DATA TLIN /4H1TIN/, HOL1 /4H1EXP/
      DATA MSSCL /4HTLIN,4H3X  ,2*0,3,12*0/
C
C     ----INITIALIZE SWITCHES.
C
      CALL SWITCH(LG,LX3L,LX3U,XA3,X3,NX3)
      IF(LG(7))GO TO 1110
 1000 CALL GLOOK(NX3,XA3,X3,NAS3,NOIN3,I3,T3)
 1010 ID=I3
      DO 1030 I=1,2
         IX=4-I
         GO TO 1140
 1020    IF(NOIN3)GO TO 1070
 1030 ID=ID-1
      IF(.NOT.EX3)GO TO 1050
      IF(NX3.LT.3)GO TO 1040
      IF(X3A.AND.LX3U.GT.1)GO TO 1120
      IF(X3B.AND.LX3L.GT.1)GO TO 1180
 1040 IF(X3A)GO TO 1190
 1050 D0=D1
 1060 D2=D0+T3*(D2-D1)
 1070 YA=D2
 1080 IF(MSSG3.OR.RO.EQ.HOL1)GO TO 1090
      RETURN
 1090 IF(ROUT(1).NE.TLIN)GO TO 1100
      ROUT(1)=HOL1
      RETURN
 1100 CONTINUE
C
C     ----PRINT EXTRAPOLATION MESSAGE.
C
      MSSCL(3)=NMSS
      RMSCL(4)=YA
C
C     ----1ST VARIABLE.
C
      RMSCL(6)=XA1
      MSSCL(7)=NX1
      MSSCL(8)=LX1L
      MSSCL(9)=LX1U
C
C     ----2ND VARIABLE.
C
      RMSCL(10)=XA2
      MSSCL(11)=NX2
      MSSCL(12)=LX2L
      MSSCL(13)=LX2U
C
C     ----3RD VARIABLE.
C
      RMSCL(14)=XA3
      MSSCL(15)=NX3
      MSSCL(16)=LX3L
      MSSCL(17)=LX3U
      CALL MESSGE(ROUT,MESS,X1,X2,X3,LG,MSSCL)
      RETURN
C
C     ----HERE FOR EXTRAP.
C
 1110 IF(X3B)GO TO 1160
C
C     ----HERE FOR XA3 ABOVE
C
      T3=XA3-X3(NX3)
      I3=NX3
      GO TO 1170
 1120 I3=I3-2
      ID=I3
      IX=1
 1130 I=0
 1140 RO=TLIN
      CALL TLINEX(X1,X2,Y(1,1,ID),NX1,NX2,XA1,XA2,DA(IX),LX1L,LX2L,LX1U,
     1            LX2U,MESS,NMSS,RO)
      IF(I.NE.0)GO TO 1020
 1150 CALL QUAD(X3(I3),DA,XA3,YA)
      GO TO 1080
C
C     ----HERE FOR XA3 BELOW
C
 1160 T3=XA3-X3(1)
      I3=2
 1170 T3=T3/(X3(I3)-X3(I3-1))
      GO TO 1010
 1180 D0=D1
      D1=D2
      ID=3
      IX=3
      I3=1
      GO TO 1130
 1190 D0=D2
      GO TO 1060
      END
