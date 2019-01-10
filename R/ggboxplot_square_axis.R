#' A plotting function using ggplot2
#'
#' This function allows easier creation of square with custom axes ranges.
#'
boxplot_square_axis <- function(data, title, xaxis_category, yaxis_category, xaxis, yaxis,
                                show_both_eyes=FALSE,
                                color_category=NULL,
                                show_outliers=FALSE) {
  font_size = 11;
  xaxis_category_factors <- paste('factor(', xaxis_category, ')' , sep = '' )
  color_category_factors <- paste('factor(', color_category, ')', sep= '')

  number_factors <- length(unique(data[[xaxis_category]]))
  xmin <- 0.25
  xmax <- number_factors + 0.75

  yaxis_edge_padding <- max(yaxis) / 30
  ymin <- min(yaxis) - yaxis_edge_padding
  ymax <- max(yaxis) + yaxis_edge_padding

  if (show_both_eyes) {
    p <- ggplot(data, aes_string(x = xaxis_category_factors, y = yaxis_category, color = color_category_factors))
    p <- p + scale_color_discrete(name = element_blank(), labels = c('OD', 'OS'))
    p <- p + scale_color_manual(values = c('#ff6347', '#4169e1'), labels = c('OD', 'OS'))
  } else if (! show_both_eyes) {
    p <- ggplot(data, aes_string(x = xaxis_category_factors, y = yaxis_category))
  } else {
    stop("ERROR: Please enter 'TRUE' or 'FALSE' to specify whether to plot both eyes")
  }

  p <- p + stat_boxplot(geom ='errorbar', width = 0.5, position = position_dodge(width = 0.75))
  p <- p + scale_x_discrete(name = element_blank(), labels = xaxis)
  p <- p + theme_bw() + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank(),
                              text = element_text(colour = '#000000', size = font_size),
                              axis.text = element_text(colour = '#000000', size = font_size),
                              axis.line.x.top = element_line(colour = '#000000'),
                              axis.line.x.bottom = element_line(colour = '#000000'),
                              axis.line.y.right = element_line(colour = '#000000'),
                              axis.line.y.left = element_line(colour = '#000000'),
                              axis.title = element_blank(),
                              axis.ticks.length = unit(.15, "cm"),
                              legend.title = element_blank())
  p <- p + ggtitle(title)
  if (stri_detect_fixed(title, c('^')) || stri_detect_fixed(title, c('['))) { # changes margins if there is super/subscript in title
    p <- p + theme(plot.title = element_text(hjust = 0.5, vjust = -0.001))
    p <- p + theme(plot.margin = unit(c(-3,4,-50,4), "pt"))
  } else {
    p <- p + theme(plot.title = element_text(face = 'bold', hjust = 0.5))
    p <- p + theme(plot.margin = unit(c(2,4,-50,4), "pt"))
  }

  if (!show_outliers) {
    p <- p + geom_boxplot(outlier.shape = NA)
  }

  p <- p + geom_boxplot(fatten = 1)
  p <- p + stat_summary(fun.y = mean, geom = 'point', shape = 18, size = 2, position = position_dodge(width = 0.75))
  p <- p + coord_fixed(ratio = (xmax - xmin) / (ymax - ymin),
                       xlim = c(xmin, xmax),
                       ylim = c(ymin, ymax),
                       expand = FALSE,
                       clip = "on")
  p <- p + scale_y_continuous(breaks = yaxis)
}
