# ui for adding new data
# last update: 2017-03-06

appSourceInput <- function(){
        tabPanel('Datenerfassung', br(),
                 fluidRow(
                         column(2,
                                img(src='write.png',
                                    width='70px',
                                    style='margin-left:40px;')),
                         column(10,
                                helpText('Erfasse hier einen neuen Eintrag im Beziehungsracker.'),
                                selectInput('personSelect', 
                                            label = 'Auswahl',
                                            choices = list('Person #1'=1, 'Person #2'=2),
                                            selected = 1),
                                dateInput('dateInput',
                                          label = 'Datum',
                                          language = 'de'),
                                numericInput('energyInput',
                                             label = 'Energie',
                                             value = 4,
                                             min = 1, max = 6, step = 1),
                                numericInput('healthInput',
                                             label = 'Gesundheit',
                                             value = 4,
                                             min = 1, max = 6, step = 1),
                                numericInput('satisfactionInput',
                                             label = 'Zufriedenheit',
                                             value = 4,
                                             min = 1, max = 6, step = 1),
                                numericInput('relaxInput',
                                             label = 'Entspannung',
                                             value = 4,
                                             min = 1, max = 6, step = 1),
                                numericInput('generalInput',
                                             label = 'Gesamt',
                                             value = 4,
                                             min = 1, max = 6, step = 1),
                                tags$label('Anmerkung:'),
                                br(),
                                tags$textarea(id='noteInput',
                                              rows=2, cols=80,
                                              ''),
                                br(),br(),
                                actionButton('saveRelationInput', 'Speichern',
                                             icon('save')),
                                br(), br(), uiOutput('relationInputStatus')
                         )
                 )
        )
}