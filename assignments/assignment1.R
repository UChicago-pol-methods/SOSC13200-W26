#' ---
#' title: "Assignment 1, Social Science Inquiry II (SOSC13200-W26-3)"
#' author: "<your name here>"
#' date: "Friday 1/9/26 at 11:59pm"
#' ---
#'
#' # Course setup instructions:
#'  
#' To get started in R: 
#' 
#' - download the latest version of R here: https://www.r-project.org/
#' - download the free Rstudio desktop here: https://www.rstudio.com/
#'
#' To generate pdf reports, you need to have a version of LaTeX installed; LaTeX 
#' is a typesetting software; R will call it under the hood to generate reports. 
#' If you don't already use LaTeX, you can install TinyTeX, which is a 
#' lightweight, flexible LaTeX installation. 
#' 
#' To install TinyTex, you can run the code below in R, (remove the hashtag 
#' from in front). 
# install.packages('tinytex', repos = "http://cran.us.r-project.org")
# tinytex::install_tinytex()  # install TinyTeX
#'
#' In this class, we will generate pdf reports based on R scripts with a method 
#' called "spinning" in R.
#' When spinning, we differentiate between regular R comments,
# --which are formatted like this, with just the hashtag before them--
#' and roxygen comments, which have #' before them. Roxygen comments can use 
#' more advanced formatting, like making things **bold** or *italicized*. 
#'
#' ## 1. Set up a working directory for this class. 
#' 
#' a. Pick a location for this class somewhere on your own computer. Preferably 
#' not on your desktop. Mine is here: 
#' `~/Users/moffer/Documents/Git/teaching`. 
#' 
#' b. Clone the course repository locally.
#' You can use Git, or download the ZIP from GitHub and unzip it.
#' If you use Git, you can also use it later for pulls, but that is optional. 
#' 
#' c. Make sure that you have opened a version of this file that lives in the 
#' `SOSC13200-W26/assignments` folder. 
#' 
#' Starting with your class folder, your directory structure should look like 
#' this:
#' 
#' ```
#' | -SOSC13200-W26 
#' | |- assets
#' | |- assignments
#' | | |-assignment1.R
#' | |- slides
#' ```
#' 
#' ## 2. Fill in your own name at the top of this file, where it says
#' `<your name here>`.
#'
#' ## 3. Set up Claude (optional).
#' If you plan to use Claude Code, follow the instructions in
#' `assignments/claude-code-installation.md`.
#' \url{https://github.com/UChicago-pol-methods/SOSC13200-W26/blob/main/assignments/claude-code-installation.md}
#'
#' ## 4. Compile this script from the correct location.
#' Open this file from the local repo and "spin" it to PDF.
#' In RStudio, click Compile (Looks like a Notepad Next to the Magnifying Glass) to produce the PDF.

#' *Commands in RStudio Console* (Install packages as they come up when running these)

#' Working directory (should be the `assignments/` folder in the course repository):
getwd()

#' If you need to change your directory to the `assignments/` folder, use the following command:
setwd(<YOUR PATH>)

#' Full recursive listing of files in the folder.
print(list.files(".", recursive = TRUE))

#' Parent directory (one level up) to show the repo sits in the expected place.
print(list.files("..", all.files = FALSE))

# ## 5. If you will be using Claude Code:
#' Claude version (optional):
#' Output should be something like `## 2.0.76 (Claude Code)`
if (nzchar(Sys.which("claude"))) {
  cat(system("claude --version", intern = TRUE), sep = "\n")
} else {
  cat("Claude not found on PATH.\n")
}
