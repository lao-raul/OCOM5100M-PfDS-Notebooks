# OCOM5100M Summative Assessment 2 — Current Plan

> Status date: 15 October 2026
>
> Submission deadline: 26 October 2026, 14:00 UTC / 22:00 China Standard Time
>
> Working notebook: `P4DS_A2_Data_Analysis_Project.ipynb`

## 1. Purpose and academic-integrity boundary

This is a private working plan. It records the latest status only and is not text to paste into the assessed notebook.

The student's final code, preprocessing/model decisions, interpretations and reflections must be their own. Permitted AI support includes planning, explaining concepts, debugging student-written code and proofreading student-written prose. AI must not generate submission code, choose the final preprocessing/model strategy for the student, or write the assessed analytical discussion.

## 2. Current status

| Area | Status | Evidence / next action |
|---|---|---|
| Part 1, Section 1.1 | **Content complete** | Approximately 480 words; aim, objectives, metadata, provenance, scope, quality and limitations are present. |
| Part 1, Section 1.2 | **Content complete** | Approximately 581 words; code runs and stays below the 600-word commentary limit. |
| Part 1, Section 1.3 | **Content complete** | Objective 1 approximately 303 words; Objective 2 approximately 320 words; both have figures, exact values and sensitivity checks. |
| Part 1, Section 1.4 | **Content complete** | Approximately 248 words; findings, unexpected result, checking and limitations are present. |
| Part 1 code limit | **Pass at current state** | Sections 1.2 and 1.3 contain 242 non-empty code lines, below the 250-line maximum. Do not add Part 1 code unless other lines are removed. |
| Part 1 final QA | **Pending** | Perform the final clean run only after Part 2 is complete, then recheck all quoted values and figures. |
| Part 2 dataset loading | **Minimal start only** | The CSV is read into `df`, but there is no displayed audit or interpretation yet. |
| Sections 2.1–2.5 | **Not started** | Template comments/placeholders remain; no preprocessing pipeline, models, CV, tuning or test evaluation exists. |
| Process Log | **Not started** | Begin recording genuine attempts, problems and decisions now. |

## 3. Non-negotiable limits and requirements

- Part 2 is a binary classification pipeline using the module-provided `employee_churn_dataset.csv`.
- Section 2.1: preprocessing pipeline plus approximately 200–250 words.
- Section 2.2: two complete baseline classification pipelines plus approximately 100–150 words.
- Section 2.3: cross-validation for both pipelines, at least one metric beyond accuracy, and mean plus standard deviation across folds; reflection approximately 200–250 words.
- Section 2.4: tune one selected full pipeline, report the best configuration, compare with baseline CV; reflection approximately 200–250 words.
- Section 2.5: evaluate once on the held-out test set, report precision, recall and F1, display a confusion matrix with labelled axes, and compare with CV; justification approximately 250–300 words.
- Process Log: no more than 400 words.
- Whole notebook: no more than 600 code lines and 3,800 markdown words.
- Keep all supplied blue headings, remove all instructional text/placeholders, save visible outputs, and submit the exact required filename.

## 4. Current word and code budget

### Completed Part 1 markdown

| Section | Current approximate words | Limit/status |
|---|---:|---|
| 1.1 | 480 | Within 400–500 |
| 1.2 | 581 | Within maximum 600 |
| 1.3 Objective 1 | 303 | Within 250–325 |
| 1.3 Objective 2 | 320 | Within 250–325 |
| 1.4 | 248 | Within 200–250; do not expand |

Completed Part 1 assessed prose is approximately 1,972 words. Preserve a buffer because headings, labels and the final counter may count tokens differently.

### Code budget

- Sections 1.2 + 1.3: 242 non-empty lines; hard maximum 250.
- Current fixed code outside unfinished Part 2 includes approximately 242 Part 1 lines plus 23 lines in the supplied word-count cell.
- Approximate remaining whole-notebook capacity before reaching 600 lines: 335 lines.
- Target Part 2 implementation: approximately 220–270 readable non-empty lines, leaving a safety margin.
- Replace template comments rather than keeping them beside the final code.

### Part 2 writing targets

| Section | Required range | Working target |
|---|---:|---:|
| 2.1 | 200–250 | 215–235 |
| 2.2 | 100–150 | 115–135 |
| 2.3 | 200–250 | 215–235 |
| 2.4 | 200–250 | 215–235 |
| 2.5 | 250–300 | 265–285 |
| Process Log | Maximum 400 | 350–390 |

Using the midpoint of these targets should keep the complete notebook below 3,800 words.

## 5. Verified Part 2 dataset facts

These facts were checked directly from `employee_churn_dataset.csv`. Reproduce the relevant evidence in the notebook before relying on it in a reflection.

### Structure and target

- 1,020 rows and 14 columns.
- Target: `churned`.
- Target counts: 641 `Stayed` (62.8%) and 379 `Churned` (37.2%).
- The imbalance is moderate rather than extreme, but accuracy alone could still hide class-specific errors.
- Treat `Churned` as the operational positive class unless the student defines and justifies another convention.

### Missing values

| Column | Missing rows |
|---|---:|
| `age` | 41 |
| `satisfaction_score` | 63 |
| `contract_type` | 20 |
| `education_level` | 25 |
| `performance_rating` | 30 |

All other columns are complete in the raw file.

### Duplicate and category issues

- 20 complete duplicate rows.
- `employee_id` has 1,000 unique values across 1,020 rows; the 20 duplicated IDs correspond to the exact duplicate records.
- `department` contains case and whitespace variants, including `HR `, `FINANCE`, `marketing`, `Sales ` and `engineering`.
- These variants must be normalised consistently before encoding.

### Numerical ranges that require review

| Feature | Observed range / median |
|---|---|
| `age` | 17–95; median 35 |
| `years_at_company` | 0–28.6; median 2.7 |
| `salary` | 17,896–229,604; median 42,041.5 |
| `satisfaction_score` | 1–5; median 3.5 |
| `engagement_index` | 11.63–83.77; median 50.60 |

Do not automatically delete unusual ages or salaries. Inspect their context and decide whether they are plausible, errors or values that should be retained with robust preprocessing.

### Feature-role and leakage questions

- `employee_id`: identifier-like and unlikely to generalise; decide whether it should be excluded from predictors.
- `favourite_colour`: no clear workplace mechanism; decide whether retaining it risks learning noise or spurious patterns.
- `exit_interview_completed`: a serious timing/leakage concern. Among `yes` records, 297 are `Churned` and 34 `Stayed`; among `no` records, 82 are `Churned` and 607 `Stayed`. Decide whether this field would be available at the intended prediction time.
- The intended prediction moment must be stated before deciding which features are legitimate.

## 6. Part 2 end-to-end logic

The required workflow is:

1. Audit the raw dataset.
2. Define the prediction target and prediction moment.
3. Resolve exact duplicates and feature eligibility.
4. Create a held-out train/test split.
5. Build learned preprocessing inside a scikit-learn pipeline fitted on training data only.
6. Train two complete baseline pipelines.
7. Compare both pipelines using the same cross-validation folds and metrics.
8. Select one model from that evidence.
9. Tune only that full pipeline using training data.
10. Lock all development decisions.
11. Evaluate the final pipeline once on the held-out test set.
12. Interpret errors, generalisation and fitness for purpose.

The held-out test set must not be used to choose preprocessing, features, models, metrics or hyperparameters.

## 7. Dataset loading and exploration

The current loading cell only reads the CSV. Expand the exploration enough to support Section 2.1 decisions without turning it into an unfocused EDA section.

### Required audit tasks

- [ ] Load the data using a Part 2-specific variable name rather than the generic `df` if this improves clarity.
- [ ] Display shape, column names, data types and a small sample.
- [ ] Display target counts and percentages.
- [ ] Display missing counts and percentages.
- [ ] Check exact duplicates and duplicate `employee_id` values.
- [ ] Inspect unique levels for every categorical column.
- [ ] Show the `department` spelling/case/whitespace problem.
- [ ] Summarise numerical features and inspect implausible/extreme values.
- [ ] Use a small number of target-related summaries only where they inform a feature or metric decision.
- [ ] Add a concise markdown interpretation connecting each issue to Section 2.1.

### Avoid

- Do not inspect the future test set repeatedly after splitting.
- Do not add numerous unrelated charts.
- Do not transform the complete dataset with learned imputers, encoders or scalers before the split.
- Do not let test performance determine feature eligibility.

## 8. Section 2.1 — Preprocessing and Pipelines (10 marks)

This is the highest-mark Part 2 section. Its purpose is to produce one reproducible, leakage-safe preprocessing design that all later models use.

### Step 1 — define the prediction task

- [ ] State what `Churned` and `Stayed` mean.
- [ ] Define when the prediction would be made, for example before an employee leaves and while an intervention is still possible.
- [ ] Define the positive class consistently for scoring and the confusion matrix.
- [ ] Explain the practical cost of false negatives and false positives before choosing a primary metric.

### Step 2 — resolve rows before splitting

**Student decision: exact duplicates**

- Confirm that the 20 duplicates are complete-row duplicates.
- Consider the leakage risk if identical rows enter different folds or train/test partitions.
- Decide whether to remove them before splitting and justify the choice.
- Record the resulting row count.

Do not treat repeated categories or similar employees as duplicates; only the verified identical records support this decision.

### Step 3 — decide which features are eligible

Create a compact feature-role table in planning notes:

| Role | Candidate columns / question |
|---|---|
| Target | `churned` |
| Identifier | Is `employee_id` useful or merely a row identifier? |
| Numerical predictors | `age`, `years_at_company`, `salary`, `satisfaction_score`, `engagement_index` |
| Categorical predictors | `department`, `contract_type`, `education_level`, `performance_rating`, `remote_work_level` |
| Questionable relevance | Is `favourite_colour` defensible for this prediction task? |
| Possible post-outcome leakage | Would `exit_interview_completed` be known at prediction time? |

For every excluded feature, state a domain/timing reason. Do not exclude or retain it solely because it changes validation performance.

### Step 4 — create the hold-out split

- [ ] Separate `X` and `y` explicitly.
- [ ] Choose and justify a test-set fraction.
- [ ] Use a fixed random state for reproducibility.
- [ ] Preserve target proportions where appropriate.
- [ ] Print train/test shapes and target proportions as a validation check.
- [ ] Do not fit preprocessing before this split.

### Step 5 — deterministic data cleaning

- [ ] Normalise `department` whitespace and case consistently.
- [ ] Decide whether this deterministic cleaning occurs before the split or through a pipeline-compatible transformation; explain why it cannot learn information from the target.
- [ ] Recheck that the cleaned department levels are the intended five departments.
- [ ] Do not silently change other categories unless the audit shows a specific inconsistency.

### Step 6 — build column-specific preprocessing

**Numerical branch**

- Decide how to impute `age` and `satisfaction_score` using training data only.
- Decide whether scaling is needed for the selected candidate models.
- Consider outlier sensitivity and skew when choosing an imputation/scaling approach.

**Categorical branch**

- Decide how to impute missing `contract_type`, `education_level` and `performance_rating`.
- Encode categories in a way that can handle unseen test categories.
- Avoid imposing an arbitrary numeric order unless a variable is genuinely ordinal and the ordering is justified.

**Combined preprocessor**

- [ ] Use a `ColumnTransformer` or equivalent scikit-learn structure.
- [ ] Ensure learned preprocessing is fitted separately inside each CV training fold.
- [ ] Check that transformed train data has the expected number of rows and no unintended missing values.
- [ ] Keep the preprocessing reusable by both baseline classifiers.

### Step 7 — write the 200–250-word reflection

The student-written reflection should explain:

1. the prediction moment and leakage boundary;
2. duplicate handling and excluded/retained questionable features;
3. numerical and categorical missing-value treatment;
4. category cleaning and encoding;
5. whether scaling is required and why;
6. how the pipeline prevents leakage;
7. one reasonable alternative and its trade-off.

Do not merely list transformer names. Connect every decision to an observed feature of this dataset.

## 9. Section 2.2 — Baseline Model Training (4 marks)

Train two meaningfully different classifiers as complete pipelines.

### Student model-selection gate

- Choose two algorithms taught or otherwise permitted by the module.
- The pair should provide an informative contrast, such as a linear/parametric approach versus a nonlinear tree-based approach.
- Consider interpretability, scaling requirements, nonlinear relationships, overfitting risk and the small dataset size.
- Do not choose two near-identical algorithms merely to satisfy the number requirement.

### Implementation checklist

- [ ] Clone/reuse the same logical preprocessor for both models.
- [ ] Each object passed to fitting/CV must be a complete `Pipeline` containing preprocessing and classifier.
- [ ] Start with genuine baseline/default or clearly baseline settings; tuning belongs in Section 2.4.
- [ ] Fit only on training data.
- [ ] Use clear model names consistently in later tables.

### 100–150-word rationale

Explain:

- why each classifier is plausible for mixed employee data;
- how their assumptions and flexibility differ;
- what comparison the two baselines provide;
- model-specific preprocessing needs or risks.

Do not claim one is better before seeing cross-validation results.

## 10. Section 2.3 — Cross-Validation (6 marks)

The purpose is to compare generalisation on training data without touching the final test set.

### Evaluation design

- [ ] Choose an appropriate stratified cross-validation strategy and justify the number of folds.
- [ ] Use the same folds and scoring definitions for both pipelines.
- [ ] Report accuracy plus at least one additional metric.
- [ ] Select a primary metric based on the consequence of missing a true churner versus incorrectly flagging a stayer.
- [ ] Keep `Churned` as the positive class consistently.
- [ ] Report mean and standard deviation across folds for every comparison metric.
- [ ] Present both models in one compact comparison table.

Possible metrics to evaluate include precision, recall, F1 and ROC AUC. The student must choose which metric drives selection and justify it from the churn context rather than choosing the highest-looking score.

### Interpretation questions

- Which model has the stronger mean on the primary metric?
- Is the difference large relative to fold-to-fold standard deviation?
- Does one model trade recall for precision?
- Is accuracy consistent with class-specific metrics?
- Which model appears more stable?
- Is the evidence strong enough to select a model, or are the results practically tied?

### 200–250-word reflection

Compare performance and stability, quote exact mean and standard deviation values, state which model proceeds to tuning, and link that choice to the task's error costs.

## 11. Section 2.4 — Hyperparameter Tuning (6 marks)

Tune only the model selected from Section 2.3.

### Search design

- [ ] Apply the search to the full pipeline, not to preprocessed arrays or the classifier alone.
- [ ] Use training data only.
- [ ] Use the same primary scoring metric chosen in Section 2.3 unless a change is explicitly justified.
- [ ] Choose a compact search space linked to the selected algorithm's behaviour.
- [ ] Use a reproducible search strategy.
- [ ] Avoid a large search grid that is not justified by dataset size or computation time.
- [ ] Report the best pipeline parameters and best mean CV score.
- [ ] Retain enough information to compare the tuned model with its own baseline CV result.

### Interpretation questions

- How large is the improvement in the primary metric?
- Is that improvement larger than baseline fold variability?
- Did another important metric worsen?
- Does the best configuration imply simpler or more complex behaviour?
- Could a small gain reflect tuning to the CV folds rather than a meaningful improvement?

### 200–250-word reflection

Justify the tuned parameters and scoring choice, compare the best CV result directly with the matching baseline, and judge practical meaning rather than merely reporting a higher number.

## 12. Section 2.5 — Final Model Evaluation and Justification (6 marks)

This is the first and only stage where the held-out test set should influence reported final performance.

### Final evaluation tasks

- [ ] Lock preprocessing, feature set, primary metric and hyperparameters before test evaluation.
- [ ] Use the selected tuned full pipeline as the final model.
- [ ] Generate test predictions once after development decisions are complete.
- [ ] Report accuracy, precision, recall and F1 with the positive class stated.
- [ ] Include class-level results where useful.
- [ ] Display a confusion matrix with clearly labelled actual and predicted axes.
- [ ] Identify TN, FP, FN and TP correctly.
- [ ] Compare the test metric with baseline CV and tuned CV mean/standard deviation.
- [ ] Discuss the size and direction of the CV-to-test difference.
- [ ] Interpret false negatives and false positives in the employee-retention context.
- [ ] Give a proportionate fit-for-purpose recommendation.
- [ ] Identify specific next steps tied to observed errors or data limitations.

### Fit-for-purpose decision

Do not reduce the recommendation to “the score is high.” Address:

- whether recall/precision are adequate for the intended use;
- whether the model would support human review rather than automatic employment decisions;
- the risk of post-outcome leakage or spurious variables;
- the small, synthetic or non-representative nature of the dataset if applicable;
- whether additional data, threshold selection, probability calibration or fairness checks would be needed before deployment.

### 250–300-word justification

Use exact test and CV values, interpret the confusion-matrix errors, assess generalisation, and make a balanced recommendation with limitations and next steps.

## 13. Process Log (12 marks)

Start a private diary during Part 2 rather than reconstructing it at the end.

For each attempt, record:

| Date | Section | What was tried | Output/evidence | Why it failed or surprised | What changed next |
|---|---|---|---|---|---|

The final log must be no more than 400 words and include:

- at least two genuine dead ends across Parts 1 and 2;
- what the output showed and what was learned from each;
- one surprising finding with a specific value;
- one improvement that would be made with more time, grounded in the submitted results.

Possible events may be logged only if they genuinely occurred, such as a feature that produced suspiciously high CV performance, a preprocessing approach that failed, a model that was unstable, or tuning that produced negligible improvement. Do not invent failures retrospectively.

## 14. Recommended execution order

### Phase A — Part 2 audit and decisions

- [ ] Expand dataset loading and exploration.
- [ ] Define prediction time and positive class.
- [ ] Resolve duplicates and feature eligibility.
- [ ] Record the first Process Log entries.

### Phase B — Section 2.1

- [ ] Split the data leakage-safely.
- [ ] Build and validate the reusable preprocessor.
- [ ] Write the 200–250-word reflection from actual decisions.

### Phase C — Sections 2.2 and 2.3

- [ ] Build two complete baseline pipelines.
- [ ] Cross-validate both with identical folds and metrics.
- [ ] Select one model using evidence and task priorities.
- [ ] Write both reflections.

### Phase D — Sections 2.4 and 2.5

- [ ] Tune the selected full pipeline using training data only.
- [ ] Lock development decisions.
- [ ] Evaluate once on the held-out test set.
- [ ] Write the tuning and final-evaluation reflections.

### Phase E — submission QA

- [ ] Complete the Process Log and AI acknowledgement.
- [ ] Remove every placeholder and instructional paragraph.
- [ ] Preserve all blue headings.
- [ ] Recheck every word and code limit.
- [ ] Restart the kernel and run all cells from top to bottom.
- [ ] Confirm every table and figure is visible and every quoted value matches output.
- [ ] Confirm Student ID and exact filename.
- [ ] Save a backup and upload before the deadline.

## 15. Part 2 completion gate

Part 2 is complete only when:

- [ ] The test set was separated before learned preprocessing and remained untouched until Section 2.5.
- [ ] Every imputer, encoder, scaler and model is fitted through a complete pipeline.
- [ ] Feature inclusion/exclusion is justified by prediction timing and relevance.
- [ ] Two meaningfully different baseline pipelines are evaluated with the same CV design.
- [ ] CV results include accuracy, an additional metric, and mean plus standard deviation.
- [ ] One model is selected from CV evidence and only that model is tuned.
- [ ] Tuning searches the full pipeline using training data only.
- [ ] Final test evaluation includes precision, recall, F1 and a labelled confusion matrix.
- [ ] Test performance is compared with CV performance.
- [ ] Every reflection quotes actual results and remains within its word range.
- [ ] No placeholder text remains.
- [ ] The complete notebook stays below 600 code lines and 3,800 markdown words.
