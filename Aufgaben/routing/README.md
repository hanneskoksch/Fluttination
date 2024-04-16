# Routing

Das Ausgangsprojekt zur Aufgabe `Routing`.

## Beschreibung

In dieser Aufgabe erweitern wir die in der vorherigen Aufgabe ["State Management"](../routing/) erstellte Web-Applikation. Wir werden den State der Location dazu in die URL-verlagern, sodass auch requests direkt an eine URL mit Koordinaten als Query-Parameter möglich sind.

## Ziel der Aufgabe

Ziel der Aufgabe ist es, ganz grundlegendes Routing mit Flutter zu implementieren und die Einbindung von externen Packages kennenzulernen. Wir verwenden dafür das [GoRouter](https://pub.dev/packages/go_router)-Package.

## Aufgaben

### 0. Vorbereitung

Führt den Befehl `flutter pub get` aus, um alle Dependencies, die für das Projekt benötigt werden, zu installieren.

### 1. Wir wollen doch keinen Router selber schreiben 🧐

Für Routing gibt es in Flutter zwar eine API für simples Navigieren in einer mobilen Anwendung oder einer simplen Single Page Applikation ([Navigator API](https://docs.flutter.dev/ui/navigation#using-the-navigator)), doch gerade im Web nutzt man häufig direkt Links und auch im mobilen Bereich werden häufig sogenannte Deep-Links verwendet. Um das Thema anzugehen, empfiehlt Flutter selbst den Routing-Wrapper `GoRouter` zu verwenden.

Dazu müsst ihr als aller erstes den `GoRouter` auf [pub.dev](https://pub.dev/) suchen und installieren. Wie ihr eine externe Library installiert, habt ihr in der Präsentation gesehen, andernfalls findet ihr im Package unter dem Reiter "Installing" auch nochmal eine Anleitung.

[[OPTIONAL] Noch ein kleiner Exkurs zum selbst nachlesen](https://docs.flutter.dev/ui/navigation/url-strategies) bzgl. der URL-Strategies im Web und wie man das `#` in dem Pfad los wird.

### 2. Routes verwenden 🛣️

Nachdem wir die GoRouter Library installiert haben, müssen wir Sie uns jetzt zu nutze machen:
Ändere die MaterialApp so ab, dass sie einen Router verwendet. Hilfreich kann hierbei das [Implementations-Beispiel](https://pub.dev/packages/go_router/example) auf pub.dev sein oder die ebenfalls dort verlinkte Dokumentation. In unserem Fall haben wir jedoch nur eine GoRoute Location: `/`.

Kleiner Hinweis: Ihr solltet alles ab dem Scaffold in ein eigenes Widget extrahieren.
Am besten nennt ihr das entstehende Widget `HomeScreen`.

Die Anwendung sollte jetzt wieder genauso funktionieren wie zum Start der Aufgabe.

### 3. Query Parameter annehmen 🫴

Die Idee ist, das wir später beim selektieren einer Location die dadurch erhaltenen Koordinaten (Latitude und Longitude) als Query-Paramter in die URL schreiben.

Um uns darauf vorzubereiten, soll der HomeScreen um optionale lat und long Parameter ergänzt werden.

Nun können wir über den `GoRouterState` des GoRouters builders die Query-Parameter parsen. Entweder ihr probiert selbst aus, wie man diese aus dem State extrahieren kann oder ihr werft einen Blick in die [Dokumentation](https://pub.dev/documentation/go_router/latest/topics/Configuration-topic.html) unter "Configuration/Parameters".
Haben wir sie erfolgreich geparsed, können wir sie ja an den HomeScreen übergeben, falls denn welche vorhanden sind... 🤔

### 4. Query Parameter benutzen 💪

In dem HomeScreen wollen wir nun also die optional übergebenen Parameter benutzen. Sind diese nicht `null`, wollen wir sie zum initialen Laden/Setzen des Wetters verwenden. Überschreibt dazu die Lifecycle-Methode des HomeScreen States wie folgt (das ... sollt ihr euch natürlich überlegen! 🤓):

```dart
  @override
  void initState() {
    super.initState();
    ...
  }
```

Da unsere API-Klasse bisher nur eine `getWeather`-Funktion hat, solltet ihr vielleicht eine weitere schreiben, welche statt einer `GeoLocation` nur die Koordinaten akzeptiert _ODER_ Ihr refactored euren Code so, dass diese die bestehende Funktion statt einer `GeoLocation` die Koordinaten akzeptiert.

### 5. Lifting State up... even more?? 🔝

Nun wollen wir den kompletten Location-State in die URL verlagern. Das heißt: Locations, die mit Hilfe der Search-Bar ausgewählt wurden, sollen als Koordinaten in der URL erscheinen.

Verwendet dazu die vom GoRouter stammende Extension auf dem BuildContext `context.go(...)`.

Denkt jedoch dran: Die ausgewählte Location könnte auch `null` sein, welches auch berücksichtigt werden muss!

### 6. Query Parameter benutzen 💪 [PART 2]

Falls ihr eure Applikation nach der [Aufgabe 4](#5-lifting-state-up-even-more-🔝) getestet habt, werdet ihr schnell merken: Die URL aktualisiert sich zwar, aber das Wetter nicht? Das liegt daran, dass wir unser `HomeScreen` Widget geupdatet haben (mit den neuen Query Parametern), aber unser Wetter-Future nicht angepasst haben.

Überschreibt hierzu die `didUpdateWidget` Lifecycle Methode, welche aufgerufen wird, wenn die Parameter des Widgets sich geändert haben und nutzt die Chance unser `_weather` zu updaten! (Klingt irgendwie so, als hätten wir das anders irgendwie auch schon gemacht... Keep it `DRY`!)

```dart
@override
void didUpdateWidget(covariant HomeScreen oldWidget) {
  super.didUpdateWidget(oldWidget);
  ...
}
```
