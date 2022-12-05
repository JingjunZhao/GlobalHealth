#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
library("knitr")
library("dplyr")
library("tidyverse")
require("viridis")
library("maps")
library("plotly")
library("hrbrthemes")
library("ggplot2")
library(shiny)
library(rsconnect)
library(htmltools)
library("purrr")
source("../r_app/app_ui.R")
source("../r_app/app_server.R")

# source("../r_app/Gov.exp.server.R")
# source("../source/MMR.R")
viridis::unemp
maps::map
# Run the application 
shinyApp(ui = ui, server = server)
