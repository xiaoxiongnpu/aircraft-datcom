      SUBROUTINE   ANGLES(INTRY,ARG)
C
C        A ROUTINE TO COMPUTE THE FOLLOWING ELEMENTS OF AN ANGLE,
C        GIVEN ANY OF THEM.  INTERNAL TESTING IS DONE TO PRECLUDE
C        RECALCULATION OF ANY OR ALL KNOWN ELEMENTS.
C        ARG(1)---ANGLE IN DEGREES
C        ARG(2)---ANGLE IN RADIANS
C        ARG(3)---SINE OF THE ANGLE
C        ARG(4)---COSINE OF THE ANGLE
C        ARG(5)---TANGENT OF THE ANGLE
C        ARG(6)---TEST VALUE (SET INTERNALLY)
C        ROUTINES CALLED --- ABS,DABS,DATAN2,
C                            DCOS,DMOD,DSIGN,
C                            DSIN,DSQRT,IABS
C        SINGLE PRECISION --- NO STOPS
C
      REAL         ARG(6), C, S, T
      DATA         CON/1.74532925199433E-2/, HPI/1.57079632679489E+0/,
     1             OPI/3.14159265358979E+0/, TPI/6.28318530717959E+0/,
     2             EPS/1.52587890625000E-5/, SPE/1.04857600000000E+6/,
     3             ZER/0.E+0/, ONE/1.E+0/
C
      I=IABS(INTRY)
      ASSIGN 1050 TO J
      GO TO (1020,1030,1080,1100,1120,1140), I
 1000 DO 1010 I=1,6
 1010 ARG(I)=ZER
      ARG(4)=ONE
C
      RETURN
C
 1020 A2=ARG(1)*CON
      GO TO 1040
 1030 A2=ARG(2)
 1040 A2=AMOD(A2+TPI,TPI)
      IF(A2.GT.OPI) A2=A2-TPI
      IF( ABS(A2-ARG(6)).LE.EPS) RETURN
      IF( ABS(A2).LE.EPS) GO TO 1000
      ARG(1)=A2/CON
      ARG(2)=A2
C
      GO TO J, (1050,1070)
C
 1050 ARG(3)= SIN(A2)
      IF(ABS(ARG(3)).LE.EPS) ARG(3)=ZER
      ARG(4)= COS(A2)
      IF(ABS(ARG(4)).GT.EPS) GO TO 1060
      ARG(4)=ZER
      ARG(5)= SIGN(SPE,A2)
      GO TO 1070
 1060 ARG(5)=ARG(3)/ARG(4)
 1070 ARG(6)=A2
C
      RETURN
C
 1080 A3=ARG(3)
 1090 IF( ABS(A3).LE.EPS) GO TO 1000
      IF( ABS(A3).GE.ONE-EPS) GO TO 1160
      A4= SQRT(ONE-A3**2)
      IF( ABS(A4-ARG(4)).LE.EPS.AND.A3*ARG(3).GE.ZER) RETURN
      GO TO 1150
 1100 A4=ARG(4)
 1110 IF( ABS(A4).GE.ONE-EPS) A4= SIGN(ONE,A4)
      A3= SQRT(ONE-A4**2)
      IF( ABS(A4).LE.EPS) GO TO 1160
      IF( ABS(A3-ARG(3)).LE.EPS.AND.A4*ARG(4).GE.ZER) RETURN
      GO TO 1150
 1120 A1=ARG(5)
 1130 IF( ABS(A1).GT.SPE) A1= SIGN(SPE,A1)
      A2=A1/ SQRT(ONE+A1**2)
      A3= SIGN(A2,A1)
      GO TO 1090
 1140 A3=ARG(3)
      A4=ARG(4)
      A1= SQRT(A3**2+A4**2)
      IF(A1.EQ.ZER) GO TO 1000
      A3=A3/A1
      A4=A4/A1
 1150 IF( ABS(A4).LE.EPS) GO TO 1160
      IF( ABS(A3).LE.EPS) A3=ZER
      A2= ATAN2(A3,A4)
      ARG(3)=A3
      ARG(4)=A4
      ARG(5)=A3/A4
      ASSIGN 1070 TO J
      GO TO 1040
 1160 A2= SIGN(HPI,A3)
      ARG(3)= SIGN(ONE,A3)
      ARG(4)=ZER
      ARG(5)= SIGN(SPE,A3)
      ASSIGN 1070 TO J
      GO TO 1040
      END
