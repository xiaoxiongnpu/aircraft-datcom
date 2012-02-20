      SUBROUTINE TLINEX(X1,X2,Y,NX1,NX2,XA1,XA2,YA,LX1L,LX2L,LX1U,LX2U,
     1 MESS,NMSS,ROUT)
C
C***  LINEAR FOR Y=F(X1,X2)
C
      DIMENSION X1(1),X2(1),Y(NX2,NX1),ROUT(2),MESS(2),DA(3)
      DIMENSION MSSCL(13),RMSCL(13)
      EQUIVALENCE (RMSCL(1),MSSCL(1))
      LOGICAL NOIN1,NAS1,X1A,X1B,MSSG1,EX1,LG(7)
      EQUIVALENCE (NOIN1,LG(1)),(X1A,LG(2)),(X1B,LG(3)),(MSSG1,LG(4)),
     1      (EX1,LG(5)),(DA(1),D0),(DA(2),D1),(DA(3),D2),(NAS1,LG(6))
      DATA TLIN /4H1TIN/, HOL1 /4H1EXP/
      DATA MSSCL /4HTLIN,4HEX  ,2*0,2,8*0/
C
      YA=1.E30
      CALL SWITCH(LG,LX1L,LX1U,XA1,X1,NX1)
      IF(LG(7))GO TO 1100
      CALL GLOOK(NX1,XA1,X1,NAS1,NOIN1,I1,T1)
 1000 ID=I1
      DO 1020 I=1,2
         IX=4-I
         GO TO 1130
 1010    IF(NOIN1)GO TO 1060
 1020 ID=ID-1
      IF(.NOT.EX1)GO TO 1040
      IF(NX1.LT.3)GO TO 1030
      IF(X1A.AND.LX1U.GT.1)GO TO 1110
      IF(X1B.AND.LX1L.GT.1)GO TO 1170
 1030 IF(X1A)GO TO 1180
 1040 D0=D1
 1050 D2=D0+T1*(D2-D1)
 1060 YA=D2
 1070 IF(MSSG1.OR.RO.EQ.HOL1)GO TO 1080
      RETURN
 1080 IF(ROUT(1).NE.TLIN)GO TO 1090
      ROUT(1)=HOL1
      RETURN
 1090 CONTINUE
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
      CALL MESSGE(ROUT,MESS,X1,X2,LG,LG,MSSCL)
      RETURN
C
C     ----HERE FOR EXTRAP.
C
 1100 IF(X1B)GO TO 1150
C
C     ----HERE FOR XA1 ABOVE
C
      T1=XA1-X1(NX1)
      I1=NX1
      GO TO 1160
 1110 I1=I1-2
      ID=I1
      IX=1
 1120 I=0
 1130 RO=TLIN
      CALL TLIN1X(X2,Y(1,ID),NX2,XA2,DA(IX),LX2L,LX2U,MESS,NMSS,RO)
      IF(I.NE.0)GO TO 1010
 1140 CALL QUAD(X1(I1),DA,XA1,YA)
      GO TO 1070
C
C     ----HERE FOR XA1 BELOW
C
 1150 T1=XA1-X1(1)
      I1=2
 1160 T1=T1/(X1(I1)-X1(I1-1))
      GO TO 1000
 1170 D0=D1
      D1=D2
      ID=3
      IX=3
      I1=1
      GO TO 1120
 1180 D0=D2
      GO TO 1050
      END
