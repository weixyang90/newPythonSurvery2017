
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
              h2("Python User Surver 2017", align="center", style = "color : #1E90FF"),
              p("Popularity of Python users is rapidly growing all around the world, 
                people from software developer to data scientist use the language to perform different daily tasks. 
                This shiny project is focusing on demonstrating data from survey of Python users on JetBean software, 
                including the general Python usages, Python users in global community, age ranges of Python users, 
                industries of Python users, what other languages do people use on JetBean.",align="center", 
                style = "color : #FF7F50; font-size: 20px"),
              hr(),
              img(src = "pic.jpeg", style="width:100%;height:600px;")),
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
              fluidRow(column(12,plotOutput("Country"))),
              hr(),
              fluidRow(column(12,plotOutput("Country2"))))
    )
  )
))