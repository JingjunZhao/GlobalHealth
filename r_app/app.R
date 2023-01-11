#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(rsconnect)
library(htmltools)
library(tidyverse)

source("https://raw.githubusercontent.com/JingjunZhao/GlobalHealth/main/r_app/app_server.R")
source("https://raw.githubusercontent.com/JingjunZhao/GlobalHealth/main/r_app/app_ui.R")

# source("../r_app/Gov.exp.server.R")
# source("../source/MMR.R")

# Run the application 
shinyApp(ui = ui, server = server)
