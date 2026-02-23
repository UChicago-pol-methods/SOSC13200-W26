#' ---
#' title: "Assignment 8, Social Science Inquiry II (SOSC13200-W26-3)"
#' author: "<your name here>"
#' date: "Friday 2/27/26 at 11:59pm"
#' ---
#'
#' This assignment uses the replication materials for:
#'
#' Offer-Westort, Molly, Will Gruen, Carter Herron, Kaden Hyatt, Max Buford, Kevin Davis,
#' Diego Fonseca, Mushkie Gurevich, Tiffanie Huang, Rocio Jerez, and others. 2026.
#' "Which frame fits? Policy learning with framing for climate change policy attitudes."
#' *Research & Politics*.
#'
#' Data + code: https://github.com/UChicago-pol-methods/climate-framing-replication
#'
#' **What you’re practicing this week:** treatment effects, covariate adjustment (pre-test control),
#' randomization inference, and power/MDE thinking.
#'
#' ## Setup
#' 1. Clone (or download) the replication repo linked above.
#' 2. In that repo, the cleaned dataset lives at `data/ssi-data-cleaned.csv`.
#' 3. Set `data_path` below to point to that file on your computer.
#'
#' Packages
library(ggplot2)
library(stats)
# If you want: install.packages("dplyr"); library(dplyr)
# If you want: install.packages("estimatr"); library(estimatr)
#'
#' Load data
data_path <- "https://raw.githubusercontent.com/UChicago-pol-methods/climate-framing-replication/refs/heads/main/data/ssi-data-cleaned.csv"
dat <- read.csv(data_path, as.is = TRUE)
#'
#' Quick sanity checks (don’t delete; you’ll use this to orient yourself)
dim(dat)
names(dat)
head(dat)

#' # 1. Understand the experiment + pick an estimand
#'
#' ## (1a) Identify the treatment variable and the control condition
#' In the dataset there is a variable that indicates which experimental condition (frame)
#' each respondent was assigned to (including a control condition).
#'
#' - Create an R object called `cond` that is a **factor** version of that variable.
#' - Print a frequency table of the conditions (counts per condition).
#'
#' *Hint:* use `table()` and look at `names(dat)` / `head(dat)`.

# your code here

#' ## (1b) Define the outcome `Y` as the post-test measure (`post_test`) and define the pre-test measure as a covariate. 
#' Briefly describe (1--2 sentences) what higher values of `Y` mean, and report the range
#' (min/max) of `Y`.

# your code here

#' ## (1c) Define a single treatment contrast you will study
#' For the rest of the assignment, focus on ONE contrast:
#'
#' - choose one framing condition (call it “treatment”)
#' - compare it to the control condition
#'
#' Create a new data frame called `df` that keeps only observations assigned those two conditions.
#' Then in df, create:
#'
#' - `W` = 1 if in your chosen frame, 0 if in control
#' - `Y` = post-test score
#' - `pre` = pre-test score
#'
#' Report the sample size in treatment and control.

# your code here

#' # 2. Estimate treatment effects
#'
#' ## (2a) Difference in means
#' Compute the unadjusted difference in means post-test score between treatment and control, using `mean()` on the relevant subsets of `df$Y`.
#'
#' \[
#' \widehat{ATE}=\bar Y_{W=1}-\bar Y_{W=0}.
#' \]
#'
#' Save it as an object called `ate_hat_unadj`.

# your code here

#' ## (2b) Regression estimate
#' Estimate the treatment effect by regressing Y on W. What is your estimated treatment effect?
#' Is it the same as in 2a? Why or why not. 

# your code here

#' ## (2c) Regression controlling for pre-test score
#' Estimate the treatment effect controlling for pre-test score by running:
#'
#' \[
#' Y_i = \alpha + \tau W_i + \gamma \, pre_i + \varepsilon_i.
#' \]
#'
#' Save the estimated coefficient on `W` as an object called `ate_hat_adj`. Is it the same as the unadjusted estimates? Why or why not?

# your code here

#' # 3. Inference
#'
#' ## (3a) Inference for the unadjusted estimate
#' Use a two-sample t-test to get a 95\% CI and a (two-sided) p-value for the unadjusted
#' effect. Report both and interpret the p-value in one sentence.

# your code here

#' ## (3b) Inference for the adjusted estimate
#' Use the regression output from (2b) to report:
#' - the estimated effect (coefficient on `W`)
#' - its standard error
#' - a 95\% CI
#' - a p-value
#'
#' Interpret the p-value in one sentence.

# your code here

#' ## (3c) Compare
#' In 3--5 sentences: compare the unadjusted and adjusted estimates.
#' Do they differ? Why might controlling for pre-test change the estimate and/or the SE?

# your answer here

#' # 4. Randomization inference (permutation test)
#'
#' In class we discussed randomization inference as a way to compute a p-value using the
#' random assignment mechanism.
#'
#' ## (4a) Unadjusted: write a function to get a placebo ATE
#' Write a function `ri_once_unadj(df)` that:
#' - creates a permuted treatment assignment `newW` by shuffling `df$W` (without replacement)
#' - returns the difference in means under `newW` (using `df$Y`)
#'
#' (Return a single number.)

# your code here

#' ## (4b) Generate a randomization distribution (unadjusted)
#' Use `replicate()` to run `ri_once_unadj(df)` 1000 times and save the output as `ri_dist_unadj`.
#' Do NOT print all 1000 values.

# your code here

#' ## (4c) Randomization-inference p-value (unadjusted)
#' Compute the two-sided p-value:
#'
#' \[
#' p=\Pr(|\widehat{ATE}^{\mathrm{placebo}}|\ge |\widehat{ATE}^{\mathrm{obs}}|).
#' \]
#'
#' Report it and compare it to the t-test p-value from (3a) (1--3 sentences).

# your code here

#' ## (4d) Adjusted: placebo distribution for the regression coefficient
#' Write a function `ri_once_adj(df)` that:
#' - permutes `W` to create `newW`
#' - runs the regression `Y ~ newW + pre`
#' - returns the coefficient on `newW`

# your code here

#' ## (4e) Adjusted: RI p-value
#' Use `replicate()` to build `ri_dist_adj` (1000 draws), then compute the two-sided RI p-value
#' for `ate_hat_adj`. Compare this RI p-value to the regression p-value from (3b).

# your code here

#' # 5. Power and MDE thinking (simulation)
#'
#' Now pretend you are planning a follow-up study comparing the SAME frame vs control,
#' and you plan to analyze post-test controlling for pre-test.
#'
#' ## (5a) Estimate “noise” after controlling for pre-test
#' One simple way to approximate the remaining noise is:
#' - fit a regression of `Y` on `pre` in the control group only
#' - take the standard deviation of the residuals
#'
#' Let `sigma_hat` be that residual standard deviation.
#' Report `sigma_hat`.

# your code here

#' ## (5b) Pick an effect size you want to be able to detect
#' Choose ONE:
#' - Option A: Use your observed adjusted effect size `ate_hat_adj` as the target effect size.
#' - Option B: Choose a smaller “smallest effect size of interest” (SESOI) and justify it
#'   in 1–2 sentences.
#'
#' Save your chosen target effect size as `delta`.

# your code here

#' ## (5c) Power curve
#' Write a short simulation that approximates power for a two-sample difference-in-means
#' test (alpha = 0.05, two-sided) as a function of sample size per arm.
#'
#' Suggested approach (one way):
#' - Choose sample sizes per arm, e.g. `n_grid <- seq(50, 1000, by = 50)`
#' - For each n in the grid:
#'     - Simulate outcomes for control: `Y0 ~ Normal(0, sigma_hat)`
#'     - Simulate outcomes for treatment: `Y1 ~ Normal(delta, sigma_hat)`
#'     - Run a t-test and record whether p < 0.05
#'     - Repeat (e.g., 500 times) and compute the fraction “significant” = estimated power
#'
#' Make a plot of power vs n, and report the smallest n where power is at least 0.80.

# your code here

#' ## (5d) One-paragraph takeaway
#' Based on your power curve, answer:
#' - Is the effect size you’re targeting realistic/substantively meaningful?
#' - What sample size would you recommend for a follow-up study?
#' - What assumptions is your power calculation making that might not hold in practice?

# your answer here
