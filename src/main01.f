      SUBROUTINE MAIN01
C
C***  DIGITAL DATCOM SUBSONIC AERO EXECUTIVE
C
C***  IDEAL OUTPUT MATRIX
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
      COMMON /FLAPIN/ F(116)
C
      DIMENSION ZL(20)
      EQUIVALENCE (ZL(1),BODYIN(102))
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
      COMMON /WHAERO/ C(51), D(55), CHT(51), DHT(55), DVT(55)
      COMMON /POWR/   PW(315)
      COMMON /SUPWBB/  SWB(61), SHB(61)
      COMMON /SUPDW/  DWA(237)
      COMMON /SUPWH/  GR(303)
      COMMON /SUPBOD/ SBD(229)
C
C
C***   CONTROL DATA BLOCKS
C
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD,KAND
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA,IG,NF
      COMMON /CASEID/ IDCASE(74),KOUNT,NAMSV(100)
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
      LOGICAL FLAG, KDWASH
      DATA STRA/4HSTRA/
C
C***  INITALIZE IOM AND COMPUTATIONAL ARRAYS
C
      IG = 1
      CALL M51O63
      CALL EXSUBT
C
C***  SET REYNOLDS NO., CLALPA, AND CLMAX IN A-ARRAYS
C
      A(131)   = WINGIN(I+20)
      AHT(131) = HTIN(I+20)
      AVT(131) = VTIN(I+20)
      AVF(131) = VFIN(I+20)
      A(132)   = WINGIN(I+40)
      AHT(132) = HTIN(I+40)
      AVT(132) = VTIN(I+40)
      AVF(132) = VFIN(I+40)
C
C***  SINGLE COMPONENT AERO - BODY, WING, HT, AND VT
C
      IF(.NOT. BO) GO TO 1010
        FLAG = (ZL(1) .EQ. UNUSED) .OR. (BODYIN(128) .GT. 1.50)
        IF(.NOT. FLAG) CALL M04O04
        IF(   FLAG   ) CALL M06O06
 1010 CONTINUE
      IF(.NOT. WGPL) GO TO 1020
        CALL M15O17
        CALL M03O03
        CALL M31O37
        BD(69) = C(6)*A(10)
        BD(70) = BD(68)-BD(69)*BD(78)-BD(82)
        BD(71) = BD(67)-BD(69)*BD(79)
        BD(72) = (BD(71)+BD(70)*BD(80))*BD(79)
        BD(73) = (BD(70)/BD(79))-(BD(71)+BD(70)*BD(80))*BD(78)
 1020 CONTINUE
      IF(.NOT. HTPL) GO TO 1030
        CALL M16O20
        CALL M05O05
        CALL M33O41
 1030 CONTINUE
      IF(VTPL .OR. VFPL) CALL M08O10
      CALL EXSUBT
C
C***  CALCULATE B-W, B-H, AND B-V DATA
C
      FLAG = BO .AND. (WGPL .OR. HTPL .OR. VTPL .OR. VFPL)
      BD(83) = A(161) + XW
      IF(FLAG) CALL M07O07
      IF(FLAG) CALL EXSUBT
C
C***  CALCULATE B-W-H, B-W-V, AND B-W-H-V
C
      FLAG = BO .AND. WGPL .AND. (HTPL .OR. VTPL .OR. VFPL)
      IF(.NOT. FLAG) GO TO 1060
        FLAG = (KDWASH(1) .AND. KDWASH(2) .AND. KDWASH(3)) .OR.
     1         (WINGIN(15) .EQ. STRA)
        IF(.NOT. FLAG) GO TO 1040
          IF(WINGIN(15) .EQ. STRA .AND. HTPL)
     1      CALL M09O11
          CALL M10O12
 1040   CONTINUE
        IF( FLAG) GO TO 1050
          BUILD = .TRUE.
          PART  = .TRUE.
 1050   CONTINUE
 1060 CONTINUE
C
C***  LATERAL STABILITY DERIVATIVES AND POWER EFFECTS
C
      CALL M29O35
      CALL M17O21
      IF(NF .LT. 0) GO TO 1080
      IF(PRPOWR) CALL M13O15
      IF(JETPOW) CALL M30O36
      CALL M49O61
C
C***  DYNAMIC STABILITY
C
      IF(.NOT. DAMP) GO TO 1070
        IG = 3
        CALL M51O63
        IF(WGPL) CALL M43O53
        IF(WGPL .OR. HTPL) CALL M45O55
        CALL M46O56
 1070 CONTINUE
C
C***  PRINT DATA, RETURN TO MAIN00
C
      CALL M12O14
 1080 CONTINUE
      RETURN
      END
