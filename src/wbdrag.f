      SUBROUTINE WBDRAG (A,B,D,BD,WB,BW,BODY,WING,KBODY,KWING)
C
C *** CALCULATE SUBSONIC WING-BODY DRAG COEFFICIENT
C
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD,KAND
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA,IG,NF,LF,K
      DIMENSION ROUTID(2),Q33137(3)
      DIMENSION A(195),B(49),BD(59),WB(39),D(55),BW(21),BODY(2),WING(2)
      LOGICAL KBODY,KWING
C
C*********               WING-BODY DRAG CALCULATIONS             *******
C ***                       FIGURE 4.3.3.1-37
C         X237= R(L)FUS       X137= MACH NO.      Y37= R(WB)
C
      DIMENSION X237(19),X137(7),Y37(133)
      DATA X237/3.E06,5.E06,7.E06,1.E07,1.5E07,2.E07,2.5E07,3.E07,
     13.5E07,4.E07,4.5E07,5.E07,6.E07,7.E07,8.E07,1.E08,1.5E08,2.E08,
     27.E08/
      DATA X137/0.25,0.40,0.60,0.70,0.80,0.85,0.90/
      DATA Y37/1.063,1.070,1.073,1.076,1.072,1.066,1.057,1.045,1.025,
     1.9935,.9650,.9515,.9390,.9335,.9310,.9280,.9230,.9225,.9540 ,
     21.020,1.023,1.028,1.036,1.050,2*1.058,1.050,1.032,1.018,1.008,
     31.001,.9920,.9875,.9845,.9800,.9770,.9755,.9750 , .9800,.9840,
     4.9890,.9965,1.0080,1.0200,1.0325,1.0375,1.0350,1.0315,1.0280,
     51.0230,1.0190,1.0155,5*1.0150 , .9550,.9600,.9647,.9725,.9830,
     6.9950,1.0085,1.0130,1.0140,1.0145,9*1.0150 , .9250,.9300,.9340,
     7.9420,.9530,.9655,.9775,.9885,.9965,1.0025,1.0080,1.0110,1.0145,
     86*1.0150 , .9025,.9070,.9120,.9190,.9310,.9425,.9540,.9690,.9820,
     9.9920,.9985,1.0035,1.0110,1.0140,5*1.015 , .8700,.8715,.8775,
     A.8840,.8960,.9090,.9225,.9400,.9570,.9725,.9865,.9935,1.0065,
     B1.0120,5*1.0150/
      DATA Q33137/4H4.3.,4H3.1-,4H37  /,ROUTID/4HWBDR,4HAG  /
C
C*********          WING-BODY ZERO LIFT DRAG           *****************
C
      WB(19)= A(129)*BD(1)
      CALL TLINEX(X137,X237,Y37,7,19,B(1),WB(19),WB(18),
     1            2,2,2,1,Q33137,3,ROUTID)
      WB(17)= (D(20)+BD(59))*WB(18)+BD(60)
      WB(6)=WB(17)
C
C*********          WING-BODY DRAG AT ANGLE-OF-ATTACK       ************
C
      DO 1000 J=1,NALPHA
         BW(J)= WB(17)+BD(J+214)+D(J+35)
         IF((KBODY .OR. KWING) .AND. (BODY(J) .NE. UNUSED .AND.
     1    W       ING(J) .NE. UNUSED)) BW(J) = BODY(J)+WING(J)
 1000 CONTINUE
      RETURN
      END
