# Beziehungsstatus
Der [OwnYourData](https://www.ownyourdata.eu) Beziehungsstatus

## Installation

Die App kann gratis über den offiziellen [OwnYourData SAM](http://oyd-sam.herokuapp.com) (Store for Algorithms) installiert werden. Klicke dazu in der PIA App-Liste "Plugin installieren" und wähle "Beziehungs-Status" (ID: eu.ownyourdata.relationship) aus.

Die Beziehungsstatus-App benötigt das Shiny-Host-Service (ebenfalls verfügbar am OwnYourData SAM, ID: eu.ownyourdata.shinyhost) und [Docker](https://www.docker.com/) installiert.


## Verwendung

Die App umfasst folgende Funktionen:

* tägliche Datenerfassung
* Visualisierung der vorhandenen Daten zur Identifikation von Zusammenhängen
* Einschränkung der Darstellung auf ein bestimmtes Zeitfenster
* optional: automatisierte Datensammlung
* optional: wöchentliche Emails die eigenes Befinden und Medikamenteneinnahme abfragen


## Für Entwickler  

Diese App wurde in [R](https://cran.r-project.org/) entwickelt und verwendet [Shiny](http://shiny.rstudio.com/). Zur Ausführung wird entweder das OwnYourData Shiny Service benötigt (siehe oben: Installation) oder es existiert ein bereits [installierter Shiny Server](https://github.com/rstudio/shiny-server/wiki/Building-Shiny-Server-from-Source). Wird ein eigener Shiny Server betrieben, kann in der PIA App-Liste mit "Register a new Plugin" das Manifest base64-encodiert hinzugefügt werden (angegeben am Beginn der Datei `server.R`) und in der App unter Konfiguration müssen die Parameter URL, App-Key und App-Secret selbst gesetzt werden.  
Zum Ausprobieren kann die App auf [Heroku](https://www.heroku.com/) deployed werden:  
[![Deploy](https://www.herokucdn.com/deploy/button.png)](https://heroku.com/deploy)


## Verbessere die Kontoentwicklungs-App

1. Fork it!
2. erstelle einen Feature Branch: `git checkout -b my-new-feature`
3. Commit deine Änderungen: `git commit -am 'Add some feature'`
4. Push in den Branch: `git push origin my-new-feature`
5. Sende einen Pull Request

## Lizenz

MIT Lizenz 2016 - Own Your Data
