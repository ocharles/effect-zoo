library('ggplot2')
options(scipen = 20)

plotByScenario <- function(data)
{
  ggplot(data,
         aes(x = Scenario, y = Mean, fill = Implementation),
         environment = environment()) +
    geom_bar(stat = "identity",
             colour = "black",
             position = position_dodge()) +
    geom_errorbar(aes(ymin = MeanL, ymax = MeanU),
                  position = position_dodge(0.9),
                  width = 0.2) +
    facet_wrap( ~ Scenario, scales = "free") +
    labs(y = "Execution time (s)") + theme_linedraw() +
    theme(
      panel.grid.major.x = element_blank(),
      axis.text.x = element_blank(),
      axis.ticks.x = element_blank()
    )
}

plotByImplementation <- function(data)
{
  ggplot(data, aes(x = Implementation, y = Mean, fill = Scenario)) +
    geom_bar(stat = "identity",
             colour = "black",
             position = position_dodge()) +
    geom_errorbar(aes(ymin = MeanL, ymax = MeanU),
                  position = position_dodge(0.9),
                  width = 0.2) +
    theme_linedraw() +
    facet_wrap(~ Implementation, scales = "free") +
    theme(
      panel.grid.major.x = element_blank(),
      axis.text.x = element_blank(),
      axis.ticks.x = element_blank()
    ) +
    labs(y = "Execution time (s)")
}

loadData <- function(file)
{
  data <-
    read.csv(
      file,
      header = FALSE,
      col.names = c("Implementation", "Scenario", "Mean", "MeanL", "MeanU")
    )
  data$Scenario <- as.character(data$Scenario)
  data$Scenario <-
    factor(data$Scenario, level = unique(data$Scenario))
  data
}


BigStack <- loadData('big-stack.csv')
plotByScenario(BigStack) + labs(title = "BigStack (by scenario)")
plotByImplementation(BigStack) + labs(title = "BigStack (by implementation)")

Countdown <- loadData('countdown.csv')
plotByScenario(Countdown) + labs(title = "Countdown (by n)", x = "n")
plotByImplementation(Countdown) + labs(title = "Countdown (by implementation)")

FileSizes <- loadData('file-sizes.csv')
plotByScenario(FileSizes) + labs(title = "FileSizes (by scenario)")
plotByImplementation(FileSizes) + labs(title = "FileSizes (by implementation)")

Reinterpretation <- loadData('reinterpretation.csv')
plotByScenario(Reinterpretation) + labs(title = "Reinterpretation (by scenario)")
plotByImplementation(Reinterpretation) + labs(title = "Reinterpretation (by implementation)")
