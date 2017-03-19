# application specific email handling
# last update: 2017-02-08

setRelationshipEmailStatus <- function(msg){
        output$relationEmailStatus <- renderUI(msg)
}

writeRelationshipEmail <- function(email, person){
        if(validEmail(email)){
                app <- currApp()
                mobile_url <- paste0(
                        mobileUrl, 
                        '?PIA_URL=', piaUrl,
                        '&APP_KEY=', appKey,
                        '&APP_SECRET=', appSecret)
                relationshipEmailText <- paste0(
                        'Bewerte folgende Aspekte für die letzten 7 Tage und verwende dabei ',
                        'jeweils eine Skala von 1 (sehr gut) bis 6 (sehr schlecht):',
                        '<ul><li>Energie</li><li>Gesundheit</li><li>Zufrieden sein</li>',
                        '<li>Entspannung</li><li>Gesamt</li></ul>',
                        '<p>Antworte auf dieses Mail und schreibe in jede Zeile den ',
                        'jeweiligen Wert (1. Zeile: Energie, 2. Zeile: Gesundheit, usw.). ',
                        'Optional kannst du in der 6. Zeile noch einen Freitext zu deiner ',
                        'Beziehung in der letzten Woche eingeben.</p>',
                        '<p>Ebenfalls hast du die Möglichkeit diese <a href="',
                        mobile_url,
                        '">Daten in der Handy-App des Beziehungstrackers zu erfassen</a>.')
                energy_fields <- list(
                        date='Date.now',
                        value='line_1(Integer)')
                health_fields <- list(
                        date='Date.now',
                        value='line_2(Integer)')
                satisfaction_fields <- list(
                        date='Date.now',
                        value='line_3(Integer)')
                relaxation_fields <- list(
                        date='Date.now',
                        value='line_4(Integer)')
                general_fields <- list(
                        date='Date.now',
                        value='line_5(Integer)')
                diary_fields <- list(
                        date='Date.now',
                        value='line_6(String)')
                energy_structure <- list(
                        repo=paste0(energyKey, '_', person),
                        repoName=paste0('Energie #', person),
                        fields=energy_fields)
                health_structure <- list(
                        repo=paste0(healthKey, '_', person),
                        repoName=paste0('Gesundheit #', person),
                        fields=health_fields)
                satisfaction_structure <- list(
                        repo=paste0(satisfactionKey, '_', person),
                        repoName=paste0('Zufrieden #', person),
                        fields=satisfaction_fields)
                relaxation_structure <- list(
                        repo=paste0(relaxKey, '_', person),
                        repoName=paste0('Entspannung #', person),
                        fields=relaxation_fields)
                general_structure <- list(
                        repo=paste0(generalKey, '_', person),
                        repoName=paste0('Gesamt #', person),
                        fields=general_fields)
                diary_structure <- list(
                        repo=paste0(diaryKey, '_', person),
                        repoName=paste0('Notizen #', person),
                        fields=diary_fields)
                response_structure <- list(
                        health_structure,
                        energy_structure,
                        satisfaction_structure,
                        relaxation_structure,
                        general_structure,
                        diary_structure)
                writeSchedulerEmail(
                        app,
                        appTitle,
                        email,
                        'Wie geht es dir - Beziehungstracker',
                        relationshipEmailText,
                        '0 8 * * 0',
                        response_structure)
        } else {
                setRelationshipEmailStatus('Fehler: ungültige Emailadresse, die Eingabe wurde nicht gespeichert')
        }
}

observeEvent(input$saveRelationEmail, {
        relationshipSchedulerItems <- readSchedulerItemsFunction()
        if(nrow(relationshipSchedulerItems) > 0){
                app <- currApp()
                url <- itemsUrl(app[['url']], schedulerKey)
                lapply(relationshipSchedulerItems$id,
                       function(x) deleteItem(app, 
                                              url,
                                              as.character(x)))
        }
        retVal <- writeRelationshipEmail(input$email1, '1')
        retVal <- writeRelationshipEmail(input$email2, '2')
        setRelationshipEmailStatus('wöchentliche Emails werden an die angegenen Adressen versandt')
})

observeEvent(input$cancelRelationEmail, {
        relationshipSchedulerItems <- readSchedulerItemsFunction()
        if(nrow(relationshipSchedulerItems) == 0) {
                setRelationshipEmailStatus('derzeit sind keine wöchentlichen Emails eingerichtet')
                updateTextInput(session, 'email1', value='')
                updateTextInput(session, 'email2', value='')
        } else {
                url <- itemsUrl(app[['url']], schedulerKey)
                lapply(relationshipSchedulerItems$id,
                       function(x) deleteItem(app, 
                                              url,
                                              as.character(x)))
                updateTextInput(session, 'email1', value='')
                updateTextInput(session, 'email2', value='')
                setRelationshipEmailStatus('der Versand wöchentlicher Emails wurde beendet')
        }
})
