# global constants available to the app
# last update:2016-01-17

# constants required for every app
appName <- 'relationship'
appTitle <- 'Beziehungstracker'
app_id <- 'eu.ownyourdata.relationship'

# definition of data structure
currRepoSelect <- ''
appRepos <- list(Vorlage = 'eu.ownyourdata.relationship',
                 Verlauf = 'eu.ownyourdata.relationship.log')
appStruct <- list(
        Vorlage = list(
                fields      = c('text'),
                fieldKey    = 'text',
                fieldTypes  = c('string'),
                fieldInits  = c('empty'),
                fieldTitles = c('Text'),
                fieldWidths = c(600)),
        Verlauf = list(
                fields      = c('date', 'description'),
                fieldKey    = 'date',
                fieldTypes  = c('date', 'string'),
                fieldInits  = c('empty', 'empty'),
                fieldTitles = c('Datum', 'Text'),
                fieldWidths = c(150, 450)))

# Version information
currVersion <- "0.3.0"
verHistory <- data.frame(rbind(
        c(version = "0.3.0",
          text    = "erstes Release")
))

# app specific constants
relationshipEmailText <- 'Bewerte folgende Aspekte für die letzten 7 Tage und verwende dabei jeweils eine Skala von 1 (sehr gut) bis 6 (sehr schlecht):
<ul><li>Energie</li><li>Gesundheit</li><li>Zufrieden sein</li><li>Entspannung</li><li>Gesamt</li></ul>
<p>Antworte auf dieses Mail und schreibe in jede Zeile den jeweiligen Wert (1. Zeile: Energie, 2. Zeile: Gesundheit, usw.). Optional kannst du in der 6. Zeile noch einen Freitext zu deiner Beziehung in der letzten Woche eingeben.</p>'

energyKey <- paste0(app_id, '.energy')
healthKey <- paste0(app_id, '.health')
satisfactionKey <- paste0(app_id, '.satisfaction')
relaxKey <- paste0(app_id, '.relax')
generalKey <- paste0(app_id, '.general')
diaryKey <- paste0(app_id, '.diary')