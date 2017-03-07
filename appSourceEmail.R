# ui for setting up emails
# last update: 2017-03-06

appSourceEmail <- function(){
        tabPanel('Email', br(),
                 fluidRow(
                         column(2,
                                img(src='email.png',width='100px')),
                         column(10,
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
}