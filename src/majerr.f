      SUBROUTINE MAJERR
C
C     ----TESTS FOR MISSING ESSENTIAL NAMELISTS
C
      COMMON /FLAPIN/ F(138)
      COMMON /FLOLOG/ FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1                HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,SUPERS,SUBSON,
     2                TRANSN,HYPERS,SYMFP,ASYFP,TRIMC,TRIM,DAMP,
     3                HYPEF,TRAJET,BUILD,FIRST,DRCONV,PART,
     4                VFPL,VFSC,CTAB
      COMMON /ERROR/  IERR,GONOGO,IEND,DMPALL,DPB,DPA,DPBD,DPAVF,
     1                DPFACT,DPWBT,DPBHT,DPAVT,DPAHT,DPC,DPD,DPWB,
     2                DPCHT,DPDHT,DPDYNH,SAVE,DMPCSE,DPDVT,DPGR,DPLB,
     3                DPPW,DPSTB,DPSBD,DPSLG,DPSWB,DPSTP,DPDWA,DPSTG,
     4                DPSLA,DPTRA,DPEXPD,DPDVF,DPFLP,DPFHG,DPFCM,DPTCD,
     5                DPFLA,DPTRM,DPSPR,DPTRN,DPTRM2,DPHYP,DPDYN,DPJET,
     6                DPHB,DPSHB,DPTRAH,DPSTBH,DPSEC,DPSLAH,DPINPT,
     7                DPFLC,DPOPTN,DPSYN,DPBDIN,DPWGIN,DPVTIN,DPTVT,
     8                DPVFIN,DPHTIN,DPPWIN,DPLBIN,DPF,DPIOM,
     9                DPIBDY,DPIWG,DPIHT,DPIVT,DPIVF,DPIBW,DPIBH,DPIBV,
     A                DPIBWH,DPIBWV,DPITOT,DPIPWR,DPIDWH
C
      LOGICAL  FLTC,OPTI,BO,WGPL,WGSC,SYNT,HTPL,HTSC,VTPL,VTSC,
     1         HEAD,PRPOWR,JETPOW,LOASRT,TVTPAN,SUPERS,SUBSON,
     2         TRANSN,HYPERS,SYMFP,ASYFP,TRIMC,TRIM,DAMP,
     3         HYPEF,TRAJET,BUILD,FIRST,DRCONV,PART,
     4         VFPL,VFSC,CTAB
      LOGICAL  IERR,GONOGO,IEND,DMPALL,DPB,DPA,DPBD,DPAVF,
     1         DPFACT,DPWBT,DPBHT,DPAVT,DPAHT,DPC,DPD,DPWB,
     2         DPCHT,DPDHT,DPDYNH,SAVE,DMPCSE,DPDVT,DPGR,DPLB,
     3         DPPW,DPSTB,DPSBD,DPSLG,DPSWB,DPSTP,DPDWA,DPSTG,
     4         DPSLA,DPTRA,DPEXPD,DPDVF,DPFLP,DPFHG,DPFCM,DPTCD,
     5         DPFLA,DPTRM,DPSPR,DPTRN,DPTRM2,DPHYP,DPDYN,DPJET,
     6         DPHB,DPSHB,DPTRAH,DPSTBH,DPSEC,DPSLAH,DPINPT,
     7         DPFLC,DPOPTN,DPSYN,DPBDIN,DPWGIN,DPVTIN,DPTVT,
     8         DPVFIN,DPHTIN,DPPWIN,DPLBIN,DPF,DPIOM,
     9         DPIBDY,DPIWG,DPIHT,DPIVT,DPIVF,DPIBW,DPIBH,DPIBV,
     A         DPIBWH,DPIBWV,DPITOT,DPIPWR,DPIDWH
      LOGICAL LOGCOM(10)
      EQUIVALENCE (LOGCOM(1),FLTC)
C
C     ----TEST FOR FLIGHT CONDITIONS IF ABSENT CANNOT RUN.
C
      IF(FLTC) GO TO 1010
      WRITE(6,1000)
 1000 FORMAT(57H0ERROR-FLIGHT CONDITIONS NOT PRESENT-MISSING NAME*FLTCON
     1* )
      IERR=.TRUE.
C
C     ----TEST FOR SYNTHESIS QUANTITIES.IF ABSENT NO RUN.
C
 1010 IF(SYNT) GO TO 1030
      WRITE(6,1020)
 1020 FORMAT(50H0ERROR-SYNTHESIS DATA MISSING-MISSING NAME*SYNTHS* )
      IERR=.TRUE.
C
C     ----TEST FOR WING
C
 1030 IF(WGPL.AND.WGSC) GO TO 1070
C
C     ----TEST FOR PLANFORM OR SECTION CHARACTERISTICS PRESENT.
C
      IF(WGPL.OR.WGSC) GO TO 1040
      GO TO 1070
C
C     ----HERE FOR PART OF WING DATA MISSING.
C
 1040 IF(WGPL) WRITE(6,1050)
 1050 FORMAT(84H0ERROR-WING PLANFORM PRESENT BUT SECTION CHARACTERISTICS
     1 ABSENT-MISSING NAME*WGSCHR* )
      IF(WGSC) WRITE(6,1060)
 1060 FORMAT(84H0ERROR-WING SECTION CHARACTERISTICS PRESENT BUT PLANFORM
     1 ABSENT-MISSING NAME*WGPLNF* )
      IERR=.TRUE.
C
C     ----TEST FOR HORIZONTAL TAIL.
C
 1070 IF(HTSC.AND.HTPL)GO TO 1110
      IF(HTSC.OR.HTPL)GO TO 1080
      GO TO 1110
C
C     ----TEST FOR
C
 1080 IF(HTSC) WRITE(6,1090)
 1090 FORMAT(61H0MISSING PLANFORM FOR HORIZONTAL TAIL-MISSING NAME IS*HT
     1PLNF* )
      IF(HTPL) WRITE(6,1100)
 1100 FORMAT(68H0MISSING SECTION CHARACTERISTICS FOR HORIZONTAL TAIL-NAM
     1E IS*HTSCHR* )
      IERR=.TRUE.
C
C     ----HAVE HORIZONTAL TAIL-TEST FOR WING AND BODY
C
 1110 IF(.NOT.VTSC)GO TO 1130
      IF(VTPL) GO TO 1130
      WRITE(6,1120)
 1120 FORMAT(80H0ERROR-MUST HAVE VERTICAL TAIL PLANFORM WHEN V.T.PRESENT
     1-MISSING NAME IS*VTPLNF* )
      IERR=.TRUE.
 1130 IF(IERR) WRITE(6,1140)
 1140 FORMAT(42H0THIS CASE ABORTED FOR THE ABOVE REASON(S) /
     1  34H ALL NAMES REFER TO NAMELIST NAMES )
C
      IF(.NOT. CTAB) GO TO 1160
      ITYPE = F(17)+0.5
      IF(SYMFP .AND. (ITYPE .EQ. 1)) GO TO 1160
        CTAB = .FALSE.
        WRITE(6,1150)
 1150   FORMAT(45H0 ERROR - MUST HAVE PLAIN TRAILING EDGE FLAP ,
     1         27HWHEN CONTROL TABS ARE INPUT,/
     2         9X,40H CONTROL TAB DATA WILL NOT BE CALCULATED/)
 1160 CONTINUE
      RETURN
      END
