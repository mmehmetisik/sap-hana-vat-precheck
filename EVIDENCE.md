# Evidence

Every number in the README is listed here with the command that produced it. A number without a command
is not published. Commands run from the project root with the virtual environment active and
`PYTHONPATH=.;02-vergi`. For legal facts, the "command" column holds the source.

**Development vs. exam.** The rules were developed on seeds 101, 102 and 103. The README uses only the
numbers of the exam seed. Development numbers are kept here for the record.

The engine's source code is not in this repository; the commands document how each number was produced.

## Legislation and setup

| Date | Claim | Command / source | Result |
|---|---|---|---|
| 2026-11-22 | The Ba-Bs forms no longer exist; dropped from the planned checks | Tax Procedure Law Communiqué 565, Official Gazette 25 Sep 2024 / 32673 · [Revenue Administration note](https://www.gib.gov.tr/sites/default/files/fileadmin/mevzuatek/mevzuatbilginotu/vukteblig565not.pdf) | No Form Ba / Bs from the September 2024 period on |
| 2026-11-22 | Rules in one file, with sources | `python -m vergi kurallar` → `RULES.md` | 11 legislation rows: 8 verified, 2 secondary source, 1 assumption · 17 finding types |
| 2026-11-22 | The tax data is derived from the ledger of Part 1, which stays unchanged | `python -m uretim.temel` (SHA-256 check) · `python -m pytest -q` (project root) | Shared data SHA-256 `32f564f6…6e471` (same as Part 1) · Part 1 and shared tests: 33 passed |
| 2026-11-22 | Clean tax data | `python -m uretim.temel` | 1.7 s · BKPF 13,963 · BSEG 39,689 · BSET 13,936 · WITH_ITEM 881 (invoices with withholding) · e-invoice register 12,847 (9,246 outgoing, 3,601 incoming) · LFBW 8 vendors |
| 2026-11-22 | Separate schema; the reader cannot write | `python -m uretim.yukle` | Schema VERGI · row counts match · unbalanced documents 0 · reader `DELETE FROM BKPF` → `insufficient privilege` |

## Development seeds (not used in the README)

| Date | Claim | Command | Result |
|---|---|---|---|
| 2026-11-22 | The answer key is consistent | `python -m uretim.kortest --tohum 101` / `102` / `103` | In every seed, 12 periods × 3 return lines: the effects in the key add up to the difference between the two sets of books, to the kuruş |
| 2026-11-22 | SQL return = Python return | same, internal check | 3 seeds × 12 periods × 3 lines, 0 mismatches |
| 2026-11-22 | Blind test on development seeds | same | Found 455/455 · certain 500/500 · medium 43/91 (47.3%) · weak 39/111 (35.1%) · false alarms 120 (119 on traps, 1 on a clean entry) · ~0.15 s per period |
| 2026-11-22 | Tests (development data) | `cd 02-vergi` · `..\.venv\Scripts\python -m pytest -q` | 41 passed (23.0 s): 13 rules find the right document in a small example · no certain alarm on traps or on 4 clean periods · the checks do not see the future · the engine does not import the generator package · the key is not in HANA · every finding drills down to a document |
| 2026-11-22 | The tests really measure | A rule was reverted temporarily, its test was run, the file was restored (SHA-256 compared) | Designated-buyer condition removed → `test_bakim_onarimda_tevkifat_istenmez` RED · incoming invoice searched only in its own month → `test_tuzaklara_alarm_yok` RED · E16 fix reverted → `test_anahtar_…[103]` RED · restored: green, files identical |
| 2026-11-22 | API speed | `TestClient(vergi.api.app)` · `POST /api/donem/202610/hesapla` | 12 periods checked at start-up in 3.1 s · recalculation after a tick ~5 ms (15 ms in the browser) |

## Exam (numbers used in the README)

All tests were green before the exam (this project: 41 · Part 1 and shared: 33). The exam seed ran once.
SHA-256 of the engine files at that moment (first 12 characters): `kontroller.sql 31cd62d74a7f` ·
`sema_vergi.sql 3dca051d634f` · `kontrol.py 165f12595ae9` · `beyanname.py 723c30a30d70` ·
`kurallar.py 58793cdb40d6` · `veri.py 51adaf537d0b`.

| Date | Claim | Command | Result |
|---|---|---|---|
| 2026-11-22 | Hidden errors and traps | `python -m uretim.kortest --tohum 20261122 --sinav` | 12 returns (Nov 2025 – Oct 2026) · 151 errors, 16 types · 889 traps (146 planted; 743 natural: 274 machinery-repair invoices, 457 imports, 12 VAT offset entries) · key consistent: 12 periods × 3 lines exact |
| 2026-11-22 | Errors found | same | **151/151** (every type in full) · 230 findings |
| 2026-11-22 | The "certain" label | same | **164/164 right** · 0 certain alarms on traps and clean entries |
| 2026-11-22 | What each label says vs. measured | same (stated values come from the development seeds, fixed in the rule file before the exam) | Certain 100% → 100% (164/164) · medium 47% → 60% (18/30) · weak 35% → 33.3% (12/36) |
| 2026-11-22 | False alarms | same | 36, all on traps (two real orders of the same amount 24, two small freight jobs on one day 10, small invoice under the threshold 2) · 0 on clean entries |
| 2026-11-22 | Size of the hidden errors | same | TRY 5,419,205.04 in total; share of the found ones 100% |
| 2026-11-22 | Error in the return (12 periods, distance to the true return over output VAT + input VAT + KDV2) | same | As booked **TRY 2,640,480.46** → with the certain fixes **TRY 553,106.02** (−79%) · certain + medium 553,206.10 · weak signals applied blindly too 1,035,577.52 |
| 2026-11-22 | A check on totals only | same | Only **48.7%** of the error volume shows in the totals (net 2,640,480 / gross 5,419,205) · March 2026: outgoing e-invoices ↔ 391 differ by 0.45%, incoming ↔ 191 by 0.44% (looks reconciled), with TRY 334,185 of errors inside |
| 2026-11-22 | SQL return = Python return | same, internal check | 12 periods × 3 lines, 0 mismatches |
| 2026-11-22 | Check speed (warm) | `kontrol.bulgular(...)` for 12 periods, exam data loaded | Six checks per period: median 0.085 s · max 0.120 s (first call with compilation 3.6 s) |
| 2026-11-22 | October 2026 decision (on screen) | `kontrol.karar(kontrol.bulgular(v, "202610"))` | Do not file · 10 certain risks · 5 to review · 5 opportunities · 20 findings |
| 2026-11-22 | October 2026 return: as booked → with the certain fixes | `GET /api/donem/202610` | VAT payable TRY 2,914,911.02 → 3,170,864.69 (+255,953.67) · KDV2 TRY 539,809.77 → 542,970.91 (+3,161.14) |
| 2026-11-22 | Tests with the exam data | `cd 02-vergi` · `..\.venv\Scripts\python -m pytest -q` | 41 passed (23.8 s) |
| 2026-11-22 | Exam data set (in HANA) | `wc -l` on the exam CSVs | BKPF 14,065 · BSEG and ACDOCA 39,978 · BSET 14,026 · WITH_ITEM 869 · e-invoice register 12,967 · 80 customers · 41 vendors (8 with withholding) · 10 tax codes · Aug 2024 – Nov 2026 (28 months) |
| 2026-11-22 | Screenshots are not edited | `powershell -File 02-vergi/vitrin/ekran_al.ps1` | 5 PNGs at 2880 px width from the running app's URLs, with a clean browser profile each time · a scrolled page rendered blank in the headless browser on the first try, so a `?odak=` focus view was added instead of scrolling |

## Intermediate results (before a fix, for the record)

| Change | Before | After |
|---|---|---|
| Document number collision in the error generator (E16) | On seed 103 the key did not match: Jan 2026 input VAT −54,453.57 ≠ −51,640.37 · KDV2 9,977.78 ≠ 10,540.42 (in the true books a freight invoice took another document's number and overwrote it) | The document is now copied, with an `assert` against collisions · exact on all 3 seeds |
| Generator speed | 52.2 s (a DataFrame per document) | 1.7 s (lines grouped in dictionaries) |
