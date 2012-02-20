      SUBROUTINE TLIN4X(X1,X2,X3,X4,Y,NX1,NX2,NX3,NX4,XA1,XA2,XA3,XA4,YA
     1,LX1L,LX2L,LX3L,LX4L,LX1U,LX2U,LX3U,LX4U,MESS,NMSS,ROUT)
C
C***  LINEAR INTERPOLATION OF Y=F(X1,X2,X3,X4)
C     ----STRUCTURE OF Y ARRAY IS Y(NX2,NX1,NX3,NX4)
C
      DIMENSION Y(1),X1(1),X2(1),X3(1),X4(1),
     1          DA(3),MESS(20),ROUT(2)
      DIMENSION MSSCL(21),RMSCL(21)
      EQUIVALENCE (RMSCL(1),MSSCL(1))
      LOGICAL NOIN4,NAS4,X4A,X4B,MSSG4,EX4,LG(7)
      EQUIVALENCE (NOIN4,LG(1)),(X4A,LG(2)),(X4B,LG(3)),(MSSG4,LG(4)),
     1       (EX4,LG(5)),(DA(1),D0),(DA(2),D1),(DA(3),D2),(NAS4,LG(6))
      DATA TLIN/4H1TIN/,HOL1/4H1EXP/
      DATA MSSCL/4HTLIN,4H4X  ,2*0,4,16*0/
C
C     ----INITIALIZE SWITCHES.
C
      CALL SWITCH(LG,LX4L,LX4U,XA4,X4,NX4)
      IF(LG(7))GO TO 1110
 1000 CALL GLOOK(NX4,XA4,X4,NAS4,NOIN4,I4,T4)
 1010 N123=NX1*NX2*NX3
      LOC=N123*(I4-1)+1
         DO 1030 I=1,2
         IX=4-I
         GO TO 1140
 1020    IF(NOIN4)GO TO 1070
         IF(I.EQ.1)LOC=LOC-N123
 1030 CONTINUE
      IF(.NOT.EX4)GO TO 1050
      IF(NX4.LT.3)GO TO 1040
      IF(X4A.AND.LX4U.GT.1)GO TO 1120
      IF(X4B.AND.LX4L.GT.1) GO TO 1180
 1040 IF(X4A)GO TO 1190
 1050 D0=D1
 1060 D2=D0+T4*(D2-D1)
 1070 YA=D2
 1080 IF(MSSG4.OR.RO.EQ.HOL1)GO TO 1090
      RETURN
 1090 CONTINUE
C
C     ----SUPRESS MESSAGE IF CALLED BY INTERX
C
      IF(ROUT(1).NE.TLIN)GO TO 1100
      ROUT(1)=HOL1
      RETURN
C
C     ----PRINT EXTRAPOLATION MESSAGE.
C
 1100 MSSCL(3)=NMSS
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
C
C     ----4TH VARIABLE
C
      RMSCL(18)=XA4
      MSSCL(19)=NX4
      MSSCL(20)=LX4L
      MSSCL(21)=LX4U
      CALL MESSGE(ROUT,MESS,X1,X2,X3,X4,MSSCL)
      RETURN
C
C     ----HERE FOR EXTRAPOLATION.
C
 1110 IF(X4B)GO TO 1160
C
C     ----HERE FOR XA4 ABOVE.
C
      T4=XA4-X4(NX4)
      I4=NX4
      GO TO 1170
 1120 LOC=LOC-N123
      I4=I4-2
      IX=1
 1130 I=0
 1140 RO=TLIN
      CALL TLIN3X(X1,X2,X3,Y(LOC),NX1,NX2,NX3,XA1,XA2,XA3,DA(IX),LX1L,
     1 LX2L,LX3L,LX1U,LX2U,LX3U,MESS,NMSS,RO)
      IF(I.NE.0)GO TO 1020
 1150 CALL QUAD(X4(I4),DA,XA4,YA)
      GO TO 1080
C
C     ----HERE FOR XA4 BELOW.
C
 1160 T4=XA4-X4(1)
      I4=2
 1170 T4=T4/(X4(I4)-X4(I4-1))
      GO TO 1010
 1180 D0=D1
      D1=D2
      I4=1
      LOC=LOC+2*N123
      IX=3
      GO TO 1130
 1190 D0=D2
      GO TO 1060
      END
