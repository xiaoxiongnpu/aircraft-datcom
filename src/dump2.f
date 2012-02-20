      SUBROUTINE DUMP2
      COMMON /FLAPIN/ F(138)
      COMMON /POWR/   SPR(59),FLA(45),FLP(189),TRM(22)
      COMMON /SUPDW/  FHG(35),TCD(58)
      COMMON /SUPWH/  FCM(287)
      COMMON /IBODY/  PBODY,BODY(400)
      COMMON /IWING/  PWING,WING(400)
      COMMON /IHT/    PHT,HT(380)
      COMMON /IVT/    PVT,VT(380)
      COMMON /IBW/    PBW,BW(380)
      COMMON /IBH/    PBH,BH(380)
      COMMON /IBV/    PBV,BV(380)
      COMMON /IBWH/   PBWH,BWH(380)
      COMMON /IBWV/   PBWV,BWV(380)
      COMMON /IBWHV/  PBWHV,BWHV(380)
C
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD,KAND
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
      LOGICAL  DPBO,DPWG,DPHT,DPVT,DPBW,DPBH,DPBV,DPBWH,DPBWHV
C
      DIMENSION TRM2(22),TRN(7)
      EQUIVALENCE (TRM(1),TRM2(1),TRN(1))
      LOGICAL DUM(9)
      EQUIVALENCE (DUM(1),DPBO),(DUM(2),DPWG),(DUM(3),DPHT),
     1(DUM(4),DPVT),(DUM(5),DPBW),(DUM(6),DPBH),(DUM(7),DPBV),
     2(DUM(8),DPBWH),(DUM(9),DPBWHV)
      DO 1000 I=1,9
         DUM(I)=.FALSE.
 1000 CONTINUE
C
      IF(.NOT. DMPCSE) GO TO 1010
        DPF    = .TRUE.
        DPFLP  = DPFLP  .OR. ((SUBSON .OR. TRANSN) .AND. SYMFP)
        DPFHG  = DPFHG  .OR. (SUBSON .AND. (F(17) .EQ. 1.0))
        DPFCM  = DPFCM  .OR. (SUBSON .AND. SYMFP)
        DPTCD  = DPTCD  .OR. (SUBSON .AND. (F(17) .LE. 6.0 .AND.
     1                       F(17) .NE. UNUSED)) .OR.
     2                       (.NOT. SUPERS .AND. (F(18) .EQ. 5.0))
        DPFLA  = DPFLA  .OR. ((SUBSON .OR. TRANSN) .AND. ASYFP)
        DPTRM  = DPTRM  .OR. (TRIM .AND. SYMFP .AND. SUBSON)
        DPSPR  = DPSPR  .OR. (SUPERS .OR. HYPERS)
        DPTRN  = DPTRN  .OR. TRANSN
        DPTRM2 = DPTRM2 .OR. (SUBSON .AND. TRIM .AND. HTPL .AND.
     1                       .NOT. (SYMFP .OR. ASYFP))
        DPBO   = SUBSON .OR. (TRANSN .AND. ASYFP) .OR.
     1                       (SUPERS .AND. F(18) .EQ. 4.0)
        DPWG   = SUBSON .OR. TRANSN .OR. ((SUPERS .OR. HYPERS)
     1                       .AND. (SYMFP .OR. F(18) .EQ. 5.0))
        DPHT   = (TRIM .AND. SUBSON) .OR. ASYFP
        DPVT   = (TRIM .AND. SUBSON)
        DPBW   = CTAB
        DPBH   = CTAB
        DPBV   = CTAB
        DPBWH  = CTAB
        DPBWHV = CTAB
 1010 CONTINUE
      IF(DPF)    CALL DMPARY(F,138,1HF,1)
      IF(DPFCM)  CALL DMPARY(FCM,287,3HFCM,3)
      IF(DPFHG)  CALL DMPARY(FHG,35,3HFHG,3)
      IF(DPFLA)  CALL DMPARY(FLA,45,3HFLA,3)
      IF(DPFLP)  CALL DMPARY(FLP,189,3HFLP,3)
      IF(DPSPR)  CALL DMPARY(SPR,59,3HSPR,3)
      IF(DPTCD)  CALL DMPARY(TCD,58,3HTCD,3)
      IF(DPTRM)  CALL DMPARY(TRM,22,3HTRM,3)
      IF(DPTRM2) CALL DMPARY(TRM2,22,4HTRM2,4)
      IF(DPTRN)  CALL DMPARY(TRN,7,3HTRN,3)
C
      IF(DPBO .OR. DPWG .OR. DPHT .OR. DPVT .OR. DPBW .OR.
     1   DPBH .OR. DPBV .OR. DPBWH .OR. DPBWHV) WRITE(6,1020)
C
      IF(DPBO)   CALL DMPARY(BODY(201),200,4HBODY,4)
      IF(DPWG)   CALL DMPARY(WING(201),200,4HWING,4)
      IF(DPHT)   CALL DMPARY(HT(201)  ,180,2HHT  ,2)
      IF(DPVT)   CALL DMPARY(VT(201)  ,180,2HVT  ,2)
      IF(DPBW)   CALL DMPARY(BW(201)  ,180,2HBW  ,2)
      IF(DPBH)   CALL DMPARY(BH(201)  ,180,2HBH  ,2)
      IF(DPBV)   CALL DMPARY(BV(201)  ,180,2HBV  ,2)
      IF(DPBWH)  CALL DMPARY(BWH(201) ,180,3HBWH ,3)
      IF(DPBWHV) CALL DMPARY(BWHV(201),180,4HBWHV,4)
      RETURN
 1020 FORMAT(55H0**** THE FOLLOWING ARE IDEAL OUTPUT MATRIX ARRAYS ****)
      END
