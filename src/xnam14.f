      SUBROUTINE XNAM14(IOP)
C
      COMMON /FLGTCD/ AF(141)
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD,KAND
C
      INTEGER GRNDEF
      LOGICAL EOF
C
      DIMENSION LENF(2),LDMF(2),GRNDEF(8),LOCF(2)
      DIMENSION NLNAME(6)
C
      DATA NLNAME / 4HG   ,4HR   ,4HN   ,4HD   ,4HE   ,4HF   /
      DATA LENF / 3,5 /
      DATA LDMF / 1,10 /
      DATA LOCF / 63,64 /
      DATA GRNDEF /   4HN   ,4HG   ,4HH   ,4HG   ,4HR   ,4HD   ,
     1  4HH   ,4HT   /
C
C**   IF IOP EQUAL ZERO READ NAMELIST GRNDEF
C**   IF IOP EQUAL ONE WRITE NAMELIST GRNDEF
C
      IF(IOP .EQ. 0)
     1   CALL NAMER(KAND,9,NLNAME,6,GRNDEF,8,LENF,2,LDMF,AF,141,
     2              LOCF,EOF)
      IF(IOP .EQ. 1)
     1  CALL NAMEW(KAND,6,NLNAME,6,GRNDEF,8,LENF,2,LDMF,AF,141,LOCF)
C
      RETURN
      END
