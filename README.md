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
The main function is boxplot_square_axis(), which returns a plot object. Example usage:
```
library(sbplot)

xaxis = c('Controls', 'Study Group')
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
Function Arguments:
* `data`: Data frame containing desired variables.
* `title`: Graph title.
* `xaxis_category`: Name of data frame column that contains the factors for x-axis categories.
* `yaxis_category`: Name of data frame column that contains values for the y-axis.
* `xaxis`: Custom labels for the x-axis. Set using `xaxis = c('X Group 1', 'X Group 2')`.
* `yaxis`: Specify the range and interval of the y-axis. Set using `yaxis = seq(y_min, y_max, y_interval)`.
* `custom_whiskers`: Specifies how to plot whiskers. Set as "FALSE" for the traditional method, which uses the largest value within 1.5*IQR from the upper and lower hinges of the boxplot. Set as "TRUE" for the custom method, which uses the 10th and 90th percentiles. By default set to "TRUE". [OPTIONAL]
* `color_category`: Name of the data frame column that contains the factors used to separate groups by boxplot color. To plot without subcategories sorted by color, set variable as "NULL". [OPTIONAL]
* `color_labels`: Vector of color category subgroup names. Set using `color_labels = c("Color Group 1", "Color Group 2")`. By default will use data frame factor names. [OPTIONAL] 
* `change_fill_color`: Determines whether to change the boxplot fill or line color if color_category is provided. By defualt set to "TRUE" to change the fill color.
* `font_size`: Integer to determine text size of the title, axes, and axes labels.
