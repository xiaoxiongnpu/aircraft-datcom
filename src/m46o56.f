      SUBROUTINE M46O56
C
C***  EXEC FOR OVERLAY 46, WING-BODY-TAIL DYNAMIC DERIVS
C
      COMMON /CONSNT/ PI,DEG,UNUSED,RAD
      COMMON /FLGTCD/ FLC(93)
      COMMON /POWR/   DYN(213)
      COMMON /BDATA/  BD(300),DYNH(213)
      COMMON /IBODY/  PBODY,BODY(400)
      COMMON /IWING/  PWING,WING(400)
      COMMON /IBW/    PBW,BW(380)
      COMMON /IBH/    PBH,BH(380)
      COMMON /IBV/    PBV,BV(380)
      COMMON /IHT/    PHT,HT(380)
      COMMON /IVT/    PVT,VT(380)
      COMMON /IVF/    PVF,VF(380)
      COMMON /IBWV/   PBWV,BWV(380)
      COMMON /IBWH/   PBWH,BWH(380)
      COMMON /IBWHV/  PBWHV,BWHV(380)
      COMMON /IPOWER/ PPOWER,POWER(200)
      COMMON /IDWASH/ PDWASH,DWSH(60)
      COMMON /OVERLY/ NLOG,NMACH,I,NALPHA,IG,IJKDUM(3),NOVLY
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
      NOVLY=46
      IF(.NOT.BO)GO TO 1020
      CALL DYNBOD
      IF(HYPERS.AND.FLC(I+2).GT.1.4)GO TO 1020
      IF(WGPL)CALL DNPAWB
      IF(WGPL.AND.HTPL)GO TO 1000
      GO TO 1010
 1000 CALL DNPWBT
 1010 IF((VTPL .OR. VFPL).AND.SUBSON)CALL SUBWBT
 1020 CONTINUE
      IF(.NOT. HYPERS) CALL CLRDER
C
C   SET IOM WITH BLANKS SINCE ONLY FIRST POINT CALCULATED
C
      DO 1040 J=2,NALPHA
         BODY(J+200) = -UNUSED
         BODY(J+220) = -UNUSED
         BODY(J+240) = -UNUSED
         BODY(J+260) = -UNUSED
         BODY(J+280) = -UNUSED
         BODY(J+300) = -UNUSED
         BODY(J+320) = -UNUSED
         BODY(J+340) = -UNUSED
         HT(J+200) = -UNUSED
         HT(J+220) = -UNUSED
         IF(SUBSON) HT(J+300)=-UNUSED
         IF(SUBSON) HT(J+320)=-UNUSED
         IF(SUBSON) HT(J+340)=-UNUSED
         IF(TRANSN) HT(J+240) = -UNUSED
         IF(TRANSN) HT(J+260) = -UNUSED
         VT(J+200) = -UNUSED
         VT(J+220) = -UNUSED
         VT(J+240) = -UNUSED
         VT(J+260) = -UNUSED
         VF(J+200) = -UNUSED
         VF(J+220) = -UNUSED
         VF(J+240) = -UNUSED
         VF(J+260) = -UNUSED
         BW(J+200) = -UNUSED
         BW(J+220) = -UNUSED
         BW(J+240) = -UNUSED
         BW(J+260) = -UNUSED
         BWH(J+200) = -UNUSED
         BWH(J+220) = -UNUSED
         IF(TRANSN) BWH(J+240) = -UNUSED
         IF(TRANSN) BWH(J+260) = -UNUSED
         IF(HYPERS) GO TO 1030
         BH(J+200) = -UNUSED
         BH(J+220) = -UNUSED
         BH(J+240) = -UNUSED
         BH(J+260) = -UNUSED
         BV(J+200) = -UNUSED
         BV(J+220) = -UNUSED
         BV(J+240) = -UNUSED
         BV(J+260) = -UNUSED
         BH(J+300) = -UNUSED
         BH(J+320) = -UNUSED
         BH(J+340) = -UNUSED
         BV(J+280) = -UNUSED
         BV(J+300) = -UNUSED
         BV(J+320) = -UNUSED
         BV(J+340) = -UNUSED
 1030    BWHV(J+200) = -UNUSED
        BWHV(J+220) = -UNUSED
         IF(TRANSN) BWHV(J+240) = -UNUSED
         IF(TRANSN) BWHV(J+260) = -UNUSED
 1040 CONTINUE
      DO 1050 J=1,NALPHA
         BWH(J+300) = BW(J+300)
         BWH(J+320) = BW(J+320)
         BWH(J+340) = BW(J+340)
         IF((VTPL.OR.VFPL).AND.SUBSON)BWV(J+280) = BW(J+280)+VT(J+280)
     1                                             +VF(J+280)
         IF((VTPL.OR.VFPL).AND.SUBSON)BWHV(J+280) = BWH(J+280)+VT(J+280)
     1                                              +VF(J+280)
         BWV(J+200) = BW(J+200)
         BWV(J+220) = BW(J+220)
         BWV(J+240) = BW(J+240)
         BWV(J+260) = BW(J+260)
 1050 CONTINUE
      IF(DMPCSE .OR. DPDYN) CALL DMPARY(DYN,213,3HDYN,3)
      IF(DMPCSE .OR. DPDYNH) CALL DMPARY(DYNH,213,4HDYNH,4)
      IF(DPIBDY.OR.DPIWG.OR.DPIHT.OR.DPIVT.OR.DPIBW.OR.DPIBH.OR.
     1    DPIBV.OR.DPIBWH.OR.DPIBWV.OR.DPITOT.OR.DPIPWR.OR.DPIDWH)
     2    WRITE(6,1060)
      IF(DPIBDY) CALL DMPARY(BODY,400,4HBODY,4)
      IF(DPIWG)  CALL DMPARY(WING,400,4HWING,4)
      IF(DPIHT)  CALL DMPARY(HT,380,2HHT,2)
      IF(DPIVT)  CALL DMPARY(VT,380,2HVT,2)
      IF(DPIVF)  CALL DMPARY(VF,380,2HVF,2)
      IF(DPIBW)  CALL DMPARY(BW,380,2HBW,2)
      IF(DPIBH)  CALL DMPARY(BH,380,2HBH,2)
      IF(DPIBV)  CALL DMPARY(BV,380,2HBV,2)
      IF(DPIBWH) CALL DMPARY(BWH,380,3HBWH,3)
      IF(DPIBWV) CALL DMPARY(BWV,380,3HBWV,3)
      IF(DPITOT) CALL DMPARY(BWHV,380,4HBWHV,4)
      IF(DPIPWR) CALL DMPARY(POWER,200,4HPOWR,4)
      IF(DPIDWH) CALL DMPARY(DWSH,60,4HDWSH,4)
 1060 FORMAT(55H0**** THE FOLLOWING ARE IDEAL OUTPUT MATRIX ARRAYS ****)
      RETURN
      END
