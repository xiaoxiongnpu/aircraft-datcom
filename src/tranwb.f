      SUBROUTINE TRANWB
C
C***  EXECUTIVE FOR TRSONI CALCULATIONS
C
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA,IG
      CALL TRSONI(I)
      RETURN
      END
