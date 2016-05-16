# Setup and config ========================================
library(shiny)
library(shinyBS) #https://ebailey78.github.io/shinyBS/index.html
library(jsonlite)

source("oyd_helpers.R")

saved <- getPiaConnection('relshp')
saved_url        <- saved[['url']]
saved_app_key    <- saved[['app_key']]
saved_app_secret <- saved[['app_secret']]

# Shiny UI ================================================
shinyUI(fluidPage(
  titlePanel("Beziehungsstatus"),
  bsAlert("topAlert"),
  sidebarLayout(
    sidebarPanel(
            tabsetPanel(type='tabs', selected='Beziehungsstatus',
# Relationship specific ===========================================
                        tabPanel('Beziehungsstatus',
                                 h3('Anzeige'),
                                 dateRangeInput('dateRange',
                                                language = 'de',
                                                separator = ' bis ',
                                                format = 'dd.mm.yyyy',
                                                label = 'Zeitfenster',
                                                start = Sys.Date() - 365, end = Sys.Date()),
                                 hr(),
                                 h3('Daten eingeben'),
                                 dateInput('manDate',
                                           language = 'de',
                                           format = 'dd.mm.yyyy',
                                           label = 'Datum'),
                                 h4('Allgemein'),
                                 tags$table(style='width:100%',
                                            tags$tr(tags$td(checkboxInput('useGeneral1', label = 'Person #1', value = TRUE, width='100px')),
                                                    tags$td(sliderInput('manGeneral1', NULL, value=5, min=1, max=10), style='width:100%')),
                                            tags$tr(tags$td(checkboxInput('useGeneral2', label = 'Person #2', value = TRUE, width='100px')),
                                                    tags$td(sliderInput('manGeneral2', NULL, value=5, min=1, max=10), style='width:100%'))),
                                 h4('Energie'),
                                 tags$table(style='width:100%',
                                            tags$tr(tags$td(checkboxInput('useEnergy1', label = 'Person #1', value = TRUE, width='100px')),
                                                    tags$td(sliderInput('manEnergy1', NULL, value=5, min=1, max=10), style='width:100%')),
                                            tags$tr(tags$td(checkboxInput('useEnergy2', label = 'Person #2', value = TRUE, width='100px')),
                                                    tags$td(sliderInput('manEnergy2', NULL, value=5, min=1, max=10), style='width:100%'))),
                                 h4('Gesundheit'),
                                 tags$table(style='width:100%',
                                            tags$tr(tags$td(checkboxInput('useHealth1', label = 'Person #1', value = TRUE, width='100px')),
                                                    tags$td(sliderInput('manHealth1', NULL, value=5, min=1, max=10), style='width:100%')),
                                            tags$tr(tags$td(checkboxInput('useHealth2', label = 'Person #2', value = TRUE, width='100px')),
                                                    tags$td(sliderInput('manHealth2', NULL, value=5, min=1, max=10), style='width:100%'))),
                                 h4('Zufriedenheit'),
                                 tags$table(style='width:100%',
                                            tags$tr(tags$td(checkboxInput('useSatisfaction1', label = 'Person #1', value = TRUE, width='100px')),
                                                    tags$td(sliderInput('manSatisfaction1', NULL, value=5, min=1, max=10), style='width:100%')),
                                            tags$tr(tags$td(checkboxInput('useSatisfaction2', label = 'Person #2', value = TRUE, width='100px')),
                                                    tags$td(sliderInput('manSatisfaction2', NULL, value=5, min=1, max=10), style='width:100%'))),
                                 h4('Entspannung'),
                                 tags$table(style='width:100%',
                                            tags$tr(tags$td(checkboxInput('useRelaxation1', label = 'Person #1', value = TRUE, width='100px')),
                                                    tags$td(sliderInput('manRelaxation1', NULL, value=5, min=1, max=10), style='width:100%')),
                                            tags$tr(tags$td(checkboxInput('useRelaxation2', label = 'Person #2', value = TRUE, width='100px')),
                                                    tags$td(sliderInput('manRelaxation2', NULL, value=5, min=1, max=10), style='width:100%'))),
                                 actionButton('exportButton', 'Speichern'),
                                 htmlOutput('last_saved')
                        ),

# PIA =====================================================
                        tabPanel("PIA", 
                            h3('Authentifizierung'),
                            textInput('relshp_url', 'Adresse:', saved_url),
                            textInput('relshp_app_key', 'ID (Beziehungsstatus):', saved_app_key),
                            textInput('relshp_app_secret', 'Secret (Beziehungsstatus):', saved_app_secret),
                            checkboxInput("localRelshpSave", label = "Zugriffsinformationen lokal speichern", value = FALSE),
                            hr(),
                            htmlOutput("relshp_token"),
                            htmlOutput("relshp_records")
                        ),

# Scheduler ===============================================
                        tabPanel("Benachrichtigung", 
                                 h3('Benachrichtigung'),
                                 textInput('email1', 'Emailadresse für Person #1:'),
                                 textInput('email2', 'Emailadresse für Person #2:'),
                                 htmlOutput("email_status"),
                                 helpText('Wenn sie hier ihre Emailadressen eingeben, erhalten beide Teilnehmer jedes Wochenende eine Email mit den 5 Fragen.'),
                                 hr(),
                                 h3('Email Konfiguration'),
                                 htmlOutput("mail_config"),
                                 textInput('mailer_address', 'Mail Server:'),
                                 numericInput('mailer_port', 'Port:', 0),
                                 textInput('mailer_user', 'Benutzer:'),
                                 passwordInput('mailer_password', 'Passwort')
                        )
            )
    ),

# Main Panel ==============================================
    mainPanel(
            bsAlert("noData"),
            tabsetPanel(type="tabs",
                        tabPanel("Allgemein", 
                                 plotOutput(outputId = "plotGeneral", height = "300px")),
                        tabPanel("Energie", 
                                 plotOutput(outputId = "plotEnergy", height = "300px")),
                        tabPanel("Gesundheit", 
                                 plotOutput(outputId = "plotHealth", height = "300px")),
                        tabPanel("Zufriedenheit", 
                                 plotOutput(outputId = "plotSatisfaction", height = "300px")),
                        tabPanel("Entspannung", 
                                 plotOutput(outputId = "plotRelaxation", height = "300px"))
            ),
            bsAlert("noPIA")
    )
  )
))
