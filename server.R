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
            else if(input$db_select_graph == "boxplot")
            {
                boxplot(data)
            }
        }
        # -> Categorical Variables
        else if(input$db_selected_tab == "Categorical Variables")
        {
            data <- trace[,input$db_select_cat_variable]
            barplot(sort(table(data),decreasing = T),col=rainbow(length(table(data))))
        }

    })

    ##############################
    ## Ececuting Party Tab
    ##############################

    output$exec_plot_1 <- renderPlot({
        data <- aggregate(trace$ENTRD_VOL_QT, 
                             by=list(Dealers = trace$RPTG_PARTY_GVP_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        plot((cumsum(sortdata$x)/sum(sortdata$x))[1:100],main = "Entered volume vs. reporting side give up participant identifier",
    ylab = "Probability",type="o")
    })

    output$exec_table_1 <- renderTable({
        data <- aggregate(trace$ENTRD_VOL_QT, 
                             by=list(Dealers = trace$RPTG_PARTY_GVP_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        select <- cumsum(sortdata$x)/sum(sortdata$x)
        filter <- select < 0.9

        thresholds <- c(0.5,0.9,0.99)
        values <- c()

        for(i in 1:length(thresholds))
        {
            filter <- select > thresholds[i]
            values <- c(values,min(which(filter == TRUE)))
        }

        data.frame(thresholds,values)
    })



    output$exec_plot_2 <- renderPlot({
        data <- aggregate(trace$ENTRD_VOL_QT, 
                             by=list(Dealers = trace$RPTG_PARTY_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        plot((cumsum(sortdata$x)/sum(sortdata$x))[1:100],main = "Entered volume vs. reporting market participant identifier",
    ylab = "Probability",type="o")
    })

    output$exec_table_2 <- renderTable({
        data <- aggregate(trace$ENTRD_VOL_QT, 
                             by=list(Dealers = trace$RPTG_PARTY_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        select <- cumsum(sortdata$x)/sum(sortdata$x)
        filter <- select < 0.9

        thresholds <- c(0.5,0.9,0.99)
        values <- c()

        for(i in 1:length(thresholds))
        {
            filter <- select > thresholds[i]
            values <- c(values,min(which(filter == TRUE)))
        }

        data.frame(thresholds,values)
    })

    output$exec_plot_3 <- renderPlot({
        data <- aggregate(trace$RPTD_PR, 
                             by=list(Dealers = trace$RPTG_PARTY_GVP_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        plot((cumsum(sortdata$x)/sum(sortdata$x))[1:100],main = "Reported price vs. reporting side give up participant identifier",
    ylab = "Probability",type="o")
    })

    output$exec_table_3 <- renderTable({
        data <- aggregate(trace$RPTD_PR, 
                             by=list(Dealers = trace$RPTG_PARTY_GVP_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        select <- cumsum(sortdata$x)/sum(sortdata$x)
        filter <- select < 0.9

        thresholds <- c(0.5,0.9,0.99)
        values <- c()

        for(i in 1:length(thresholds))
        {
            filter <- select > thresholds[i]
            values <- c(values,min(which(filter == TRUE)))
        }

        data.frame(thresholds,values)
    })

    output$exec_plot_4 <- renderPlot({
        data <- aggregate(trace$RPTD_PR, 
                             by=list(Dealers = trace$RPTG_PARTY_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        plot((cumsum(sortdata$x)/sum(sortdata$x))[1:100],main = "Reported price vs. reporting market participant identifier",
    ylab = "Probability",type="o")
    })

    output$exec_table_4 <- renderTable({
        data <- aggregate(trace$RPTD_PR, 
                             by=list(Dealers = trace$RPTG_PARTY_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        select <- cumsum(sortdata$x)/sum(sortdata$x)
        filter <- select < 0.9

        thresholds <- c(0.5,0.9,0.99)
        values <- c()

        for(i in 1:length(thresholds))
        {
            filter <- select > thresholds[i]
            values <- c(values,min(which(filter == TRUE)))
        }

        data.frame(thresholds,values)
    })


    ##############################
    ## Individual Bonds Tab
    ##############################

    output$indiv_plot_1 <- renderPlot({
        data <- aggregate(trace$ENTRD_VOL_QT, 
                             by=list(Dealers = trace$CUSIP_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        plot((cumsum(sortdata$x)/sum(sortdata$x))[1:100],main = "Entered volume vs. CUSIP",
    ylab = "Probability",type="o")
    })

    output$indiv_table_1 <- renderTable({
        data <- aggregate(trace$ENTRD_VOL_QT, 
                             by=list(Dealers = trace$CUSIP_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        select <- cumsum(sortdata$x)/sum(sortdata$x)
        filter <- select < 0.9

        thresholds <- c(0.5,0.9,0.99)
        values <- c()

        for(i in 1:length(thresholds))
        {
            filter <- select > thresholds[i]
            values <- c(values,min(which(filter == TRUE)))
        }

        data.frame(thresholds,values)
    })

    output$indiv_plot_2 <- renderPlot({
        data <- aggregate(trace$ENTRD_VOL_QT, 
                             by=list(Dealers = trace$ISSUE_SYM_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        plot((cumsum(sortdata$x)/sum(sortdata$x))[1:100],main = "Entered volume vs. TRACE Symbol",
    ylab = "Probability",type="o")
    })

     output$indiv_table_2 <- renderTable({
        data <- aggregate(trace$ENTRD_VOL_QT, 
                             by=list(Dealers = trace$ISSUE_SYM_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        select <- cumsum(sortdata$x)/sum(sortdata$x)
        filter <- select < 0.9

        thresholds <- c(0.5,0.9,0.99)
        values <- c()

        for(i in 1:length(thresholds))
        {
            filter <- select > thresholds[i]
            values <- c(values,min(which(filter == TRUE)))
        }

        data.frame(thresholds,values)
    })

    output$indiv_plot_3 <- renderPlot({
        data <- aggregate(trace$RPTD_PR, 
                             by=list(Dealers = trace$CUSIP_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        plot((cumsum(sortdata$x)/sum(sortdata$x))[1:100],main = "Reported price vs. CUSIP",
    ylab = "Probability",type="o")
    })

    output$indiv_table_3 <- renderTable({
        data <- aggregate(trace$RPTD_PR, 
                             by=list(Dealers = trace$CUSIP_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        select <- cumsum(sortdata$x)/sum(sortdata$x)
        filter <- select < 0.9

        thresholds <- c(0.5,0.9,0.99)
        values <- c()

        for(i in 1:length(thresholds))
        {
            filter <- select > thresholds[i]
            values <- c(values,min(which(filter == TRUE)))
        }

        data.frame(thresholds,values)
    })

    output$indiv_plot_4 <- renderPlot({
        data <- aggregate(trace$RPTD_PR, 
                             by=list(Dealers = trace$ISSUE_SYM_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        plot((cumsum(sortdata$x)/sum(sortdata$x))[1:100],main = "Reported price vs. TRACE Symbol",
    ylab = "Probability",type="o")
    })

    output$indiv_table_4 <- renderTable({
        data <- aggregate(trace$RPTD_PR, 
                             by=list(Dealers = trace$ISSUE_SYM_ID),
                             FUN=sum)
        sortdata <- data[order(-data$x),]

        select <- cumsum(sortdata$x)/sum(sortdata$x)
        filter <- select < 0.9

        thresholds <- c(0.5,0.9,0.99)
        values <- c()

        for(i in 1:length(thresholds))
        {
            filter <- select > thresholds[i]
            values <- c(values,min(which(filter == TRUE)))
        }

        data.frame(thresholds,values)
    })
})