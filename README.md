# FSAE Motor Thermals historical study inputs

This repository preserves a 2025 MATLAB motor-efficiency and endurance study. It contains endurance speed/time inputs, hand-digitized Emrax efficiency points, fitted lookup tables, VTC6 hand-plot data, and exploratory scripts. It is not a validated motor thermal model or a gear-ratio qualification.

## Source and derived data

`Inputs/Base Data/05172025 - 1 endurance.daq` is the preserved DAQ file. CSV exports, back-calculated torque/power, added-loss variants and fitted efficiency tables are derived study inputs; their names do not establish calibration or acceptance. `Old attempt/` retains historical alternatives.

`Inputs/2025EnduranecTimeAndSpeed50hz.csv` (Git blob `c4e3c23e697b9502b7b9d8acb2fc76266cac02b8`) and `Inputs/MoreWasteful2025EntireEdur.csv` (Git blob `13e9f8b9bcbad4f0c8e23312e1a4ab7720c9d41e`) were also vendored into the battery study's `battery_1r_model.py` data directory. That script identifies the team's SharePoint Emrax inputs as provenance and computes battery demand and cooling separately. This does not mean its battery model validates these motor-efficiency fits or endorses gear-ratio results. Other battery thermal projects are separate models.

## Running the historical scripts

Inspect paths before running: MATLAB scripts contain absolute `C:\Matlab\...` inputs and output folders, and the fit uses MATLAB's `fit` function. Redirect outputs to your own workspace. No portable runtime or automated MATLAB verification is supplied here. The `poly33` lookup generator evaluates a rectangular grid, including extrapolated regions; efficiency bounds and operating-domain validity require separate review.

Unpublished recovery snapshots may contain additional workbook variants and gear-ratio scripts. Recovery history preserves those alternatives without accepting their rankings. In the September 2026 snapshot, both added scoring scripts assume `dt = 0.02`, while the named torque input has predominantly 0.1-second intervals and irregular gaps; over-rev points are removed before computing losses, and map coordinates are clamped. Labels such as SAFE, CORRECTED, FINAL, or optimal are exploratory software labels, not physical safety or thermal acceptance.

The [preserved recovery snapshot](https://github.com/russlib/FSAE-Motor-Thermals/tree/439e722d36ebdc074c313b5d40f325cf6bf3e150) contains all seven workbook alternatives, both additional MATLAB live scripts and the expanded CSV. Its exact recovery tag is `branch-retired-20260929/backup-20260926/laptop-trjdifeu-485c67303460/worktree`; archival preserves these variants without integrating them into this historical baseline.
