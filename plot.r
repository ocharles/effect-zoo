library('ggplot2')
options(scipen=20)

data <- read.csv('file-sizes.csv', header=FALSE, col.names=c("Implementation", "Scenario", "Mean", "MeanL", "MeanU"))
data$Scenario <- as.character(data$Scenario)
data$Scenario <- factor(data$Scenario, level=unique(data$Scenario))

ggplot(data, aes(x=Scenario, y=Mean, fill=Implementation)) + 
  geom_bar(stat="identity", colour="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=MeanL, ymax=MeanU), position=position_dodge(0.9), width=0.2) +
  labs(title="FileSizes (by scenario)", y = "Execution time (s)") +
  theme_linedraw()

ggplot(data, aes(x=Implementation, y=Mean, fill=Scenario)) + 
  geom_bar(stat="identity", colour="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=MeanL, ymax=MeanU), position=position_dodge(0.9), width=0.2) +
  labs(title="FileSizes (by implementation)", y = "Execution time (s)") +
  theme_linedraw()



data <- read.csv('big-stack.csv', header=FALSE, col.names=c("Implementation", "Scenario", "Mean", "MeanL", "MeanU"))
data$Scenario <- as.character(data$Scenario)
data$Scenario <- factor(data$Scenario, level=unique(data$Scenario))

ggplot(data, aes(x=Scenario, y=Mean, fill=Implementation)) + 
  geom_bar(stat="identity", colour="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=MeanL, ymax=MeanU), position=position_dodge(0.9), width=0.2) +
  labs(title="BigStack (by stack size)", y = "Execution time (s)") +
  theme_linedraw()

ggplot(data, aes(x=Implementation, y=Mean, fill=Scenario)) + 
  geom_bar(stat="identity", colour="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=MeanL, ymax=MeanU), position=position_dodge(0.9), width=0.2) +
  labs(title="BigStack (by implementation)", y = "Execution time (s)") +
  theme_linedraw()


data <- read.csv('countdown.csv', header=FALSE, col.names=c("Implementation", "n", "Mean", "MeanL", "MeanU"))

ggplot(data, aes(x=factor(n), y=Mean, fill=Implementation)) + 
  geom_bar(stat="identity", colour="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=MeanL, ymax=MeanU), position=position_dodge(0.9), width=0.2) +
  labs(title="CountDown (by n)", y = "Execution time (s)") +
  theme_linedraw()

ggplot(data, aes(x=Implementation, y=Mean, fill=factor(n))) + 
  geom_bar(stat="identity", colour="black", position=position_dodge()) +
  geom_errorbar(aes(ymin=MeanL, ymax=MeanU), position=position_dodge(0.9), width=0.2) +
  labs(title="CountDown (by implementation)", y = "Execution time (s)") +
  theme_linedraw()
