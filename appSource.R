# layout for section "Source"
# last update: 2016-10-06

# source("uiSourceItemConfig.R")

appSource <- function(){
        fluidRow(
                column(12,
                       # uiOutput('desktopUiSourceItemsRender')
                       tabsetPanel(
                               type='tabs',
                               tabPanel('Email', br(),
                                        helpText('Trage hier die Emailadressen der beiden Personen ein, die den Beziehungstracker nutzen möchten.'),
                                        textInput('email1', 'Emailadresse für Person #1:'),
                                        textInput('email2', 'Emailadresse für Person #2:'),
                                        actionButton('saveRelationEmail', 'Speichern',
                                                     icon('save')),
                                        actionButton('cancelRelationEmail', 
                                                     'Emailversand beenden',
                                                     icon('trash')),
                                        br(), br(), uiOutput('relationEmailStatus')
                                        
                               )
                       )
                )
        )
}

# constants for configurable Tabs
# defaultSrcTabsName <- c('SrcTab1', 'SrcTab2')
# 
# defaultSrcTabsUI <- c(
#         "
#         tabPanel('SrcTab1',
#                 textInput(inputId=ns('defaultSourceInput1'), 
#                         'Eingabe1:'),
#                 htmlOutput(outputId = ns('defaultSourceItem1'))
#         )
#         ",
#         "
#         tabPanel('SrcTab2',
#                 textInput(inputId=ns('defaultSourceInput2'), 
#                         'Eingabe2:'),
#                 htmlOutput(outputId = ns('defaultSourceItem2'))
#         )
#         "
# )
# 
# defaultSrcTabsLogic <- c(
#         "
#         output$defaultSourceItem1 <- renderUI({
#                 input$defaultSourceInput1
#         })
#         ",
#         "
#         output$defaultSourceItem2 <- renderUI({
#                 input$defaultSourceInput2
#         })
#         "
# )
