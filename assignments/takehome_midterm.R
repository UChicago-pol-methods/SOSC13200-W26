#' ---
#' title: "Take-home midterm, Social Science Inquiry II (SOSC13200-W26-3)"
#' author: "<your name here>"
#' date: "Friday 2/6/26 at 11:59pm"
#' output: pdf_document
#' ---
#'
#' ## Instructions
#'
#' **Reproducibility requirements:**
#' 
#' - Your script must run top-to-bottom without manual intervention.
#' - Set a random seed *once* (see below).
#' - Use a relative path to load the data (e.g., `data/...`) or a stable URL
#'   from the course site.
#' - Show your work in R code.
#' - Label plots clearly.
#'
#' **Allowed resources:**
#' 
#' - Class slides, homework templates, and course readings.
#' - You may use AI tools, but you are responsible for correctness and for
#'   understanding what you submit. Include the required AI statement at the end.
#'
#' **Packages:**
#' 
#' - `ggplot2` is allowed and recommended.
#' - If you use additional packages, list them in your report and explain why.
#'
#' ## Data
#' You will analyze an anonymized public dataset from a field experiment in which
#' state legislators received messages from putative constituents.
#'
#' **Outcome:**
#' 
#' - `reply_atall`: 1 if the legislator replied at all; 0 otherwise.
#'
#' **Treatment indicators (message features):**
#' 
#' - `treat_deshawn` / `treat_jake`: indicators for the (randomized) name cue
#' - `treat_noprimary`, `treat_demprimary`, `treat_repprimary`: indicators for the
#'   partisan-primary cue embedded in the message
#' - `treat_primary`: 1 if any primary cue (Dem or Rep) is present; 0 otherwise
#' - `treat_group`: numeric group label for the combined treatment condition
#'
#' **Legislator attributes (from public data):**
#' 
#' - `leg_party`, `leg_republican`
#' - `leg_white`, `leg_notwhite`, `leg_black`, `leg_latino`,
#'   `leg_notblackotherminority`
#'
#' Your goal is to describe patterns in replies, define clear estimands, and then
#' quantify uncertainty using Week 5 tools.
#'
#' 

#' \clearpage 

#' ## Setup
library(ggplot2)
set.seed(60637) # you can reset this to whatever you like. Set seed once only.

#' Load the data. 
dat <- read.csv("../data/butler-broockman.csv", as.is = TRUE)

#' 
#' # 1. Directory hygiene + “public procedures” (2 points)
#' 
#' ## 1a) Print your working directory using `getwd()`.
# Your code here.
#' ## 1b) Print the first 6 file names in your project folder using `list.files()`.
# Your code here.
#' ## 1c) Print your `sessionInfo()`.
#'
# Your code here.

#' 
#' # 2. Data audit (6 points)
#' ## 2a) Create a **data audit table** with one row per variable. Columns should describe:
#' 
#' - variable name
#' - class/type (e.g. numeric/integer/character)
#' - % missing
#' - number of unique values
#' - min/max (numeric variables only; otherwise NA)
#'
#' Print the audit table in your report.
# Your code here.
#'
#' ## 2b) Based on your audit: does this dataset have missingness? 
#' If so, describe the missingness patterns. 
#' If not, suggest an explanation for why there is not missingness. 

#' [Your explanation here]

#' 
#' # 3. Treatment recodes + balance checks (8 points)
#'
#' ## 3a) Recode treatment variables into readable factors
#' Create:
#' 
#' - `name_cue`: "Deshawn" vs "Jake" (a factor)
#' - `primary_cue`: "No primary", "Dem primary", "Rep primary" (a factor)
#'
#' Show `table(name_cue)` and `table(primary_cue)` in your report.

# Your code here.

#' ## 3b) Randomization/balance check using observable legislator attributes
#' Because treatment is randomized, legislator covariates should look similar
#' across treatment groups (up to random noise).
#'
#' Make a table that reports **mean legislator characteristics** by `name_cue`:
#' 
#' - `leg_republican`
#' - `leg_white`
#' - `leg_black`
#' - `leg_latino`
#'
#' Include a final column with the difference in means (Deshawn minus Jake).
#' (Do not run a formal hypothesis test here; just report descriptively.)

# Your code here.

#' ## 3c) Visual balance check
#' Make a bar plot (or dot plot) showing the **mean of `leg_republican`** by
#' `name_cue`, with appropriate titles/labels.

# Your code here.

#' 
#' # 4. Descriptive evidence: response rates (8 points)
#'
#' Define the quantity:
#' \[
#' \Delta = \bar{Y}_{Deshawn} - \bar{Y}_{Jake}
#' \]
#' where \(Y\) is `reply_atall`.
#'
#' ## 4a) Overall response rate
#' Report the overall mean of `reply_atall`. Interpret it in one sentence.

# Your code here.
#' [Your one-sentence interpretation here]

#' 
#' ## 4b) Response rates by name cue
#' Create a small table with:
#' 
#' - mean reply rate for Deshawn
#' - mean reply rate for Jake
#' - difference in means (Deshawn - Jake)
#' Interpret the sign (+/-) of the difference in 1–2 sentences.

# Your code here.
#' [Your interpretation here]

#' 
#' ## 4c) Response rates by name cue *and* legislator party
#' Create a table with one row for Democrats and one row for Republicans,
#' showing:
#' 
#' - mean reply rate for Deshawn
#' - mean reply rate for Jake
#' - difference in means
#'
#' Briefly describe whether the estimated difference looks similar across
#' party or not (2–4 sentences).

# Your code here.
#' [Your interpretation here]

#' 
#' # 5. Visualization: conditional means (6 points)
#'
#' ## 5a) Main visualization
#' Make a plot of **mean reply rate** (y-axis) by `name_cue` (x-axis),
#' with separate facets for legislator party (`leg_party`) and different colors
#' for `primary_cue`.
#'
#' Requirements:
#' 
#' - clear title
#' - labeled axes
#' - readable legend

# Your code here.

#' ## 5b) One additional plot of your choice (pick ONE)
#' - Option 1: Plot mean reply rate by the 6-level `treat_group`.
#' - Option 2: Plot mean reply rate by `primary_cue`, with color for `name_cue`.
#' - Option 3: Another plot you propose that is clearly related to the research question.
#'
#' Write 1–2 sentences explaining what your plot shows.

# Your code here.
#' [Your interpretation here]

#' 
#' # 6. Week 5 inference (12 points)
#'
#' In this problem, you will quantify uncertainty about the **difference in means**
#' for the name cue:
#' \[
#' \Delta = \bar{Y}_{Deshawn} - \bar{Y}_{Jake}.
#' \]
#'
#' To keep the design simple, restrict to the “No primary” condition:
#' `treat_noprimary == 1`.
#'
#' ## 6a) Observed estimate
#' Compute \(\Delta_{obs}\) in the no-primary subset.

# Your code here.

#' ## 6b) Randomization inference
#' Implement a randomization inference test for \(\Delta\) in the no-primary subset:
#' 
#' - Hold the outcomes fixed.
#' - Randomly shuffle the treatment label (`name_cue`) across units.
#' - Recompute \(\Delta\).
#' - Repeat for B = 5000 permutations.
#'
#' Compute a **two-sided** p-value:
#' \[
#' p = \frac{\#\{|\Delta^{(b)}| \ge |\Delta_{obs}|\}}{B}
#' \]
#'
#' Make a histogram of the permutation distribution and add a vertical line at
#' \(\Delta_{obs}\).

# Your code here.

#' 
#' # 7. Short memo: design + estimand + credibility (8 points)
#'
#' Write a memo (200–300 words) with headings that answers:
#'
#' ## 7a) **Unit of analysis and population:** 
#' What is one row in this dataset? What
#'    broader population are we trying to learn about (if any)?
#'
#' ## 7b) **Treatment, outcome, estimand:** 
#' Define the treatment and outcome in words,
#'    and state the estimand you focused on.
#'
#' ## 7c) **Why we can/can’t make a causal claim:** 
#' What feature of the research design
#'    supports causal interpretation? Name one key assumption.
#'
#' ## 7d) **External validity + measurement:** 
#' Give two limitations (measurement or
#'    generalizability) that should temper interpretation of results.
#'
#' Be specific and tie your points to what you actually saw in the data/analysis.

#' [Your memo here]

#' 
#' # 8. AI statement
#' Include an AI statement with reference to the course AI policy:
#' https://github.com/UChicago-pol-methods/SOSC13200-W26/blob/main/ai-policy.md
