      SUBROUTINE M54O66
C
C***  EXEC FOR OVERLAY 54, SUPERSONIC WING CM ALPHA DOT
C
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA,IG,IJKDUM(3),NOVLY
      COMMON /CONSNT/ PI,DEG,UNUSED
      COMMON /IWING/  PWING, WING(400)
      COMMON /IHT/    PHT, HT(380)
      COMMON /FLOLOG/ FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1                HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,
     2                SUPERS,SUBSON,TRANSN,HYPERS,
     3                SYMFP,ASYFP,TRIMC,TRIM
      LOGICAL FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1        HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,
     2        SUPERS,SUBSON,TRANSN,HYPERS,
     3        SYMFP,ASYFP,TRIMC,TRIM
      NOVLY=54
      IF(WGPL) CALL SUPCMD
      IF(HTPL) CALL SUPHMD
C
C     FOR CMAD ONLY ONE POINT CALCULATED
C     BLANK OUT REMAINING POINTS
C
      DO 1000 J=2,NALPHA
         HT(J+260) = -UNUSED
 1000 WING(J+260) = -UNUSED
      RETURN
      END
