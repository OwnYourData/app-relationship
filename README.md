# <img src="https://github.com/OwnYourData/app-relationship/raw/master/www/app_logo.png" width="92"> Beziehungstracker
In einer Beziehung ist es spannend wie es beiden Partnern geht. Insbesondere äußere Einflüsse können oft eine große Wirkung haben, ohne dass der oder die Andere weiß welche Bedeutung das auf die Beziehung hat. Mit dem Beziehungstracker protokollieren Partner ihr Befinden in unterschiedlichen Bereichen und vergleichen wöchentlich wie es ihnen geht. Geringe Werte und große Diskrepanzen deuten auf Spannungen hin!

Mehr Infos, Screenshots und Demo: https://www.ownyourdata.eu/apps/beziehungstracker

### Dein Datentresor
Der Beziehungstracker wird in einem sicheren Datentresor installiert. Üblicherweise musst du deine Daten an die Betreiber von Webservices und Apps weitergeben, um diese nutzen zu können. OwnYourData dreht den Spieß jedoch um: Du behältst all deine Daten und du verwahrst sie in deinem eigenen Datentresor. Apps (Datensammlung, Algorithmen und Visualisierung) holst du zu dir, in den Datentresor hinein.

Mehr Infos und Demo: https://www.ownyourdata.eu  
Hintergrund-Infos für Entwickler: https://www.ownyourdata.eu/developer/

## Installation

Du kannst entscheiden wo du deinen Datentresor einrichten und deine Apps installieren möchtest: auf deinem persönlichen OwnYourData-Server, auf einem anderen Cloud-Dienst deiner Wahl, auf deinem eigenen Computer oder auf einem Raspberry Pi bei Dir daheim.

### Installation am OwnYourData-Server

Diese Installation ist am einfachsten: Fordere deinen Datentresor an: https://www.ownyourdata.eu, öffne den Datentresor und klicke im *OwnYourData App Store* beim Beziehungstracker auf "Install".

### Installation bei Cloud Diensten

Verschiedene Cloud Dienste bieten das Hosting von [Docker](https://www.docker.com) Containern an, z.B. https://sloppy.io oder https://elastx.se. Der Beziehungstracker steht als Docker-Image unter dem Namen `oydeu/app-relationship` auf Dockerhub hier zur Verfügung: https://hub.docker.com/r/oydeu/app-relationship/. (Da der Beziehungstracker auch in einer Variante für Smartphones zur Verfügung steht, soll auch das Image `oydeu/app-relationship_mobile` verwendet werden.)  
Starte den Container und verbinde Dich im Konfigurations-Dialog mit deinem Datentresor.

### Installation am eigenen Computer/Laptop

Um den Beziehungstracker am eigenen Computer auszuführen, musst du zuerst [eine aktuelle Version von Docker installieren](https://www.docker.com/community-edition#/download). Starte dann den Beziehungstracker mit folgendem Befehl:  
`docker run -p 3838:3838 oydeu/app-relationship`  
Du kannst dann auf den Beziehungstracker mit deinem Browser unter folgender Adresse zugreifen:  
`http://192.168.99.100:3838`  
  
*Anmerkungen:*  
* wenn du mehrere Apps verwendest, musst du unterschiedliche Ports verwenden  
  `docker run -p 1234:3838 oydeu/app-relationship` und `http://192.168.99.100:1234`
* Docker vergibt die IP-Adresse auf deinem Computer unter der du auf die Container zugreifen kannst. Verwende folgenden Befehl, um die tatsächliche IP-Adresse festzustellen: `docker-machine ip`  
* in diesem Blog-Artikel wird ausführlich die Installation einer App am eigenen PC beschrieben: [Ein Container voller Daten](https://www.ownyourdata.eu/2016/09/26/ein-container-voller-daten/)

### Installation am Raspberry Pi

Der Beziehungstracker steht auch für die Architektur armhf zur Verfügung. Die Installation erfolgt dann wie am Computer/Laptop jedoch unter Verwendung des Docker Image `oydeu/app-relationship_armhf`.  
  
*Anmerkungen:*  
* Beziehungstracker am Dockerhub: https://hub.docker.com/r/oydeu/app-relationship_armhf/  
* zur einfachen Installation von Docker am Raspberry empfehlen wir die SD-Card Images von Hypriot: http://blog.hypriot.com/downloads/
* Befehl zum Start des Containers am Raspberry: `docker run -p 3838:3838 oydeu/app-relationship_armhf`

## Datenstruktur

Die folgenden Listen werden vom Beziehungstracker verwendet:

* Energie #1 und #2    
    - `date`: Datum im Format YYYY-MM-DD    
    - `value`: Skalierung des Befindens von 1-sehr schlecht bis 6-sehr gut    
* Gesundheit #1 und #2    
    - `date`: Datum im Format YYYY-MM-DD    
    - `value`: Skalierung des Befindens von 1-sehr schlecht bis 6-sehr gut  
* Zufriedenheit #1 und #2    
    - `date`: Datum im Format YYYY-MM-DD    
    - `value`: Skalierung des Befindens von 1-sehr schlecht bis 6-sehr gut  
* Entspannung #1 und #2    
    - `date`: Datum im Format YYYY-MM-DD    
    - `value`: Skalierung des Befindens von 1-sehr schlecht bis 6-sehr gut  
* Gesamt #1 und #2    
    - `date`: Datum im Format YYYY-MM-DD    
    - `value`: Skalierung des Befindens von 1-sehr schlecht bis 6-sehr gut  
* Notizen #1 und #2    
    - `date`: Datum im Format YYYY-MM-DD    
    - `value`: Text    
* Konfiguration    
    - `name1`: Name der 1. Person    
    - `name2`: Name der 2. Person    
* Scheduler, Scheduler Verlauf und Scheduler Status  - siehe [service-scheduler](https://github.com/OwnYourData/service-scheduler)  
* Info - Informationen zum Datentresor


## Verbessere den Beziehungstracker

Bitte melde Fehler oder Vorschläge für neue Features / UX-Verbesserungen im [GitHub Issue-Tracker](https://github.com/OwnYourData/app-relationship/issues) und halte dich dabei an die [Contributor Guidelines](https://github.com/twbs/ratchet/blob/master/CONTRIBUTING.md).

Wenn du selbst an der App mitentwickeln möchtest, folge diesen Schritten:

1. Fork it!
2. erstelle einen Feature Branch: `git checkout -b my-new-feature`
3. Commit deine Änderungen: `git commit -am 'Add some feature'`
4. Push in den Branch: `git push origin my-new-feature`
5. Sende einen Pull Request

## Lizenz

[MIT Lizenz 2017 - OwnYourData.eu](https://raw.githubusercontent.com/OwnYourData/app-relationship/master/LICENSE)
