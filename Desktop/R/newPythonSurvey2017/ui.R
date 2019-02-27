
library(shinydashboard)

shinyUI(dashboardPage(
  dashboardHeader(title = "Python Survey 2017"),
  dashboardSidebar(
    
    sidebarUserPanel("Weixing Yang",
                     image = "h1.jpg"),
    sidebarMenu(
      menuItem("Home", tabName = "Home", icon = icon("home")),
      menuItem("Usage", tabName = "Usage", icon = icon("sliders-h")),
      menuItem("Country", tabName = "Country", icon = icon("map")),
      menuItem("Age", tabName = "Age", icon = icon("calendar-alt")),
      menuItem("Language", tabName = "Language", icon = icon("language")),
      menuItem("Purpose", tabName = "Purpose", icon = icon("bullseye")),
      menuItem("Industry", tabName = "Industry", icon = icon("industry"))
    ),
    selectizeInput("selected",
                   "Select Language to Display",
                   choice)
  ),
  dashboardBody(
 #   tags$head(
  #    tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
   # ),
    tabItems(
      tabItem(tabName = "Home",
              fluidRow(
                box(title = "Python User Surver 2017",
                           footer = "Popularity of Python users is rapidly growing all around the world, 
                people from software developer to data scientist use the language to perform different daily tasks. 
                This shiny project is focusing on demonstrating data from survey of Python users on JetBean software, 
                to identify answers to questions including what is the general Python usages? How many Python users in global community?
                What are the age ranges of Python users? What kinds of industries of Python users play roles in?
                what other languages do people use on JetBean beside Python?",width=12)),
              fluidRow(box(img(src = "pic.jpeg", style="width:100%;height:600px;"), width=12))),
      tabItem(tabName = "Usage",
              fluidRow(column(12,plotOutput("usage")))),
      tabItem(tabName = "Language",
              fluidRow(column(12,plotOutput("language")))),
      tabItem(tabName = "Purpose",
              fluidRow(column(12,plotOutput("Purpose"))),hr(),
              fluidRow(column(12,plotOutput("Purpose2")))),
      tabItem(tabName = "Industry",
              fluidRow(column(12,plotOutput("Industry")))),
      tabItem(tabName = "Age",
              fluidRow(column(5,plotOutput("Age")), column(7,plotOutput("Age2")))),
      tabItem(tabName = "Country",
              fluidRow(column(12,plotOutput("Country"), style = "height : 540px")),
              hr(),
              fluidRow(column(12,plotOutput("Country2"))))
    )
  )
))