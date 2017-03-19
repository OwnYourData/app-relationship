# application specific logic
# last update: 2017-02-13

source('srvDateselect.R', local=TRUE)
source('srvEmail.R', local=TRUE)
source('appEmail.R', local=TRUE)
source('srvScheduler.R', local=TRUE)

# any record manipulations before storing a record
appData <- function(record){
        record
}

getRepoStruct <- function(repo){
        appStruct[[repo]]
}

repoData <- function(repo){
        data <- data.frame()
        app <- currApp()
        if(length(app) > 0){
                url <- itemsUrl(app[['url']],
                                repo)
                data <- readItems(app, url)
        }
        data
}

# anything that should run only once during startup
appStart <- function(){
        app <- currApp()
        if(length(app) > 0){
                url <- itemsUrl(app[['url']], schedulerKey)
                retVal <- readItems(app, url)
                retVal <- retVal[retVal$app == app[['app_key']] &
                                         retVal$task == 'email', ]
                if((length(retVal) == 0) |
                   (nrow(retVal) == 0)){
                        setRelationshipEmailStatus('Status: derzeit sind wöchentliche Emails nicht eingerichtet')
                        updateTextInput(session, 'email1', value='')
                        updateTextInput(session, 'email2', value='')
                } else {
                        updateTextInput(session, 'email1', value=retVal$parameters[[2]]$address)
                        updateTextInput(session, 'email2', value=retVal$parameters[[1]]$address)
                        setRelationshipEmailStatus('Status: wöchentliche Emails werden an die beiden angegebene Adresse versandt')
                }
        }
}

observeEvent(input$saveRelationInput, {
        app <- currApp()
        if(length(app) > 0){
                personNo <- input$personSelect
                # Energy
                url <- itemsUrl(app[['url']],
                                paste0(app[['app_key']], 
                                       '.energy_',
                                       personNo))
                data <- list(
                        date = as.character(input$dateInput),
                        value = input$energyInput,
                        '_oydRepoName' = paste0('Energie #', personNo))
                writeItem(app, url, data)
                
                # Health
                url <- itemsUrl(app[['url']],
                                paste0(app[['app_key']], 
                                       '.health_',
                                       personNo))
                data <- list(
                        date = as.character(input$dateInput),
                        value = input$healthInput,
                        '_oydRepoName' = paste0('Gesundheit #', personNo))
                writeItem(app, url, data)
                
                # Satisfaction
                url <- itemsUrl(app[['url']],
                                paste0(app[['app_key']], 
                                       '.satisfaction_',
                                       personNo))
                data <- list(
                        date = as.character(input$dateInput),
                        value = input$satisfactionInput,
                        '_oydRepoName' = paste0('Zufrieden #', personNo))
                writeItem(app, url, data)
                
                # Relaxation
                url <- itemsUrl(app[['url']],
                                paste0(app[['app_key']], 
                                       '.relax_',
                                       personNo))
                data <- list(
                        date = as.character(input$dateInput),
                        value = input$relaxInput,
                        '_oydRepoName' = paste0('Entspannung #', personNo))
                writeItem(app, url, data)
                
                # General
                url <- itemsUrl(app[['url']],
                                paste0(app[['app_key']], 
                                       '.general_',
                                       personNo))
                data <- list(
                        date = as.character(input$dateInput),
                        value = input$generalInput,
                        '_oydRepoName' = paste0('Gesamt #', personNo))
                writeItem(app, url, data)
                
                # Note
                if(!is.na(input$noteInput) &
                   (nchar(as.character(input$noteInput)) > 0)){
                        url <- itemsUrl(app[['url']],
                                        paste0(app[['app_key']], 
                                               '.diary_',
                                               personNo))
                        data <- list(
                                date = as.character(input$dateInput),
                                value = input$noteInput,
                                '_oydRepoName' = paste0('Notizen #', personNo))
                        writeItem(app, url, data)
                }
        }
        output$relationInputStatus <- renderUI('Daten wurden erfolgreich gespeichert')
})

dateRangeSelect <- function(data){
        if(nrow(data) > 0){
                mymin <- as.Date(input$dateRange[1])
                mymax <- as.Date(input$dateRange[2])
                daterange <- seq(mymin, mymax, 'days')
                data[as.Date(data$date) %in% daterange, ]
        } else {
                data.frame()
        }
}

output$relationGraph <- renderPlotly({
        data1 <- repoData(paste0(appKey, '.', 
                                 input$topicSelect, '_1'))
        data1 <- dateRangeSelect(data1)
        if(nrow(data1) > 0){
                data1$marker_size <- 6
                data1Note <- repoData(paste0(appKey, '.diary_1'))
                data1Note <- dateRangeSelect(data1Note)
                if(nrow(data1Note) > 0){
                        data1Note <- data1Note[, c('date', 'value')]
                        colnames(data1Note) <- c('date', 'note')
                        data1 <- merge(data1, data1Note, by='date', all=TRUE)
                        data1[!is.na(data1$note), 'marker_size'] <- 10
                }
                data1$value <- as.numeric(data1$value)
                data1 <- data1[!is.na(data1$value), ]
        }
        
        data2 <- repoData(paste0(appKey, '.', 
                                 input$topicSelect, '_2'))
        data2 <- dateRangeSelect(data2)
        if(nrow(data2) > 0){
                data2$marker_size <- 6
                data2Note <- repoData(paste0(appKey, '.diary_2'))
                data2Note <- dateRangeSelect(data2Note)
                if(nrow(data2Note) > 0){
                        data2Note <- data2Note[, c('date', 'value')]
                        colnames(data2Note) <- c('date', 'note')
                        data2 <- merge(data2, data2Note, by='date', all=TRUE)
                        data2[!is.na(data2$note), 'marker_size'] <- 10
                }
                data2$value <- as.numeric(data2$value)
                data2 <- data2[!is.na(data2$value), ]
        }

        pdf(NULL)
        outputPlot <- plotly_empty()
        if((nrow(data1) > 0) |
           (nrow(data2) > 0)){
                outputPlot <- plot_ly() %>%
                        add_lines(x = as.Date(data1$date),
                                  y = data1$value,
                                  line = list(
                                          color = 'blue',
                                          width = 2,
                                          shape = 'spline'),
                                  name = 'Person #1') %>%
                        add_markers(x = as.Date(data1$date),
                                    y = data1$value,
                                    marker = list(
                                            color='blue',
                                            size = data1$marker_size),
                                    text = data1$note,
                                    name = '', 
                                    showlegend = FALSE) %>%
                        add_lines(x = as.Date(data2$date),
                                  y = data2$value,
                                  line = list(
                                          color = 'orange',
                                          width = 2,
                                          shape = 'spline'),
                                  name = 'Person #2') %>%
                        add_markers(x = as.Date(data2$date),
                                    y = data2$value,
                                    marker = list(
                                            color='orange',
                                            size = data2$marker_size),
                                    name = '', 
                                    showlegend = FALSE) %>%
                        layout( xaxis = list(type = 'date',
                                             tickformat = '%Y-%m-%d'),
                                yaxis = list(range = c(0.5, 6.5),
                                             title = '< schlechter - besser >'))
        }
        dev.off()
        outputPlot
})