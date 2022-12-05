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
library("plotly")
library("hrbrthemes")
library("ggplot2")
library(shiny)
library(rsconnect)
library(htmltools)
library(shinyWidgets)
library("maps")
source("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-af/main/r_app/app_ui.R")
source("https://raw.githubusercontent.com/info201a-au2022/project-group-1-section-af/main/r_app/app_server.R")

# source("../r_app/Gov.exp.server.R")
# source("../source/MMR.R")

# Run the application 
shinyApp(ui = ui, server = server)
