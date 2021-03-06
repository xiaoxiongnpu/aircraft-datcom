      SUBROUTINE MAIN00
C
C***  TOP LEVEL EXECUTIVE
C
C             IDEAL OUTPUT MATRIX
C
C             BLOCK    PRINT     IOM
C             NAME     FLAG     ARRAY
C
      COMMON /IBODY/   PBODY,  BODY(400)
      COMMON /IWING/   PWING,  WING(400)
      COMMON /IHT/     PHT,    HT(380)
      COMMON /IVT/     PVT,    VT(380)
      COMMON /IVF/     PVF,    VF(380)
      COMMON /IBW/     PBW,    BW(380)
      COMMON /IBH/     PBH,    BH(380)
      COMMON /IBV/     PBV,    BV(380)
      COMMON /IBWH/    PBWH,   BWH(380)
      COMMON /IBWV/    PBWV,   BWV(380)
      COMMON /IBWHV/   PBWHV,  BWHV(380)
      COMMON /IPOWER/  PPOWER, POWER(200)
      COMMON /IDWASH/  PDWASH, DWASH(60)
C
      LOGICAL PBODY, PWING, PHT, PVT, PVF, PBW, PBH, PBV, PBWH, PBWV,
     1        PBWHV, PPOWER, PDWASH
C
C***  INPUT DATA BLOCKS
C
      COMMON /FLGTCD/ FLC(160)
      COMMON /OPTION/ SREF, CBARR, ROUGFC, BLREF
      COMMON /SYNTSS/ XCG, XW, ZW, ALIW, ZCG, XH, ZH, ALIH, XV,
     1                VERTUP, HINAX, XVF, SCALE, ZV, ZVF, YV, YF,
     2                PHIV, PHIF
      COMMON /BODYI/  BODYIN(128)
      COMMON /WINGI/  WINGIN(101)
      COMMON /VTI/    VTIN(154), TVTIN(8), VFIN(154)
      COMMON /HTI/    HTIN(154)
      COMMON /POWER/  PWIN(29), LBIN(21)
      COMMON /FLAPIN/ F(138)
C
      DIMENSION ZL(20)
      EQUIVALENCE (ZL(1),BODYIN(102))
      EQUIVALENCE (STMACH,FLC(94)), (TSMACH,FLC(95))
      LOGICAL VERTUP
C
C***  COMPUTATIONAL BLOCKS
C
      COMMON /WINGD/  A(195), B(49)
      COMMON /SBETA/  STB(135), TRA(108), TRAH(108), STBH(135)
      COMMON /BDATA/  BD(762)
      COMMON /WHWB/   FACT(182), WB(39), HB(39)
      COMMON /WBHCAL/ WBT(156)
      COMMON /HTDATA/ AHT(195), BHT(49)
      COMMON /VTDATA/ AVT(195), AVF(195)
      COMMON /WHAERO/ C(51), D(55), CHT(51), DHT(55), DVT(55), DVF(55)
      COMMON /POWR/   PW(315)
      COMMON /SUPWBB/  SWB(61), SHB(61)
      COMMON /SUPDW/  DWA(237)
      COMMON /SUPWH/  GR(303)
      COMMON /SUPBOD/ SBD(229)
      COMMON /LEVEL2/ SECOND(23)
C
      DIMENSION SLG(141), STG(141), FCM(287), LB(200), DYN(213)
      DIMENSION SPR(59),FLA(45), FLP(189), STP(156), JET(26), SLA(31)
      DIMENSION FHG(35), TCD(58), TRM(22), TRM2(22), TRN(7), DYNH(213)
      DIMENSION SLAH(31)
C
      EQUIVALENCE (GR(1), FCM(1), SLG(1)), (GR(142), STG(1))
      EQUIVALENCE (DWA(1), LB(1), JET(1), FHG(1)), (WBT(1), STP(1))
      EQUIVALENCE (PW(1), DYN(1), SPR(1)), (PW(60), FLA(1))
      EQUIVALENCE (PW(105), FLP(1)), (PW(294), TRM(1), TRM2(1), TRN(1))
      EQUIVALENCE (STB(1), SLA(1)), (DWA(36), TCD(1)), (DYNH(1),BD(301))
      EQUIVALENCE (STB(32), SLAH(1))
C
C***   CONTROL DATA BLOCKS
C
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD,KAND
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA,IG,NF,LF,K
      COMMON /CASEID/ IDCASE(74),KOUNT,NAMSV(100),IDIM
      COMMON /EXPER/  KLIST, NLIST(100), NNAMES, IMACH, MDATA,
     1                KBODY, KWING, KHT, KVT, KWB, KDWASH(3),
     2                ALPOW, ALPLW, ALPOH, ALPLH
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
C
      LOGICAL FLAG
C
C***  HYPERSONIC CONTROLS
C
      FLAG = HYPEF .AND. HYPERS .AND. (FLC(I+2) .GE. 5.0)
      IF(.NOT. (FLAG .OR. TRAJET)) GO TO 1010
C
C***  INITALIZE IOM AND COMPUTATIONAL ARRAYS
C
        IG = 1
        IF(I .NE. 1) CALL M51O63
        IF(FLAG)   CALL M42O52
        IF(TRAJET) CALL M47O57
        GO TO 1050
 1010 CONTINUE
C
C***  SET MACH DATA AND FLAGS, SET EXPERIMENTAL DATA NAMELISTS
C
      SUBSON = .FALSE.
      TRANSN = .FALSE.
      SUPERS = .FALSE.
      TRIM   = .FALSE.
      IF(FLC(I+2) .GE. TSMACH) SUPERS = .TRUE.
      IF(FLC(I+2) .LE. STMACH) SUBSON = .TRUE.
      FLAG = SUPERS .OR. SUBSON
      IF(.NOT. FLAG)           TRANSN = .TRUE.
      B(1) = FLC(I+2)
      B(2) = SQRT(ABS(1.-FLC(I+2)**2))
      BHT(1) = B(1)
      BHT(2) = B(2)
      A(129)   = FLC(I+42)
      AHT(129) = FLC(I+42)
      AVT(129) = FLC(I+42)
      AVF(129) = FLC(I+42)
      NF = 1
      IG = 1
      IF(KLIST .GT. 0) CALL M51O63
      IF(KLIST .GT. 0) CALL M48O60
C
C***  CALCULATE SUBSONIC DATA
C
      IF(.NOT. SUBSON) GO TO 1030
        IF(.NOT. LOASRT) GO TO 1020
          CALL M14O16
          CALL M49O61
          CALL M12O14
 1020   CONTINUE
        IF(LOASRT) GO TO 1030
          CALL MAIN01
 1030 CONTINUE
C
C***  CALCULATE TRANSONIC AND SUPERSONIC DATA
C
      IF(LOASRT) GO TO 1040
      IF(TRANSN) CALL MAIN03
      IF(SUPERS) CALL MAIN04
C
C***  HIGH LIFT AND CONTROL DATA
C
      TRIM = TRIMC
      FLAG = SYMFP .OR. ASYFP .OR. (TRIM .AND. HTPL .AND. SUBSON)
      IF(.NOT. FLAG) GO TO 1040
        IG = 2
        CALL M51O63
        IF(SUBSON) CALL MAIN05
        IF(TRANSN) CALL MAIN06
        IF(SUPERS) CALL MAIN07
        CALL M39O47
 1040 CONTINUE
C
C***  GROUND EFFECTS DATA
C
      FLAG= SUBSON .AND. (FLC(63) .NE. UNUSED) .AND. (.NOT. LOASRT)
      IF(FLAG) CALL MAIN02
 1050 CONTINUE
      RETURN
      END
