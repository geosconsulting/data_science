#read.auto <- function(path = 'c:/dat203.1x/mod4/'){
read.auto <- function(path = 'C:/Users/Fabio/Documents/Programmazione/Microsoft/Data Science Essentials/DAT203.1x/Mod4'){
  ## Read the csv file
  filePath <- file.path(path, 'Automobile price data _Raw_.csv')
  auto.price <- read.csv(filePath, header = TRUE, 
                       stringsAsFactors = FALSE)

  ## Coerce some character columns to numeric
  cols <- c('price', 'bore', 'stroke', 
          'horsepower', 'peak.rpm')
  auto.price[, cols] <- lapply(auto.price[, cols], as.numeric)

  ## remove rows with NAs 
  auto.price <- auto.price[complete.cases(auto.price), ]

  ## Add a log transformed column for price
  auto.price$lnprice <- log(auto.price$price)
  
  ## Consolidate the number of cylinders
  auto.price$num.cylinders <- 
    ifelse(auto.price$num.of.cylinders %in% c("four", "three"), "three-four",
           ifelse(auto.price$num.of.cylinders %in% c("five", "six"), "five-six", "eight-twelve"))
  auto.price
}

num.cols <- c("wheel.base",
              "width",
              "height",
              "curb.weight",
              "engine.size",
              "bore",
              "compression.ratio",
              "city.mpg",
              "price",
              "lnprice")


plot.cols2 <- c("length",
               "curb.weight",
               "engine.size",
               "city.mpg",
               "price")

auto.hist <- function(x){
    library(ggplot2)
    library(gridExtra)
    ## Compute the bin width
    rg = range(auto.price[,x])
    bw = (rg[2] - rg[1])/30
    ##Define Title
    title <- paste("Histogram of", x, "conditioned on type of drive wheels")
    ##Create the histogram
    ggplot(auto.price,aes_string(x)) +
      geom_histogram(aes(y=..count..),binwidth = bw) +
      facet_grid(.~ drive.wheels)+
      ggtitle(title)
}

## Function to create conditioned box plots
auto.box <- function(x){
  title <- paste("Box plot of", x, "by type of drive wheels")
  ggplot(auto.price,aes_string('drive.wheels',x)) +
    geom_boxplot() +
    ggtitle(title)  
}

## Define columns for making scatter plots
plot.cols3 <- c("length",
                "curb.weight",
                "engine.size",
                "city.mpg")

## Scatter plot using color to differentiate points
scatter.auto <- function(x){
  require(ggplot2)
  title <- paste("price vs.", x, 'with color by num.cylinders')
  ggplot(auto.price, aes_string(x, 'price')) +
    geom_point(aes(color = factor(num.cylinders))) +
    ggtitle(title)
}

## Scatter plot using color to differentiate points
scatter.auto.cond <- function(x){
  require(ggplot2)
  require(gridExtra)
  title <- paste("price vs.", x, 'with color by num.cylinders and body style')
  ggplot(auto.price, aes_string(x, 'price')) +
    geom_point(aes(color = factor(fuel.type))) +
    facet_grid(body.style ~ num.cylinders) +
    ggtitle(title)
}