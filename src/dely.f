      SUBROUTINE DELY
C
C  CALCULATE THE PARAMETER DELTAY
C
      COMMON /IWING/ PW, X(60)
      COMMON / IBW / PBW,L
      COMMON / IBH / PBH, THN(60),CAM(60)
      COMMON /IBWHV/ PBWHV, RHO,TMAX,DELTAY
      DIMENSION C1(6),C2(6),ROUT(2),NAME(1)
      DATA ROUT / 4HM50O, 4H62  /
      DATA NAME /4HDELY/
      IN1=0
      IN2=0
      CALL TBFUNX(.0015,YU15,D,L,X ,THN,C1,IN1,MI,NG,0,0,NAME,1,ROUT)
      CALL TBFUNX(.0600,YU60,D,L,X ,THN,C2,IN2,MI,NG,0,0,NAME,1,ROUT)
      DELTAY=(YU60-YU15)*100.
      RETURN
      END
