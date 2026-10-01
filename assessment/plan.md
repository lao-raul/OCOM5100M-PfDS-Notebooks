# OCOM5100M Summative Assessment 2 - Detailed Plan and Task List

> Last updated: 27 September 2026  
> Submission deadline: 26 October 2026, 14:00 UTC / 22:00 China Standard Time  
> Working notebook: `P4DS_A2_Data_Analysis_Project.ipynb`

## 1. Purpose of this file

This is a private working plan, not text to paste into the assessed notebook. It separates:

1. **Requirements from the assessment documents** - compulsory instructions that must be followed.
2. **Project planning decisions already made** - the selected topic, period and geographical scope.
3. **Provisional analysis options and decision gates** - choices that must be confirmed from the student's own outputs and justified in the student's own words.

The final code, analytical decisions, interpretations and written reflections must be the student's own work. Keep copies of drafts, AI prompts and AI outputs, and include an AI acknowledgement in the final notebook.

---

## 2. Source documents and current files

### Assessment documents

- `Summative Assessment 2- Data Analysis Project Brief.pdf` - authoritative requirements, limits and submission rules.
- `OCOM5100M_Summative Assessment 2 Student Rubric.pdf` - criteria for Basic, Good and Excellent work.
- `OCOM5100M Data Analysis Project Topics.pdf` - suggested topics only; it is not an additional submission requirement.
- `OCOM5100M Data Analysis Project Topics.docx` - editable version of the suggested topics.

### Working files

- `P4DS_A2_Data_Analysis_Project.ipynb` - required submission template and exact final filename.
- `employee_churn_dataset.csv` - fixed dataset for Part 2.
- `plan.md` - this planning file; do not submit unless the module team explicitly asks for it.
- Part 1 CSV - still needs to be downloaded and stored locally with a clear, stable filename.

### Part 1 public sources

- Kaggle dataset: <https://www.kaggle.com/datasets/debayank2024/ai-impact-on-jobs-and-salaries-2020-2026>
  Downloaded in assessment/ai_jobs_salaries_clean.csv
- Underlying open salary repository: <https://github.com/foorilla/ai-jobs-net-salaries>

Before writing Section 1.1, record the exact downloaded filename, Kaggle version/update date, download date, row and column counts, licence and the relationship between the Kaggle file and the underlying source.

---

## 3. Non-negotiable assessment requirements

### Overall marks and limits

| Component | Marks | Main requirement |
|---|---:|---|
| Part 1: Data Analysis Project | 32 | Own public dataset and exploratory analysis |
| Part 2: Machine Learning Pipeline | 32 | Fixed employee churn dataset |
| Process Log | 12 | Maximum 400 words |
| Report Quality | 4 | Complete, coherent, polished notebook |
| **Total** | **80** | Worth 80% of the module grade |

- Maximum **600 code lines** across Parts 1 and 2.
- Maximum **3,800 markdown words** across Parts 1, 2 and the Process Log.
- Sections 1.2 and 1.3 together must not exceed **250 non-empty code lines**.
- Section 1.2 commentary must not exceed **600 words**.
- The limits are ceilings, not targets. Concise and relevant work is preferred.
- Part 1 may use core Python, pandas, NumPy and a visualisation library. Do **not** use scikit-learn in Part 1, except to load a built-in dataset, which is not relevant to this project.
- Part 2 must use scikit-learn pipelines and the fixed `employee_churn_dataset.csv`.

### Notebook and submission rules

- Keep every main blue heading exactly as supplied. Do not delete or rename it.
- Remove all placeholder and instructional text before submission.
- Enter the Student ID in the designated cell.
- Run `Kernel -> Restart & Run All` and confirm that every cell completes without errors.
- Keep all required outputs and figures visible in the saved notebook.
- Submit only `P4DS_A2_Data_Analysis_Project.ipynb`, unless explicitly instructed otherwise.
- Use the exact filename `P4DS_A2_Data_Analysis_Project.ipynb`.
- Aim to upload by 25 October to preserve a one-day safety margin.

### AI and academic-integrity boundary

Permitted support includes explaining concepts, debugging code written by the student, and proofreading text drafted by the student. AI must not:

- generate notebook code for submission;
- write or substantially rewrite analytical prose or reflections;
- make preprocessing, model or hyperparameter decisions on the student's behalf;
- produce content submitted as evidence of the student's understanding.

Therefore, this plan provides tasks, questions and validation gates. For every gate marked **Student decision**, inspect the actual output, choose the approach yourself, record the evidence, and explain the reasoning in your own words.

---

## 4. Chosen Part 1 project scope

### Topic decision

Use the Kaggle dataset **AI Impact on Jobs & Salaries (2020-2026)**, but do not repeat its title as a causal claim. The data describes salary records for AI, machine-learning, data-science and related roles; it does not directly measure job displacement, unemployment or the causal effect of AI on the labour market.

### Working project framing

- **Population of interest:** records for employees working for US-based companies.
- **Time period:** 2023-2025, subject to verifying the downloaded data.
- **Main outcome:** `salary_in_usd`.
- **Main explanatory dimensions:** experience level, work year and work arrangement.
- **Geographical filter:** use `company_location == "US"` for the main analysis.
- **Reason for the US restriction:** US records dominate the dataset, while many other countries have small and unequal samples. Restricting the scope reduces cross-country wage, labour-market and cost-of-living differences, but conclusions will not generalise beyond this dataset's US-company records.

### Important scope wording

Use cautious language such as:

- “records in this dataset for US-based companies”;
- “was associated with” or “differed across groups”;
- “the observed median/proportion”.

Avoid claims such as:

- “AI caused salaries to increase”;
- “remote work increased salary”;
- “the dataset represents all US AI workers”;
- “2026 results”, unless verified 2026 observations actually exist;
- “AI replaced jobs”, because there is no displacement or unemployment measure.

### Provisional title, aim and objectives

These are planning skeletons only. Verify feasibility through the student's own EDA and write the final wording independently.

**Provisional title direction**

Recent salary patterns and working arrangements in US AI, machine-learning and data roles, 2023-2025

**Provisional aim direction**

Examine recent salary patterns and working arrangements among AI/ML/data professionals employed by US-based companies between 2023 and 2025.

**Provisional Objective 1 direction**

Quantify and compare the distribution of `salary_in_usd` across experience levels and work years in the filtered US sample, using group sizes, medians and spread.

**Provisional Objective 2 direction**

Measure how work-mode composition changes from 2023 to 2025 and examine salary differences between work modes while accounting for experience-level composition.

### Objective feasibility gate

Before finalising the objectives, confirm all of the following:

- [ ] Each year from 2023 to 2025 is present after filtering to `company_location == "US"`.
- [ ] Each experience level used in comparisons has a defensible sample size.
- [ ] `remote_ratio` values and the meaning of any derived `work_mode` field are documented and internally consistent.
- [ ] The proposed comparisons can be answered with available variables.
- [ ] Each objective can be supported by at least one clear visualisation and one quoted numerical result.
- [ ] Neither objective uses causal language.

If an objective fails these checks, revise its scope before producing final figures.

---

## 5. Part 1 execution plan

## 5.1 Data acquisition and provenance

- [ ] Download the chosen CSV from Kaggle without changing the raw file.
- [ ] Save a working copy under a short, descriptive filename if necessary; keep the raw download separately during development.
- [ ] Record the dataset version, update date, download date, licence and URL.
- [ ] Check whether the Kaggle data is a filtered or enriched copy of the `foorilla/ai-jobs-net-salaries` source.
- [ ] Identify which columns are original and which are uploader-derived, especially label, work-mode, outlier or role-family fields.
- [ ] Record how the original salary records were collected. Note that self-reported or platform-collected records may contain selection and reporting bias.
- [ ] Verify the actual year range. If the local data ends in 2025, describe it as 2023-2025 rather than relying on “2020-2026” in the Kaggle title.

**Deliverable:** a provenance note containing exact facts for Section 1.1, with links saved for citation.

## 5.2 Initial data audit

Perform the following checks before filtering or cleaning:

- [ ] Print dataset shape and column names.
- [ ] Inspect a small number of rows and the data types.
- [ ] Produce counts and percentages of missing values.
- [ ] Check complete-row duplicates and plausible duplicate salary records.
- [ ] Check unique categories and spelling/case consistency.
- [ ] Count observations by year, company location, employee residence, experience level, employment type, remote ratio and company size.
- [ ] Summarise `salary_in_usd` with count, minimum, quartiles, median, mean and maximum.
- [ ] Inspect the salary distribution and identify extreme values without automatically deleting them.
- [ ] Verify whether `salary_outlier_flag`, `work_mode` and `role_family` are derived variables and whether their derivation is sufficiently documented.

**Required notebook behaviour:** after each purposeful code block, add a short markdown interpretation explaining what the output shows and how it affects the next analytical step.

## 5.3 Define the analytical sample

Apply the intended scope transparently and report how many rows remain after each major filter:

1. Start with the full dataset.
2. Keep `work_year` in 2023, 2024 and 2025.
3. Keep `company_location == "US"`.
4. Retain rows with a valid `salary_in_usd` for salary analysis.
5. Review employment type and other group sizes before deciding whether additional restrictions are necessary.

### Student decision: employment type

- Compare counts for full-time, part-time, contract and freelance records.
- Decide whether to analyse all employment types, restrict to full-time, or retain all but stratify/flag them.
- Base the decision on comparability and sample size, not convenience.
- Record the choice and its consequence for generalisability.

### Student decision: extreme salaries

- Examine suspected outliers in context by role, experience, year and employment type.
- Do not remove valid high salaries only because they are large.
- If exclusions are considered, define the rule before viewing the preferred result and run a sensitivity comparison with and without the affected observations.
- Report the effect of the choice on the relevant median/mean or visualisation.

### Student decision: geography definition

- Main plan: `company_location == "US"` because the intended topic is the US employment market.
- Separately check the overlap with `employee_residence == "US"`.
- If cross-border remote records are material, disclose them or run a sensitivity check rather than silently changing the definition.

**Deliverable:** a compact sample-flow table showing the row count after each restriction.

## 5.4 Section 1.1 - Project Aim and Data Description (10 marks)

**Required length:** approximately 400-500 words.  
**Planning target:** 430-470 words.

Include, in the student's own wording:

- [ ] A precise project aim.
- [ ] Two specific, measurable and achievable objectives.
- [ ] Dataset name, source URL, original source and licence.
- [ ] Collection method and time coverage.
- [ ] Exact rows and columns in the downloaded version.
- [ ] Main variables needed for the objectives.
- [ ] Why the analysis focuses on 2023-2025 and US-based companies.
- [ ] Data-quality evidence from the student's audit: missingness, duplicates, category issues, imbalance and outliers.
- [ ] Reliability limitations: self-selection/reporting, unequal yearly coverage, dominance of US records, possible uploader-derived labels, and lack of population weights.
- [ ] Why the data is still suitable for descriptive EDA.
- [ ] A clear boundary that the study describes associations in this dataset and does not estimate causal AI impact.

**Excellent-level check:** the provenance, contents, structure, limitations and fitness for purpose are evaluated critically, not merely listed.

## 5.5 Section 1.2 - Exploratory Data Analysis and Code (12 marks)

**Hard limits:** Sections 1.2 and 1.3 combined <=250 non-empty code lines; Section 1.2 commentary <=600 words.  
**Planning target:** 130-170 Part 1 code lines before final trimming and 350-500 words of Section 1.2 commentary.

Suggested workflow order:

1. Imports and display settings.
2. Load the Part 1 CSV.
3. Inspect shape, columns, rows and types.
4. Audit missing values and duplicates.
5. Audit year, geography and category distributions.
6. Validate or create only the derived fields needed for the objectives.
7. Apply the documented analytical-sample filters.
8. Show filtered sample sizes and group coverage.
9. Examine salary distribution and potential outliers.
10. Produce reusable summary tables needed by Section 1.3.

Code-quality checklist:

- [ ] Use descriptive variable names rather than generic names such as `df1` or `x`.
- [ ] Organise code into purposeful blocks; do not repeat the same grouping logic unnecessarily.
- [ ] Write comments that explain why a step is performed, not comments that restate syntax.
- [ ] Keep the workflow reproducible from the raw CSV.
- [ ] Avoid unused imports, abandoned code and irrelevant charts.
- [ ] Do not use scikit-learn anywhere in Part 1.
- [ ] Ensure every displayed output contributes to a later decision or finding.
- [ ] Follow each code block with a concise interpretation linked to the next step.

## 5.6 Section 1.3 - Objective 1 Analysis (6 marks shared across both objectives)

**Required length:** approximately 250-325 words for the objective, plus visualisation.  
**Planning target:** 270-300 words.

Analytical tasks:

- [ ] Report group counts so salary comparisons are not separated from sample size.
- [ ] Calculate median salary and an appropriate measure of spread for each experience level.
- [ ] Check whether the result differs materially by year.
- [ ] Compare mean and median to identify skew, but avoid filling the notebook with redundant statistics.
- [ ] Select a visualisation that shows both the centre and distribution, not only a single average.
- [ ] Check that labels, units, ordering and title identify the US sample and 2023-2025 period.

Evidence checklist for the student's interpretation:

- [ ] Quote at least one exact value visible in the figure or accompanying output.
- [ ] Interpret the value in the context of AI/ML/data salaries.
- [ ] Discuss group size, spread and overlap, not only which group is highest.
- [ ] Consider alternative explanations such as role composition, company size or unequal yearly samples.
- [ ] Use association/descriptive language rather than causality.
- [ ] State whether the objective was answered and how strongly the evidence supports the answer.

## 5.7 Section 1.3 - Objective 2 Analysis

**Required length:** approximately 250-325 words for the objective, plus visualisation.  
**Planning target:** 270-300 words.

Analytical tasks:

- [ ] Validate the mapping between `remote_ratio` and onsite/hybrid/remote labels.
- [ ] Calculate counts and within-year percentages for each work mode.
- [ ] Compare work-mode composition across 2023, 2024 and 2025.
- [ ] Calculate salary summaries by work mode.
- [ ] Check work-mode salary comparisons within experience levels to reduce composition bias.
- [ ] Decide whether one figure or two compact, complementary figures communicate the objective most clearly.

Evidence checklist for the student's interpretation:

- [ ] Quote at least one exact percentage or salary statistic shown in the output.
- [ ] Explain whether the work-mode mix changed across years.
- [ ] Explain whether the unadjusted salary comparison changes after considering experience level.
- [ ] Discuss sample-size imbalance and possible confounding.
- [ ] Do not claim that work mode caused a salary difference.
- [ ] State whether the objective was answered and what uncertainty remains.

## 5.8 Section 1.4 - Part 1 Insights and Reflections (4 marks)

**Required length:** approximately 200-250 words.  
**Planning target:** 215-235 words.

Write a concise synthesis, not a repetition of both objective sections:

- [ ] Prioritise two or three main findings and reference the most important numbers.
- [ ] Identify one genuinely unexpected observation from the outputs.
- [ ] Explain why it was unexpected and whether further checking changed the interpretation.
- [ ] Discuss the most consequential limitations: sampling/self-reporting, unequal year coverage, restricted geography, group imbalance, derived categories, outliers and uncontrolled confounding.
- [ ] Explain what the findings can and cannot support.
- [ ] Avoid introducing new analysis that was not shown earlier.

---

## 6. Part 2 dataset status and execution plan

## 6.1 Verified starting point

The fixed dataset currently contains:

- 1,020 rows and 14 columns.
- Target: `churned`, with 641 `Stayed` and 379 `Churned` records.
- 20 complete duplicate rows.
- Missing values in `age` (41), `satisfaction_score` (63), `contract_type` (20), `education_level` (25) and `performance_rating` (30).
- Inconsistent department labels, including case and trailing-space variants.
- Numerical, categorical and binary-like fields.
- Fields requiring explicit relevance or leakage review: `employee_id`, `favourite_colour` and `exit_interview_completed`.

These observations are planning facts only. Reproduce and display the relevant checks in the notebook before using them in any justification.

## 6.2 Dataset loading and exploration

- [ ] Load `employee_churn_dataset.csv` using a dedicated name such as `churn_data`, rather than reusing the Part 1 dataframe name.
- [ ] Confirm shape, columns, data types, target classes, missingness and duplicates.
- [ ] Standardise string whitespace/case only after showing the issue.
- [ ] Examine numerical ranges and categorical levels for invalid or implausible values.
- [ ] Calculate target count and proportion.
- [ ] Examine candidate predictors against the target only to understand the data, not to use the held-out test set for repeated decision-making.
- [ ] Create a short feature-role table: identifier, numerical predictor, categorical predictor, possible irrelevant feature, possible post-outcome feature, and target.

## 6.3 Leakage-safe data split

- [ ] Define features and target explicitly.
- [ ] Decide how to handle exact duplicate rows and justify the timing of removal.
- [ ] Create a held-out test set before fitting imputers, encoders, scalers or models.
- [ ] Preserve target class proportions where appropriate and set a reproducible random state.
- [ ] Keep the test set untouched until Section 2.5.
- [ ] Fit all learned preprocessing only inside the training pipeline.

### Student decision: feature inclusion

For each questionable variable, answer in writing before modelling:

- `employee_id`: does it carry generalisable information or only identify rows?
- `favourite_colour`: is there a plausible task-related reason to retain it, or would apparent association be spurious?
- `exit_interview_completed`: would this information be available at the intended prediction time, or is it a post-churn/procedural leakage risk?

Do not let model performance alone determine inclusion. Define the prediction moment and feature availability first.

## 6.4 Section 2.1 - Preprocessing and Pipelines (10 marks)

**Required length:** approximately 200-250 words.  
**Planning target:** 215-235 words.

- [ ] Separate numerical and categorical feature lists.
- [ ] Choose missing-value treatments based on the observed distributions and meaning of each feature.
- [ ] Correct known category formatting issues inside a reproducible workflow where possible.
- [ ] Choose an encoding method appropriate to the categorical variables and intended models.
- [ ] Decide whether numerical scaling is required for each candidate model.
- [ ] Use a `ColumnTransformer` or equivalent pipeline structure.
- [ ] Ensure the same fitted preprocessing is used during cross-validation, tuning and final prediction.
- [ ] Confirm transformed output has the expected rows and no unintended missing values.

Reflection questions:

- What evidence in the data supports each preprocessing choice?
- How does the pipeline prevent leakage?
- Which reasonable alternatives were considered, and what trade-off led to the student's final choice?
- What limitations remain after preprocessing?

## 6.5 Section 2.2 - Baseline Model Training (4 marks)

**Required length:** approximately 100-150 words.  
**Planning target:** 115-135 words.

- [ ] Select two valid, meaningfully different classification algorithms.
- [ ] Build each as a complete pipeline containing the shared or appropriate preprocessor.
- [ ] Use default or clearly baseline settings initially; do not tune here.
- [ ] Explain how the algorithms differ in assumptions, flexibility and interpretability.
- [ ] Explain why both provide an informative comparison for this dataset.

**Student decision:** choose the classifiers from course material based on understanding of their behaviour and the dataset. The final rationale must be the student's own, not copied from this plan or an AI response.

## 6.6 Section 2.3 - Cross-Validation (6 marks)

**Required length:** approximately 200-250 words.  
**Planning target:** 215-235 words.

- [ ] Apply the same cross-validation strategy to both complete pipelines.
- [ ] Keep the held-out test set out of cross-validation.
- [ ] Report accuracy plus at least one metric beyond accuracy.
- [ ] Report mean and standard deviation across folds for every comparison metric used.
- [ ] Present the two models in one compact comparison table.
- [ ] Compare central performance and fold-to-fold stability.
- [ ] Select one model for tuning using evidence and task priorities.

### Student decision: primary metric

Define the practical meaning of false negatives and false positives for employee churn. Use that reasoning, target balance and the observed results to choose the primary metric. Do not select a metric only because it gives the largest score.

## 6.7 Section 2.4 - Hyperparameter Tuning (6 marks)

**Required length:** approximately 200-250 words.  
**Planning target:** 215-235 words.

- [ ] Tune only the model selected from the cross-validation evidence.
- [ ] Search parameters on the complete pipeline, not on a separately preprocessed dataset.
- [ ] Use training data only; keep the held-out test set untouched.
- [ ] Choose a compact, interpretable search space linked to model behaviour.
- [ ] Use the primary metric selected in Section 2.3 unless a change is explicitly justified.
- [ ] Report the best configuration and best cross-validation result.
- [ ] Compare tuned performance directly with the matching baseline mean and variability.
- [ ] Judge whether improvement is meaningful, not merely numerically positive.
- [ ] Consider diminishing returns and possible overfitting to cross-validation folds.

## 6.8 Section 2.5 - Final Model Evaluation and Justification (6 marks)

**Required length:** approximately 250-300 words.  
**Planning target:** 265-285 words.

- [ ] Refit the selected final pipeline on the permitted training data.
- [ ] Evaluate exactly once on the held-out test set after development decisions are complete.
- [ ] Report precision, recall and F1, plus any other justified metric.
- [ ] Display a confusion matrix with clear class labels and labelled axes.
- [ ] State which class is treated as positive.
- [ ] Compare test performance with baseline and tuned cross-validation results.
- [ ] Interpret false positives and false negatives in the churn context.
- [ ] Evaluate generalisation using the size and direction of the CV-test difference.
- [ ] Give a proportionate fit-for-purpose recommendation.
- [ ] Identify specific next steps linked to observed errors or data limitations.

---

## 7. Process Log plan (12 marks)

**Hard limit:** no more than 400 words.  
**Template expectation:** approximately 350-400 words.  
**Planning target:** 360-390 words.

Maintain a private process diary during development. For every attempt, record:

| Date | Part/section | What was tried | Evidence/output | Why it failed or surprised | What changed next |
|---|---|---|---|---|---|
| | | | | | |

The final Process Log must include:

- [ ] At least two genuine dead ends: one from Part 1 and one from Part 2.
- [ ] For each dead end, what was attempted, what output showed the problem, what was learned and what changed.
- [ ] One surprising finding with a specific number or output.
- [ ] Why the finding was surprising and how it was checked.
- [ ] One focused, feasible change that would be made with more time.
- [ ] A direct link between that future change and the submitted results.

Do not invent dead ends retrospectively. Capture screenshots, output values or brief notes while working so the log is specific and credible.

---

## 8. Word and code budget

| Section | Required/maximum | Working target |
|---|---:|---:|
| 1.1 Aim and dataset | 400-500 words | 430-470 |
| 1.2 EDA commentary | Maximum 600 words | 350-500 |
| 1.3 Objective 1 | 250-325 words | 270-300 |
| 1.3 Objective 2 | 250-325 words | 270-300 |
| 1.4 Insights/reflection | 200-250 words | 215-235 |
| 2.1 Preprocessing reflection | 200-250 words | 215-235 |
| 2.2 Baseline rationale | 100-150 words | 115-135 |
| 2.3 CV reflection | 200-250 words | 215-235 |
| 2.4 Tuning reflection | 200-250 words | 215-235 |
| 2.5 Final evaluation | 250-300 words | 265-285 |
| Process Log | Maximum 400 words | 360-390 |

The midpoint of these targets is about 3,100-3,200 words, leaving margin for headings, labels, captions and the AI acknowledgement under the 3,800-word total.

Code budget:

- Part 1 Sections 1.2 and 1.3: target 130-170 non-empty lines; hard maximum 250.
- Part 2: target 250-320 lines.
- Total target: 450-520 lines; hard maximum 600.
- Run the supplied word/code counter during development, but also manually review Part 1's 250-line sub-limit.
- Remove dead code and duplicated calculations rather than compressing readable code into dense one-line statements.

---

## 9. Recommended work schedule

### 27-30 September: project setup and evidence collection

- [ ] Download and preserve the Part 1 data.
- [ ] Record provenance, version and licence.
- [ ] Run the initial Part 1 audit.
- [ ] Confirm the 2023-2025 US sample and objective feasibility.
- [ ] Reproduce the Part 2 structural checks.
- [ ] Start the process diary.

### 1-7 October: Part 1 EDA and objective analysis

- [ ] Complete data-quality checks and define the analytical sample.
- [ ] Resolve employment-type, geography and outlier decision gates.
- [ ] Build summary tables and candidate figures.
- [ ] Select only the figures that answer the two objectives.
- [ ] Verify all quoted values against output.

### 8-12 October: Part 1 writing and refinement

- [ ] Draft Section 1.1 independently from recorded evidence.
- [ ] Add concise Section 1.2 interpretations after each output block.
- [ ] Draft both Section 1.3 analyses independently.
- [ ] Draft Section 1.4 synthesis.
- [ ] Check Part 1 code and word limits.

### 13-18 October: Part 2 preprocessing and baselines

- [ ] Define prediction timing and review questionable features.
- [ ] Split data without leakage.
- [ ] Build and validate preprocessing pipeline.
- [ ] Train two complete baseline pipelines.
- [ ] Keep a record of failed approaches for the Process Log.

### 19-22 October: validation, tuning and final evaluation

- [ ] Complete cross-validation comparison.
- [ ] Select and justify one model for tuning.
- [ ] Complete the hyperparameter search on training data.
- [ ] Lock development decisions.
- [ ] Evaluate once on the held-out test set.
- [ ] Complete the labelled confusion matrix and metrics summary.

### 23-24 October: reflections and process log

- [ ] Draft all Part 2 reflections from actual results.
- [ ] Complete the Process Log using the diary.
- [ ] Add the AI acknowledgement.
- [ ] Check consistency among code, numbers, charts and prose.

### 25 October: final quality assurance and upload buffer

- [ ] Delete every placeholder and instructional paragraph.
- [ ] Preserve all blue headings exactly.
- [ ] Confirm Student ID and exact notebook filename.
- [ ] Restart the kernel and run all cells.
- [ ] Inspect every output and figure after the clean run.
- [ ] Run the notebook word/code counter.
- [ ] Spell-check and proofread the complete notebook.
- [ ] Save a backup and upload before the final day if possible.

### 26 October: deadline contingency only

- [ ] Verify the uploaded file is the final executed notebook.
- [ ] Submit before 14:00 UTC / 22:00 China Standard Time.

---

## 10. Final quality-control checklist

### Analytical consistency

- [ ] Every objective stated in Section 1.1 is answered in Section 1.3.
- [ ] Every major conclusion is supported by visible code output or a figure.
- [ ] Every quoted value exactly matches the final clean notebook run.
- [ ] Sample definitions and denominators are stated clearly.
- [ ] Figures use readable labels, units, legends and meaningful ordering.
- [ ] No causal claim is made from descriptive observational data.
- [ ] Limitations are specific to the observed data and workflow.
- [ ] Part 2 preprocessing, CV and tuning occur inside leakage-safe pipelines.
- [ ] The held-out test set is used only for final evaluation.

### Rubric alignment

- [ ] Section 1.1 critically evaluates source quality and fitness for purpose.
- [ ] Section 1.2 is selective, reproducible and easy to follow.
- [ ] Section 1.3 contains effective visuals, precise numbers, domain interpretation and uncertainty.
- [ ] Section 1.4 synthesises rather than repeats.
- [ ] Section 2.1 explains alternatives and trade-offs as well as the selected preprocessing.
- [ ] Section 2.2 compares meaningfully different classifiers.
- [ ] Section 2.3 reports mean and standard deviation for multiple metrics.
- [ ] Section 2.4 evaluates whether tuning improvement is meaningful.
- [ ] Section 2.5 connects CV, test metrics, class errors and fitness for purpose.
- [ ] The Process Log analyses failures and learning rather than merely listing events.

### Presentation and submission

- [ ] All template placeholders and instructional text are removed.
- [ ] All blue assessment headings are unchanged.
- [ ] All cells run from top to bottom without errors.
- [ ] All required outputs are visible.
- [ ] Markdown word count <=3,800.
- [ ] Total code lines <=600.
- [ ] Part 1 Sections 1.2-1.3 code <=250 non-empty lines.
- [ ] Process Log <=400 words.
- [ ] AI use is acknowledged accurately.
- [ ] Final filename is exactly `P4DS_A2_Data_Analysis_Project.ipynb`.
- [ ] Only the `.ipynb` file is submitted.

---

## 11. Definition of done

The project is complete only when:

1. Both Part 1 objectives are feasible, answered and supported by visual and numerical evidence.
2. Part 1 conclusions are limited to the 2023-2025 US-company sample and do not claim causal AI impact.
3. The Part 2 workflow is leakage-safe from split through final evaluation.
4. Every reflection is grounded in the student's own observed distributions, missingness, class balance and performance results.
5. The Process Log contains genuine evidence from the development process.
6. The final notebook passes a fresh Restart & Run All, the word/code limits, the rubric checklist and the exact submission rules.
