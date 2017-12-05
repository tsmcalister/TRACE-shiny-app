library(shiny)
library(quantmod)

shinyServer(function(input, output) {

    output$plot1 <- renderPlot({

        # determine which tab is selected
        # -> Numeric Variables
        if(input$db_selected_tab == "Numeric Variables")
        {
            # load data and corresponding dates
            data <- trace[,input$db_select_num_variable]
            dates <- trace$date
            # outlier removal
            if(input$db_remove_outliers)
            {
                filter <- abs(data - mean(data)) < sd(data) * input$db_outliers_sd
                data <- data[filter]
                dates <- dates[filter]
            }

            # deciding which graph to plot
            if(input$db_select_graph == "Histogram")
            {
                hist(data,breaks=)
            }
            else if(input$db_select_graph == "by date")
            {
                plot(as.Date(dates),data)
            }
            else if(input$db_select_graph == "cumsum")
            {
                plot(cumsum(sort(data,decreasing = T) / sum(data)))
            }
        }
        # -> Categorical Variables
        else if(input$db_selected_tab == "Categorical Variables")
        {
            data <- trace[,input$db_select_cat_variable]
            barplot(sort(table(data),decreasing = T),col=rainbow(length(table(data))))
        }

    })
})