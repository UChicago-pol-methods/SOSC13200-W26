#' ---
#' title: "Assignment 9, Social Science Inquiry II (SOSC13200-W26-3)"
#' author: "<your name here>"
#' date: "Friday 3/6/26 at 11:59pm"
#' ---
#'
#' **Collaboration:** you may discuss conceptual questions with classmates, but your code and write-up must be your own.
#'
#' ## Setup
#' Use the same data source you used in Assignment 8.
#'
#' Load data
#'
data_path <- "https://raw.githubusercontent.com/UChicago-pol-methods/climate-framing-replication/refs/heads/main/data/ssi-data-cleaned.csv"

dat <- read.csv(data_path, as.is = TRUE)
#' Treatment labels (for convenience)
#'
#' In this dataset:
#' - `treatment_value = 0` is the control (no framing)
#' - `treatment_value = 1..5` are the five frames
treatment_labels <- c(
  "Control (no framing)",
  "Negative science",
  "Religious",
  "Equity",
  "Efficiency",
  "Secular"
)

#' # 1. PAP-to-paper crosswalk (short reading check)
#'
#' Open:
#' - https://github.com/UChicago-pol-methods/climate-framing-replication/blob/main/preregistration/Pre-analysis%20plan.pdf
#'
#' Answer briefly (1–3 sentences each).
#'
#' ## (1a) Outcome + arms
#' In the paper/PAP, what is the main outcome and how is it constructed?
#' What are the treatment arms and what is the control condition?

# your answer here

#' ## (1b) Main estimands + “best arm”
#' What are the main causal quantities the PAP targets?
#' In 2–3 sentences, explain what the “best arm” / policy-learning goal is and why sample splitting matters.

# your answer here

#' # 2. Measurement: rebuild the index outcome
#'
#' The dataset includes `post_test` and `pre_test`. The PAP describes these as indices.
#' In this section, you will rebuild them from the component items and confirm they match.
#'
#' ## (2a) Recreate the post-test index
#' Create a new variable `post_index` that is the average of:
#' - `gastax_after`, `carbtax_after`, `treaty_after`, `regcarb_after`
#'
#' Then report the maximum absolute difference `max(abs(post_index - post_test))`.

# your code here

#' ## (2b) Recreate the pre-test index
#' Create `pre_index` as the average of:
#' - `gastax`, `carbtax`, `treaty`, `regcarb`
#'
#' Then report `max(abs(pre_index - pre_test))`.

# your code here

#' # 3. Multi-arm treatment effects (frame vs control)
#'
#' In Assignment 8 you chose ONE contrast. Here you will estimate effects for **all frames vs control**.
#' Use:
#' - outcome: `post_test`
#' - covariate: `pre_test`
#' - treatment assignment: `treatment_value` (0 = control; 1–5 are frames)
#'
#' For this assignment, **do not** do additional cleaning / subsetting beyond dropping missing values
#' in the variables you use.
#'
#' ## (3a) Create a results table
#' For each arm k in {1,2,3,4,5}, compare arm k to control (0) and compute:
#'
#' 1) Unadjusted estimate: difference in means (arm k minus control)
#' 2) Adjusted estimate: regression `post_test ~ W + pre_test` on the arm-k-vs-control subset
#'
#' Build a data frame called `results` with one row per arm and columns:
#' - `arm` (a label like "Scientific", "Religious", etc.)
#' - `ate_unadj`
#' - `ate_adj`
#' - `se_adj`
#' - `ci_low_adj`, `ci_high_adj` (use normal approx: estimate ± 1.96 * SE)
#'
#' Print `results`.
#'

# your code here

#' ## (3b) One-sentence interpretation
#' In one sentence: which arm looks best by the adjusted estimate, and how large is the effect (in index units)?

# your answer here

#' # 4. “Best arm” estimation with simple sample splitting (selective inference)
#'
#' If you pick “the best” arm using the full sample and then report its estimated effect using the same sample,
#' that estimate is (on average) too optimistic because you selected it based on noise.
#'
#' Here you’ll implement a simplified sample-splitting procedure like the one described in the PAP/paper.
#'
#' ## (4a) Choose the best arm on a training set
#' Randomly split the data into two halves: "train" and "test" (use `set.seed()`).
#'
#' On the training half only, run the multi-arm regression:
#' \[
#' post\_test_i = \alpha + \sum_{k=1}^5 \tau_k \mathbf{1}\{treatment=k\} + \gamma\, pre\_test_i + \varepsilon_i,
#' \]
#' where treatment 0 (control) is the baseline category.
#'
#' Identify which arm k has the largest estimated \(\hat\tau_k\) on the training set.
#' Save it as an integer called `best_k_train`.

# your code here

#' ## (4b) Estimate the best arm effect on the test set (held out)
#' Using the test half only:
#' - keep only observations in control (0) and the chosen best arm `best_k_train`
#' - create `W = 1` for best arm, `0` for control
#' - estimate the adjusted effect via `lm(post_test ~ W + pre_test)`
#'
#' Report the estimated effect (coefficient on `W`) and its SE.

# your code here

#' ## (4c) Compare to the naive (non-split) estimate
#' Now do the naive version on the full sample:
#' - pick the best arm using the full sample (same multi-arm regression)
#' - estimate that arm’s adjusted effect vs control using the full sample
#'
#' Report (i) which arm is “best” under the naive approach and (ii) the estimated effect.
#' In 2–3 sentences: compare the naive estimate to the split-sample estimate and explain why they may differ.

# your code here + your answer here
