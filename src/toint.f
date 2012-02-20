      SUBROUTINE TOINT(ALPHA, IANS, IERR)
C
C***  CONVERT AN ALPHANUMERIC STRING INTO AN INTEGER CONSTANT
C
C***  INPUTS
C
C  ALPHA - ALPHANUMERIC STRING (MUST BE INTEGER)
C
C***  OUTPUTS
C
C   IANS - INTEGER RESULT
C   IERR - ERROR CODE, 0=NO ERROR OR 1=CONSTANT NOT CORRECT TYPE
C
      INTEGER ALPHA,PERIOD
C
      DIMENSION ALPHA(80)
C
      DATA PERIOD / 4H.    /
C
      IERR=0
      IER1=0
      IER2=0
C
      LCOL=1
C
      CALL FINDCH(ALPHA, PERIOD, LCOL)
C
      IF(LCOL .LT. 81)IER1=1
C
      CALL TODEC(ALPHA, ANS, IER2)
C
      IF(IER1 .GT. 0)IERR=1
      IF(IER2 .GT. 0)IERR=2
C
      SIGN=1
      IF(ANS .LT. 0.)SIGN=-1
      IANS=SIGN*(ABS(ANS)+0.5)
C
      RETURN
      END
