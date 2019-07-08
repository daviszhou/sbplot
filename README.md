# sbplot (Square Boxplot)

## Overview
This is a basic function to create R ggplot2 boxplots with square axes. The 1:1 length ratio of the y-axis and x-axis is preserved even after grouping multiple graphs using facets. Users can define the y axis range and intervals.

## Dependencies
This packages requires ggplot2
```
install.packages("ggplot2")
```

## Installation
Install using following commands:
```
library(devtools)
devtools::install_github("daviszhou/sbplot")
```

## Usage
```
library(sbplot)

xaxis = c('Group1', 'Group1')
ymin = 0
ymax = 1
yinterval = 0.5
yaxis = seq(ymin, ymax, yinterval)
                              
p <- boxplot_square_axis(data, title, xaxis_category, yaxis_category, xaxis, yaxis,
  custom_whiskers=TRUE,
  color_category=NULL,
  color_scale=NULL,
  color_labels=NULL,
  change_fill_color=TRUE,
  font_size=10)
```
