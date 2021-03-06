# plots correaltion scatter-plot with the abline: colonic butyrate ~ liver 
# YEAST
#                       Estimate   SE       t-value Pr(>|t|)    
# (Intercept)           2.17665    0.20681  10.525  4.94e-08 ***
# butyrate_CD$butyrate  0.06294    0.01914   3.288  0.00539 ** 
# Residual standard error: 0.2633 on 14 degrees of freedom
# Adjusted R-squared:  0.3954 

library(readxl)
library(ggplot2)

#fetches the data from an excel file
butyrate_CD<-
  read_xlsx("C:/Users/stia/OneDrive - Norwegian University of Life Sciences/FOODSofNORWAY/FON_011/FON_011a/1_Manuscript/Caroline_fon11a/butyrate-CD.xlsx")

#subset the controls
butyrate_CD<-butyrate_CD[butyrate_CD$diet=="c",]

# Fit regression line
corr_eqn <- function(x,y, digits = 2) {
  corr_coef <- round(cor(x, y), digits = digits)
  paste("italic(r) == ", corr_coef)
}
labels = data.frame(x = 14, y = 3.25, label = corr_eqn(butyrate_CD$butyrate,
                                                       butyrate_CD$liver))


psl5<-ggplot(butyrate_CD, aes(x = butyrate, y = liver)) +
  geom_point(shape = 19, size = 4, aes(colour = diet)) +
  scale_color_manual(values=c("#CC79A7",
                              "#009E73"))+
  # scale_fill_manual(values=c("#CC79A7","#009E73"))
  geom_smooth(colour = "#CC79A7", fill = "lightgreen", method = 'lm') +
  #  ggtitle("Example") +
  ylab("LIVER INDEX") +
  xlab("COLONIC BUTYRATE, µM/g") +
  theme(legend.key = element_blank(),
        legend.background = element_rect(colour = 'black'),
        legend.position = "bottom",
        legend.title = element_blank(),
        plot.title = element_text(lineheight = .8, face = "bold", vjust = 1),
        axis.text.x = element_text(size = 11, vjust = 0.5,
                                   hjust = 1, colour = 'black'),
        axis.text.y = element_text(size = 11, colour = 'black'),
        axis.title = element_text(size = 10, face = 'bold'),
        axis.line = element_line(colour = "black"),
        plot.background = element_rect(colour = 'black', size = 1),
        panel.background = element_blank()) +
  theme_minimal()+
  geom_text(data = labels, aes(x = x, y = y,
                               label = label), parse = TRUE)+
  theme(legend.position = 'none')+
  theme(panel.grid = element_blank())
psl5

ggsave("fig-S3C.png",device = "png", 
       plot = psl5, 
       dpi = "retina", 
       width = 8, 
       height = 8, 
       units = "cm")
