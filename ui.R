library(shiny)

library(shinydashboard)
library(shinycssloaders)

shinyUI(
    dashboardPage(
        dashboardHeader(title = "TRACE Data Analysis"),

        dashboardSidebar(
            sidebarMenu(
                menuItem("Overview", tabName = "overview", icon = icon("vcard")),
                menuItem("General Analysis", tabName = "generalanalysis", icon = icon("bar-chart")),
                menuItem("Selected Statistics", tabName = "selectedstatistics", icon= icon("bullseye"),
                     menuSubItem("Executing Party Analysis", tabName="exec_party"),
                     menuSubItem("Individual Bond Analysis", tabName="indiv_bond")
                )
            )
        ),

        dashboardBody(
            tabItems(
                tabItem(tabName = "overview",
                    fluidRow(
                        box(img(src="zhaw-logo.png",align="left")
                        
                        )
                    ),
                    fluidRow(
                        box(
                        title=h2("Trace Corporate Bond Dataset"),
                        "This shiny app is part of a student research project at the Institute of Data Analysis and Process Design, ZHAW School of Engineering and aims to visualise a portion of the historic dataset on corporate bonds as published by the FINRA securities self-regulatory
organization. The aim of this study is to identify the existence of systematic biases in the supplied price data, potentially indicating market participants not abiding by the best execution policy."
                        )
                    )
                
                        
                ),
                tabItem(tabName = "generalanalysis",
                    fluidRow(
                        box(withSpinner(plotOutput("plot1", height = 500))),

                        tabBox(
                            title = "Variable Selection",
                            # The id lets us use input$tabset1 on the server to find the current tab
                            id = "db_selected_tab", height = "500",
                            tabPanel("Numeric Variables", 
                                selectInput(
                                    "db_select_num_variable",
                                    label = h3("Choose variable to plot"),
                                    choices = getNumericVariables(trace)
                                ),
                                selectInput(
                                    "db_select_graph",
                                    label = h3("Type of Graph"),
                                    choices = c("Histogram","by date","cumsum","boxplot")
                                ),
                                checkboxInput(
                                    "db_remove_outliers",
                                    label = "Remove Outliers",
                                    TRUE
                                ),
                                sliderInput(
                                    "db_outliers_sd",
                                    label = "SD threshhold",
                                    min = 0,
                                    max = 10,
                                    step = 0.1,
                                    value = 2
                                )
                            ),
                            tabPanel("Categorical Variables",
                                selectInput(
                                    "db_select_cat_variable",
                                    label = h3("Choose variable to plot"),
                                    choices = getCategoricalVariables(trace)
                                )
                                
                            )
                        )
                    )
                ),

            # Second tab content
                tabItem(tabName = "selectedstatistics",
                    h2("Widgets tab content")
                ),

                                tabItem(tabName = "exec_party",
                    fluidRow(
                        box(
                            withSpinner(plotOutput("exec_plot_1", height = 500)),
                            withSpinner(tableOutput("exec_table_1"))
                        ),
                        box(
                            withSpinner(plotOutput("exec_plot_2", height = 500)),
                            withSpinner(tableOutput("exec_table_2"))
                        )
                    ),
                    fluidRow(
                        box(
                            withSpinner(plotOutput("exec_plot_3", height = 500)),
                            withSpinner(tableOutput("exec_table_3"))
                        ),
                        box(
                            withSpinner(plotOutput("exec_plot_4", height = 500)),
                            withSpinner(tableOutput("exec_table_4"))
                        )
                    )
                ),

                 tabItem(tabName = "indiv_bond",
                    fluidRow(
                        box(
                            withSpinner(plotOutput("indiv_plot_1", height = 500)),
                            withSpinner(tableOutput("indiv_table_1"))
                        ),
                        box(
                            withSpinner(plotOutput("indiv_plot_2", height = 500)),
                            withSpinner(tableOutput("indiv_table_2"))
                        )
                    ),
                    fluidRow(
                        box(
                            withSpinner(plotOutput("indiv_plot_3", height = 500)),
                            withSpinner(tableOutput("indiv_table_3"))
                        ),
                        box(
                            withSpinner(plotOutput("indiv_plot_4", height = 500)),
                            withSpinner(tableOutput("indiv_table_4"))
                        )
                    )
                )
            )
        )
    )
)
