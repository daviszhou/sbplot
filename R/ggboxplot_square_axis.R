#' A plotting function using ggplot2
#'
#' This function allows easier creation of square with custom axes ranges.
#'
boxplot_square_axis <- function(data, title, xaxis_category, yaxis_category, xaxis, yaxis,
                                custom_whiskers=NULL,
                                color_category=NULL,
                                color_scale=NULL,
                                color_labels=NULL,
                                change_fill_color=TRUE,
                                font_size=10) {

  boxplot_percentiles = c(custom_whiskers[1], 0.25, 0.5, 0.75, custom_whiskers[2])

  xaxis_category_factors <- paste('factor(', xaxis_category, ')', sep = '' )
  color_category_factors <- paste('factor(', color_category, ')', sep= '')

  number_factors <- length(unique(data[[xaxis_category]]))
  if (number_factors <= 2) {
    xmin <- 0.15
    xmax <- number_factors + 0.85
  } else {
    xmin <- 0.25
    xmax <- number_factors + 0.75
  }

  yaxis_edge_padding <- max(yaxis) / 30
  ymin <- min(yaxis) - yaxis_edge_padding
  ymax <- max(yaxis) + yaxis_edge_padding

  if (!is.null(color_category)) {
    if (change_fill_color) {
      p <- ggplot(data, aes_string(x = xaxis_category_factors, y = yaxis_category, fill = color_category_factors))
      p <- p + scale_fill_manual(values=color_scale, labels=color_labels)
    } else {
      p <- ggplot(data, aes_string(x = xaxis_category_factors, y = yaxis_category, color = color_category_factors))
      p <- p + scale_color_manual(values=color_scale, labels=color_labels)
    }
    p <- p + scale_color_discrete(name = element_blank(), labels = c('OD', 'OS'))
  } else if (is.null(color_category)) {
    p <- ggplot(data, aes_string(x = xaxis_category_factors, y = yaxis_category))
  } else {
    stop("ERROR: Please enter 'TRUE' or 'FALSE' to specify whether to plot both eyes")
  }

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

  if (custom_whiskers) {
    make_custom_quartiles <- function(x) {
      q <- quantile(x, probs = boxplot_percentiles)
      names(q) <- c('ymin', 'lower', 'middle', 'upper', 'ymax')
      return(q)
    }
    p <- p + stat_summary(fun.data=make_custom_quartiles, geom="errorbar", width = 0.5, position = position_dodge(width = 0.75)) # creates boxplot whiskers
    p <- p + stat_summary(fun.data=make_custom_quartiles, fatten = 1, geom="boxplot", width = 0.6, position = position_dodge(width = 0.75)) # creates boxplots
  } else {
    p <- p + stat_boxplot(geom = 'errorbar', width = 0.5, position = position_dodge(width = 0.75)) # create boxplot whiskers
    p <- p + geom_boxplot(fatten = 1, outlier.shape = NA) # creates boxplots
  }

  p <- p + stat_summary(fun.y = mean, geom = 'point', shape = 18, size = 2, position = position_dodge(width = 0.75))
  p <- p + coord_fixed(ratio = (xmax - xmin) / (ymax - ymin),
                       xlim = c(xmin, xmax),
                       ylim = c(ymin, ymax),
                       expand = FALSE,
                       clip = "on")
  p <- p + scale_y_continuous(breaks = yaxis)
  return(p)
}
