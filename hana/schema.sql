-- Glossary of Turkish identifiers
--   Tables : GIB_EBELGE e-invoice register at the tax authority · KURAL_ORAN valid VAT rates ·
--            KURAL_ESKI_ORAN old rate → new rate · KURAL_SINIR withholding threshold by year ·
--            KURAL_TEVKIFAT withholding types · KURAL_PARAMETRE check parameters · SIRKET_VERGI company tax profile
--   Columns: BELGE_NO invoice no. · YON direction (GIDEN outgoing, GELEN incoming) · BELGE_TURU document type ·
--            SENARYO profile · TIP type · DURUM status · GONDEREN sender · ALICI receiver (in KURAL_TEVKIFAT: buyer scope) ·
--            UNVAN name · BELGE_TARIHI invoice date · PARA currency · MATRAH tax base · KDV_ORANI VAT rate ·
--            KDV_TUTARI VAT amount · TEVKIFAT withholding · ISTISNA_KODU exemption code · GECERLI_BAS valid from ·
--            ORAN rate · YIL year · SINIR_KDV_DAHIL threshold incl. VAT · AD name · PAY/PAYDA numerator/denominator ·
--            BOLUM communiqué section · DEGER value · VKN tax number · KDV_MUKELLEFI VAT-registered ·
--            BELIRLENMIS_ALICI designated buyer
--   Results: KURAL rule · GUVEN confidence · TUR type · MUHATAP counterparty · KAYIT_TARIHI posting date ·
--            ETKI_* correction · DEFTER ledger · GIB tax authority · DETAY detail · HES output VAT · IND input VAT ·
--            TEV withholding · KODSUZ without a tax code · MAHSUP VAT offset entry · ULKE country · DONEM period ·
--            HESAPLANAN output VAT · INDIRILECEK input VAT · SORUMLU VAT declared as responsible party (KDV2) ·
--            BEYANNAME return · FARK difference · LT_ / LV_ local table / local variable
--   Functions: TF_BELGELER documents · TF_K1_EBELGE e-invoice ↔ ledger · TF_K2_MUKERRER duplicates ·
--            TF_K3_ORAN rate · TF_K4_TEVKIFAT withholding · TF_K5_DONEM period · TF_K6_KODSUZ no tax code ·
--            TF_KONTROLLER all checks · TF_BEYANNAME_AYLIK monthly return · TF_MUTABAKAT reconciliation ·
--            TF_TOPLAM_KONTROLU totals-only check
--
-- Örnek Makine A.Ş. — VAT return pre-filing check, schema VERGI.
-- SAP tables keep SAP's field names; the GIB_* and KURAL_* tables are not SAP tables:
--   GIB_EBELGE : e-invoices and e-archive invoices at the tax authority (from the integrator or the authority)
--   KURAL_*    : the rule book; loaded from the engine's rule file, never edited by hand
-- Dates are NVARCHAR(8) 'YYYYMMDD', as in SAP. A period is 'YYYYMM'.
-- Statements are separated by a "-- @@" line (SQLScript bodies contain ';').

CREATE COLUMN TABLE T001 (
  MANDT NVARCHAR(3), BUKRS NVARCHAR(4), BUTXT NVARCHAR(25), ORT01 NVARCHAR(25),
  LAND1 NVARCHAR(3), WAERS NVARCHAR(5), KTOPL NVARCHAR(4), SPRAS NVARCHAR(1),
  PRIMARY KEY (MANDT, BUKRS))
-- @@
CREATE COLUMN TABLE SKAT (
  MANDT NVARCHAR(3), SPRAS NVARCHAR(1), KTOPL NVARCHAR(4), SAKNR NVARCHAR(10),
  TXT20 NVARCHAR(20), TXT50 NVARCHAR(50),
  PRIMARY KEY (MANDT, SPRAS, KTOPL, SAKNR))
-- @@
-- STCD2: tax number (VKN). Which field holds it depends on country settings; in this demo, STCD2.
CREATE COLUMN TABLE KNA1 (
  MANDT NVARCHAR(3), KUNNR NVARCHAR(10), NAME1 NVARCHAR(35), ORT01 NVARCHAR(35), LAND1 NVARCHAR(3),
  STCD2 NVARCHAR(11),
  PRIMARY KEY (MANDT, KUNNR))
-- @@
-- BRSCH: industry key; in this demo a 4-digit NACE code. The withholding type is mapped from it.
CREATE COLUMN TABLE LFA1 (
  MANDT NVARCHAR(3), LIFNR NVARCHAR(10), NAME1 NVARCHAR(35), ORT01 NVARCHAR(35), LAND1 NVARCHAR(3),
  STCD2 NVARCHAR(11), BRSCH NVARCHAR(4),
  PRIMARY KEY (MANDT, LIFNR))
-- @@
-- Vendor withholding settings (master data). A missing entry is a typical cause of missing withholding.
CREATE COLUMN TABLE LFBW (
  MANDT NVARCHAR(3), LIFNR NVARCHAR(10), BUKRS NVARCHAR(4), WITHT NVARCHAR(2), WT_WITHCD NVARCHAR(2),
  WT_SUBJCT NVARCHAR(1),
  PRIMARY KEY (MANDT, LIFNR, BUKRS, WITHT))
-- @@
-- Tax codes (tax procedure TAXTR). MWART: A = output tax, V = input tax.
CREATE COLUMN TABLE T007A (
  KALSM NVARCHAR(6), MWSKZ NVARCHAR(2), MWART NVARCHAR(1),
  PRIMARY KEY (KALSM, MWSKZ))
-- @@
CREATE COLUMN TABLE T007S (
  SPRAS NVARCHAR(1), KALSM NVARCHAR(6), MWSKZ NVARCHAR(2), TEXT1 NVARCHAR(50),
  PRIMARY KEY (SPRAS, KALSM, MWSKZ))
-- @@
-- The rate of a tax code comes from its condition record, as in SAP: A003 → KONP.
-- KONP.KBETR holds percentage conditions in per mille: 20% = 200.
CREATE COLUMN TABLE A003 (
  MANDT NVARCHAR(3), KAPPL NVARCHAR(2), KSCHL NVARCHAR(4), ALAND NVARCHAR(3), MWSKZ NVARCHAR(2),
  KNUMH NVARCHAR(10),
  PRIMARY KEY (MANDT, KAPPL, KSCHL, ALAND, MWSKZ))
-- @@
CREATE COLUMN TABLE KONP (
  MANDT NVARCHAR(3), KNUMH NVARCHAR(10), KOPOS NVARCHAR(2), KSCHL NVARCHAR(4), KBETR DECIMAL(11,2),
  KONWA NVARCHAR(5),
  PRIMARY KEY (MANDT, KNUMH, KOPOS))
-- @@
CREATE COLUMN TABLE BKPF (
  MANDT NVARCHAR(3), BUKRS NVARCHAR(4), BELNR NVARCHAR(10), GJAHR NVARCHAR(4), BLART NVARCHAR(2),
  BLDAT NVARCHAR(8), BUDAT NVARCHAR(8), XBLNR NVARCHAR(16), WAERS NVARCHAR(5), BKTXT NVARCHAR(25),
  PRIMARY KEY (MANDT, BUKRS, BELNR, GJAHR))
-- @@
CREATE COLUMN TABLE BSEG (
  MANDT NVARCHAR(3), BUKRS NVARCHAR(4), BELNR NVARCHAR(10), GJAHR NVARCHAR(4), BUZEI NVARCHAR(3),
  BSCHL NVARCHAR(2), KOART NVARCHAR(1), SHKZG NVARCHAR(1), DMBTR DECIMAL(23,2), WRBTR DECIMAL(23,2),
  HKONT NVARCHAR(10), KUNNR NVARCHAR(10), LIFNR NVARCHAR(10), MWSKZ NVARCHAR(2), SGTXT NVARCHAR(50),
  PRIMARY KEY (MANDT, BUKRS, BELNR, GJAHR, BUZEI))
-- @@
-- Tax lines: SAP's advance VAT return (S_ALR_87012357) reads the return from this table.
-- KTOSL: MWS = output tax, VST = input tax. HWBAS = tax base, HWSTE = tax (TRY).
CREATE COLUMN TABLE BSET (
  MANDT NVARCHAR(3), BUKRS NVARCHAR(4), BELNR NVARCHAR(10), GJAHR NVARCHAR(4), BUZEI NVARCHAR(3),
  MWSKZ NVARCHAR(2), HKONT NVARCHAR(10), SHKZG NVARCHAR(1), HWBAS DECIMAL(23,2), FWBAS DECIMAL(23,2),
  HWSTE DECIMAL(23,2), FWSTE DECIMAL(23,2), KTOSL NVARCHAR(3), KSCHL NVARCHAR(4),
  PRIMARY KEY (MANDT, BUKRS, BELNR, GJAHR, BUZEI))
-- @@
-- VAT withholding (extended withholding tax). The base is the VAT amount; WT_QBSHH is the VAT declared on KDV2.
CREATE COLUMN TABLE WITH_ITEM (
  MANDT NVARCHAR(3), BUKRS NVARCHAR(4), BELNR NVARCHAR(10), GJAHR NVARCHAR(4), BUZEI NVARCHAR(3),
  WITHT NVARCHAR(2), WT_WITHCD NVARCHAR(2), WT_QSSHH DECIMAL(23,2), WT_QBSHH DECIMAL(23,2),
  PRIMARY KEY (MANDT, BUKRS, BELNR, GJAHR, BUZEI, WITHT))
-- @@
CREATE COLUMN TABLE ACDOCA (
  RCLNT NVARCHAR(3), RLDNR NVARCHAR(2), RBUKRS NVARCHAR(4), GJAHR NVARCHAR(4), BELNR NVARCHAR(10),
  DOCLN NVARCHAR(6), BUDAT NVARCHAR(8), BLDAT NVARCHAR(8), BLART NVARCHAR(2), RACCT NVARCHAR(10),
  DRCRK NVARCHAR(1), RWCUR NVARCHAR(5), WSL DECIMAL(23,2), RHCUR NVARCHAR(5), HSL DECIMAL(23,2),
  KUNNR NVARCHAR(10), LIFNR NVARCHAR(10), MWSKZ NVARCHAR(2),
  PRIMARY KEY (RCLNT, RLDNR, RBUKRS, GJAHR, BELNR, DOCLN))
-- @@
-- Tax authority side: incoming and outgoing e-invoices / e-archive. Amounts in TRY; document currency kept too.
-- DURUM (status): GECERLI valid | RED rejected by the buyer (commercial profile) | IPTAL cancelled.
CREATE COLUMN TABLE GIB_EBELGE (
  ETTN NVARCHAR(36), BELGE_NO NVARCHAR(16), YON NVARCHAR(5), BELGE_TURU NVARCHAR(7),
  SENARYO NVARCHAR(12), TIP NVARCHAR(10), DURUM NVARCHAR(7),
  GONDEREN_VKN NVARCHAR(11), GONDEREN_UNVAN NVARCHAR(35), ALICI_VKN NVARCHAR(11), ALICI_UNVAN NVARCHAR(35),
  BELGE_TARIHI NVARCHAR(8), PARA NVARCHAR(5), MATRAH_BELGE DECIMAL(23,2), MATRAH DECIMAL(23,2),
  KDV_ORANI DECIMAL(5,2), KDV_TUTARI DECIMAL(23,2), TEVKIFAT_KODU NVARCHAR(3), TEVKIFAT_TUTARI DECIMAL(23,2),
  ISTISNA_KODU NVARCHAR(3),
  PRIMARY KEY (ETTN))
-- @@
CREATE COLUMN TABLE KURAL_ORAN (
  GECERLI_BAS NVARCHAR(8), ORAN DECIMAL(5,2),
  PRIMARY KEY (GECERLI_BAS, ORAN))
-- @@
CREATE COLUMN TABLE KURAL_SINIR (
  YIL NVARCHAR(4), SINIR_KDV_DAHIL DECIMAL(23,2),
  PRIMARY KEY (YIL))
-- @@
-- Withholding types: e-invoice code, SAP withholding code (WT_WITHCD), rate, buyer scope, vendor industry (NACE).
CREATE COLUMN TABLE KURAL_TEVKIFAT (
  TEVKIFAT_KODU NVARCHAR(3), WT_WITHCD NVARCHAR(2), AD NVARCHAR(80), PAY INTEGER, PAYDA INTEGER,
  ALICI NVARCHAR(20), BOLUM NVARCHAR(20), NACE NVARCHAR(4),
  PRIMARY KEY (TEVKIFAT_KODU, NACE))
-- @@
CREATE COLUMN TABLE SIRKET_VERGI (
  BUKRS NVARCHAR(4), VKN NVARCHAR(11), KDV_MUKELLEFI NVARCHAR(1), BELIRLENMIS_ALICI NVARCHAR(1),
  PRIMARY KEY (BUKRS))
-- @@
-- The rate that replaced an old rate (10 Jul 2023): used for the suggested correction.
CREATE COLUMN TABLE KURAL_ESKI_ORAN (
  ESKI_ORAN DECIMAL(5,2), YENI_ORAN DECIMAL(5,2),
  PRIMARY KEY (ESKI_ORAN))
-- @@
-- Check parameters: tolerance (TRY), duplicate window (days), deduction time limit (years) ...
CREATE COLUMN TABLE KURAL_PARAMETRE (
  AD NVARCHAR(30), DEGER DECIMAL(23,2),
  PRIMARY KEY (AD))
