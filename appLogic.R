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
                if(length(retVal) == 0) {
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