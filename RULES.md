# Rules — VAT pre-filing check

> Generated from the rule file of the engine; not edited by hand. Sources are Turkish legislation and
> Turkish-language commentary. Rules are for the demo; this is not tax advice. A Turkish tax advisor
> should review 🟡 and 🔵 rows first.

## Legislation and parameters

| Topic | Value | Legal basis | Status | Sources | Note |
|---|---|---|---|---|---|
| VAT rates | 1% · 10% · 20% (since 10 Jul 2023; before: 1% · 8% · 18%) | Presidential Decision 7346, Official Gazette 7 Jul 2023 / 32241 | ✅ verified | [pwc.com.tr](https://www.pwc.com.tr/tr/hizmetlerimiz/vergi/dolayli-vergi/bultenler/kdv-otv-bultenleri/2023/kdv-oranlarinda-degisiklik.html) · [alomaliye.com](https://www.alomaliye.com/2023/07/07/katma-deger-vergisi-oranlari-karar-sayisi-7346/) | — |
| Threshold for partial withholding | TRY 9,900 (2025) · TRY 12,000 (2026), VAT included; above it, on the full amount | VAT Implementation Communiqué I/C-2.1.3.4.1 → invoice threshold of Tax Procedure Law Art. 232 (communiqués 577 and 588) | ✅ verified | [gib.gov.tr](https://gib.gov.tr/node/80782/pdf) · [alomaliye.com](https://www.alomaliye.com/2025/12/31/vergi-usul-kanunu-genel-tebligi-sira-no-588/) · [pwc.com.tr](https://www.pwc.com.tr/tr/hizmetlerimiz/vergi/vergi-portali/pratik-bilgiler/hadler-ve-tutarlar/fatura-duzenleme-siniri.html) · [faturaport.com](https://faturaport.com/blog/vergi/tevkifat-siniri-2026-kdv-tevkifatinda-yeni-tutar-ve-uygulamasi) | The amounts agree across two sources. Applying it 'VAT included, full amount once exceeded' is from secondary sources. |
| Withholding 624: Freight transport services | 2/10 · buyer: VAT-registered taxpayers and designated buyers | VAT Implementation Communiqué I/C-2.1.3.2.11 | ✅ verified | [turmob.org.tr](https://www.turmob.org.tr/ebulten/mevzuatsirkuleri/2021/51-2021.pdf) · [lexpera.com.tr](https://www.lexpera.com.tr/mevzuat/ozelgeler/39044742-130-ozelge-958871-sayili-ozelge-1) · [mdpgroup.com](https://mdpgroup.com/blog/tevkifat-kodlari-nelerdir/) | Rate and buyer scope agree across two sources; the code (624) is from a secondary source only. Holders of a cargo-operator licence are excluded; the demo carriers hold none (assumption). |
| Withholding 627: Iron and steel products | 5/10 · buyer: VAT-registered taxpayers and designated buyers | VAT Implementation Communiqué I/C-2.1.3.3.8 | ✅ verified | [alomaliye.com](https://www.alomaliye.com/2022/05/23/demir-celik-mamul-yari-mamul-urunlerde-kdv-tevkifati/) · [muhasebetr.com](https://www.muhasebetr.com/yazarlarimiz/vedaterdem/0256) · [mdpgroup.com](https://mdpgroup.com/blog/tevkifat-kodlari-nelerdir/) | 5/10 since 1 Nov 2022 (4/10 before). Whether a product is on the list depends on its customs tariff code; in the demo, the steel vendors' products are assumed to be on it. The code (627) is from a secondary source only. |
| Withholding 603: Repair and maintenance of machinery, equipment, fixtures and vehicles | 7/10 · buyer: designated buyers only | VAT Implementation Communiqué I/C-2.1.3.2.3 | ✅ verified | [turmob.org.tr](https://www.turmob.org.tr/ebulten/mevzuatsirkuleri/2021/51-2021.pdf) · [ey.com](https://www.ey.com/tr_tr/insights/tax/kismi-kdv-tevkifati-hizmetler) · [mdpgroup.com](https://mdpgroup.com/blog/tevkifat-kodlari-nelerdir/) | Only when the buyer is a designated buyer (raised from 5/10 to 7/10 in 2021). Örnek Makine is not a designated buyer, so these invoices carry NO withholding — a trap. |
| Is Örnek Makine a designated buyer? | No: VAT-registered, not listed on the stock exchange, not a public body or bank | VAT Implementation Communiqué I/C-2.1.3.1 (b) | 🔵 assumption | [alomaliye.com](https://www.alomaliye.com/2022/09/19/kdv-tevkifatinda-guncel-uygulamalar/) · [ey.com](https://www.ey.com/tr_tr/insights/tax/kismi-kdv-tevkifati-hizmetler) | — |
| Deduction time limit | Until the end of the calendar year after the invoice year, in the period it is booked | VAT Law (KDVK) Art. 29/3 (Law 7104, 1 Jan 2019) | ✅ verified | [mevzuat.gov.tr](https://www.mevzuat.gov.tr/mevzuatmetin/1.5.3065.pdf) · [muhasebetr.com](https://www.muhasebetr.com/yazarlarimiz/ademkuruca/003) · [alomaliye.com](https://www.alomaliye.com/2025/08/15/indirilemeyecek-katma-deger-vergisi/) | — |
| Period of output VAT | The period of the taxable event (delivery; the invoice, if issued earlier) | VAT Law Art. 10 | ✅ verified | [mevzuat.gov.tr](https://www.mevzuat.gov.tr/mevzuatmetin/1.5.3065.pdf) | — |
| Filing deadlines | KDV1: 28th of the following month · KDV2: 25th of the following month | VAT Law Art. 41; Revenue Administration announcements | 🟡 secondary source | [alomaliye.com](https://www.alomaliye.com/2026/07/01/mali-tatilde-2-no-lu-kdv-odeme-suresi-ve-indirimine-dikkat/) · [alomaliye.com](https://www.alomaliye.com/2026/05/22/sorumlu-sifatiyla-odenen-2-no-lu-kdv-beyannamesine-iliskin-duyuru/) | VAT declared as the responsible party is deducted in KDV1 once paid; the demo assumes KDV2 is paid on time. |
| Export exemption | Exemption code 301 on the e-invoice (export of goods) | VAT Law Art. 11/1-a | 🟡 secondary source | [mevzuat.gov.tr](https://www.mevzuat.gov.tr/mevzuatmetin/1.5.3065.pdf) · [faturaport.com](https://faturaport.com/blog/e-fatura/e-faturada-kdv-oranina-gore-hangi-kod-secilmeli) | The code number is from a secondary source only; check against the current UBL-TR code list. |
| Ba-Bs forms | Abolished from the September 2024 period on; so there is no check for them | Tax Procedure Law Communiqué 565, Official Gazette 25 Sep 2024 / 32673 | ✅ verified | [gib.gov.tr](https://www.gib.gov.tr/sites/default/files/fileadmin/mevzuatek/mevzuatbilginotu/vukteblig565not.pdf) · [kpmgvergi.com](https://kpmgvergi.com/yayinlar/mali-bultenler/vergi/form-ba-ve-form-bs-uygulamasina-son-verilmesine-iliskin-vuk-tebligi-yayimlandi/2746) | — |

## Checks and finding types

| Check | Finding | Confidence | Type | Suggested fix | In SAP | Legal basis |
|---|---|---|---|---|---|---|
| K1 · e-Invoice ↔ ledger | At the tax authority, not in the ledger (sale) | Certain | Risk | Post the invoice; output VAT is added to the return. | FB70 / VF01 | VAT Law Art. 10 |
| K1 · e-Invoice ↔ ledger | At the tax authority, not in the ledger (purchase) | Certain | Opportunity | Post the invoice; the deduction can be claimed within the KDVK 29/3 time limit. | MIRO / FB60 | VAT Law Art. 29/3 |
| K1 · e-Invoice ↔ ledger | In the ledger, not at the tax authority | Certain | Risk | Verify the document; if it cannot be verified, remove it from the deduction. | FB03 → FB08 | VAT Law Arts. 29, 34 |
| K1 · e-Invoice ↔ ledger | e-Invoice and ledger amounts differ | Certain | Risk | Correct the posting to the e-invoice amount. | FB08 + FB60 | VAT Law Arts. 29, 34 |
| K1 · e-Invoice ↔ ledger | Rejected e-invoice in the ledger | Certain | Risk | Reverse the posting of the rejected invoice; its VAT is not deductible. | FB08 | VAT Law Art. 29 |
| K2 · Duplicate invoice | Same invoice posted twice | Certain | Risk | Reverse the extra posting. | FB08 | VAT Law Art. 29 |
| K2 · Duplicate invoice | Possible duplicate: number typed differently | Medium | Risk | Compare both postings; the one missing at the tax authority is most likely the extra. | FB03 → FB08 | VAT Law Art. 29 |
| K2 · Duplicate invoice | Same vendor, same amount, days apart | Weak signal | Risk | The vendor may have billed one delivery twice; check the delivery documents. | MIGO / FB03 | VAT Law Art. 29 |
| K3 · Rate and tax code | Invalid VAT rate (old tax code) | Certain | Risk | Correct the document with the current-rate tax code; block the old code. | FB08 + FTXP | Presidential Decision 7346 (10 Jul 2023) |
| K3 · Rate and tax code | VAT ≠ base × rate | Certain | Risk | Correct the tax line to base × rate. | FB08 + FB60 | VAT Law Arts. 28–29 |
| K3 · Rate and tax code | Export exemption on a domestic sale | Certain | Risk | Charge 20% VAT on the domestic sale; issue a corrective invoice. | VF01 + FB70 | VAT Law Art. 11/1-a |
| K4 · VAT withholding | Withholding not applied | Certain | Risk | Declare it on KDV2 as the responsible party; deduct it from the amount payable to the vendor. | FB60 + XK02 (LFBW) | VAT Law Art. 9; VAT Implementation Communiqué I/C-2.1.3 |
| K4 · VAT withholding | Wrong withholding rate | Certain | Risk | Recalculate the withholding at the right rate; correct KDV2. | FB08 + FB60 | VAT Implementation Communiqué I/C-2.1.3 |
| K4 · VAT withholding | Split to stay below the threshold | Medium | Risk | If they are parts of one job, apply withholding on the total. | FB60 | VAT Implementation Communiqué I/C-2.1.3.4.1 |
| K5 · Tax period | Sales invoice posted in a later month | Certain | Risk | Include it in the return for the invoice month (amended return if needed). | FB08 + FB70 | VAT Law Art. 10 |
| K5 · Tax period | Deduction time limit passed | Certain | Risk | Remove the VAT from the deduction; treat it as an expense. | FB08 | VAT Law Art. 29/3 |
| K6 · 191/391 ↔ tax lines | VAT posted without a tax code | Certain | Opportunity | Repost with a tax code; otherwise it does not reach the return. | FB08 + FB60 (MWSKZ) | S_ALR_87012357 reads only the tax lines (BSET) |

## Assumptions about the demo company

- Örnek Makine A.Ş. is VAT-registered and is not a designated buyer. Its tax number is fictitious.
- A vendor's withholding type is mapped from its industry key (LFA1.BRSCH, NACE): 4941 → 624, 2410 → 627, 3312 → 603.
- The steel vendors' products are assumed to be on the iron-and-steel withholding list; casting, bearing, motor, hydraulics and fastener vendors' products are assumed not to be. In reality this is decided by customs tariff code.
- VAT paid at customs on imports is outside this demo.
- Differences up to TRY 1.00 between the e-invoice and the ledger count as rounding.
