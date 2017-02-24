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
        schedulerEmail <- getPiaSchedulerEmail(app)
        if(length(schedulerEmail) == 0) {
                setRelationshipEmailStatus('Status: derzeit sind wöchentliche Emails nicht eingerichtet')
                updateTextInput(session, 'email1', value='')
                updateTextInput(session, 'email2', value='')
        } else {
                updateTextInput(session, 'email1', 
                                value='')
                setRelationshipEmailStatus('Status: wöchentliche Emails werden an die beiden angegebene Adresse versandt')
        }
}