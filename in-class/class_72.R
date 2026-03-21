#' ---
#' title: "In-class 7.2, Social Science Inquiry II (SOSC13200-W26)"
#' author: "Molly Offer-Westort"
#' date: "Thursday 2/18/26"
#' ---

library(ggplot2)
library(estimatr)
library(modelsummary)

#' 
#' ## Reading in the data 
file_local <- "data/card-krueger.csv"
file_url <- "https://raw.githubusercontent.com/UChicago-pol-methods/SOSC13200-W26/main/data/card-krueger.csv"
file <- if (file.exists(file_local)) file_local else file_url
dat <- read.csv(file, as.is = TRUE)

#+ eval = FALSE
str(dat) # don't evaluate this when compiling
#'


# Creating `State` factor
# note use of levels to set order

dat$State <- factor(dat$nj,
                    levels = c(1, 0), 
                    labels = c('NJ', 'PA'))

dat$Wave <- factor(dat$d, 
                   levels = c(0, 1),
                   labels = c('February 1992', 'November 1992'))

# check distribution of state
table(dat$State)/2

# wave 1 data
dat0 <- dat[which(dat$d==0),]

# wave 2 data
dat1 <- dat[which(dat$d==1),]

#' 
#' ## Recreating Figure 1
#' 
# For ..special variables.. see ggplot_build(...)$data[[1]]

g1 <- ggplot(dat0, aes(x = wage, fill = State)) +
  geom_histogram(aes(y = after_stat(count / tapply(count, group, sum)[group])),
                 position='dodge', bins = 15, na.rm = TRUE) + 
  scale_y_continuous(labels = scales::label_percent(accuracy = 1), 
                     breaks = seq(0, 1, 0.05)) + 
  scale_x_continuous(breaks = seq(4.25, 5.55, 0.1)) + # x axis ticks
  coord_cartesian(xlim = c(4.25,5.55)) + # x limits
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 0.95)) + # x axis at 45 degree angle
  scale_fill_brewer(palette="Set2") + 
  xlab('Wage Range') +
  ylab('Percent of Stores') + 
  ggtitle('Wage by state, percentages')

g1


g2 <- ggplot(dat1, aes(x = wage, fill = State)) +
  geom_histogram(aes(y = after_stat(count / tapply(count, group, sum)[group])),
                 position='dodge', bins = 15, na.rm = TRUE) + 
  scale_y_continuous(labels = scales::label_percent(accuracy = 1), 
                     breaks = seq(0, 1, 0.05)) + 
  scale_x_continuous(breaks = seq(4.25, 5.55, 0.1)) + # x axis ticks
  coord_cartesian(xlim = c(4.25,5.55)) + # x limits
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 0.95)) + # x axis at 45 degree angle
  scale_fill_brewer(palette="Set2") + 
  xlab('Wage Range') +
  ylab('Percent of Stores') + 
  ggtitle('Wage by state, percentages')

g2

g3 <- ggplot(dat, aes(x = wage, fill = State)) +
  facet_wrap(~Wave, nrow = 2) + 
  geom_histogram(aes(y = after_stat(count / tapply(count, group, sum)[group])),
                 position='dodge', bins = 15, na.rm = TRUE) + 
  scale_y_continuous(labels = scales::label_percent(accuracy = 1), 
                     breaks = seq(0, 1, 0.05)) + 
  scale_x_continuous(breaks = seq(4.25, 5.55, 0.1)) + # x axis ticks
  coord_cartesian(xlim = c(4.2,5.6)) + # x limits
  theme_bw() +
  theme(axis.text.x = element_text(angle = 45, hjust = 0.95)) + # x axis at 45 degree angle
  scale_fill_brewer(palette="Set2") + 
  xlab('Wage Range') +
  ylab('Percent of Stores') + 
  ggtitle('Wage by state, percentages')

g3

# Notice bin width compared to plot

#' 
#' ## Table 3

lm0 <- lm_robust(fte ~ d*nj, data = dat)
lm_robust(fte ~ d + nj + d_nj, data = dat)

## Row 1
# PA before
coef(lm0)['(Intercept)']
# NJ before
coef(lm0)['(Intercept)'] + coef(lm0)['nj']
# Difference before
coef(lm0)['nj']

## Row 2
# PA after
coef(lm0)['(Intercept)'] + coef(lm0)['d']
# NJ after
coef(lm0)['(Intercept)'] + coef(lm0)['nj'] + coef(lm0)['d'] + coef(lm0)['d:nj']
# Difference after
coef(lm0)['nj'] + coef(lm0)['d:nj']

## Row 3
# PA change
coef(lm0)['d']
# NJ change
coef(lm0)['d'] + coef(lm0)['d:nj']
# Difference in change
coef(lm0)['d:nj']

## Row 4
idx <- intersect(
dat$id[which(dat$d == 0 & !is.na(dat$fte))],
dat$id[which(dat$d == 1 & !is.na(dat$fte))])

lm0b <- lm_robust(fte ~ d *nj, data = dat[which(dat$id %in% idx),])
# PA change
coef(lm0b)['d']
# NJ change
coef(lm0b)['d'] + coef(lm0)['d:nj']
# Difference in change
coef(lm0b)['d:nj']


# Row 5...?
# And Stores in NJ, Differences w/in NJ...?

#' Table 4
#' 
# Table 4 footnote restriction: 357 stores with non-missing employment in both
# waves and non-missing starting wage in wave 1. The 6 permanently closed stores
# (status == 3) are kept even though their wave-2 starting wage is missing.
w1 <- dat[dat$d == 0, c(
  "id", "nj", "fte", "wage",
  "bk", "kfc", "roys", "wendys", "co_owned",
  "centralj", "southj", "pa1", "pa2",
  "status"
)]
w2 <- dat[dat$d == 1, c("id", "fte", "wage")]

table4 <- merge(w1, w2, by = "id", suffixes = c("_w1", "_w2"))
table4$Y <- table4$fte_w2 - table4$fte_w1

# discuss coding of gap
table4$gap <- ifelse(
  table4$nj == 1 & table4$wage_w1 <= 5.05,
  (5.05 - table4$wage_w1) / table4$wage_w1,
  0
)

is_closed <- table4$status == 3
table4 <- table4[
  !is.na(table4$fte_w1) &
    !is.na(table4$fte_w2) &
    !is.na(table4$wage_w1) &
    (!is.na(table4$wage_w2) | is_closed),
]

# Table 4 footnote statistics: mean = -0.237 and SD = 8.825
nrow(table4)
mean(table4$Y)
sd(table4$Y)

(lm1 <- lm_robust(Y ~ nj, data = table4))
(lm2 <- lm_robust(Y ~ nj + bk + kfc + roys + wendys + co_owned, data = table4))
# why do we drop one variable?
(lm3 <- lm_robust(Y ~ gap, data = table4))
(lm4 <- lm_robust(Y ~ gap + bk + kfc + roys + wendys + co_owned, data = table4))
(lm5 <- lm_robust(Y ~ gap + bk + kfc + roys + wendys + co_owned + centralj + southj + pa1 + pa2, data = table4))


