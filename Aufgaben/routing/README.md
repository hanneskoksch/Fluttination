# Routing

Das Ausgangsprojekt zur Aufgabe `Routing`.

## Beschreibung

In dieser Aufgabe erweitern wir die in der vorherigen Aufgabe "State Management" erstellte Web-Applikation. Wir werden den State der Location dazu in die URL-verlagern, sodass auch requests direkt an eine URL mit Koordinaten als Query-Parameter möglich sind. 

## Ziel der Aufgabe

Ziel der Aufgabe ist es, ganz grundlegendes Routing mit Flutter zu implementieren und die Einbindung von externen Packages kennenzulernen. Wir verwenden dafür das [GoRouter](https://pub.dev/packages/go_router)-Package.

## Aufgaben

### 0. Vorbereitung

Führt den Befehl `flutter pub get` aus, um alle Dependencies, die für das Projekt benötigt werden, zu installieren.

### 1. Wir wollen doch keinen Router selber schreiben 🧐

Für Routing gibt es in Flutter zwar eine API, für eine bessere Struktur, mehr Sicherheit und einen besseren Überblick ergibt es aber Sinn, auf Wrapper zu setzen, wie z. B. den GoRouter. 

Suche den GoRouter auf [pub.dev](https://pub.dev/) und installiere ihn nach der Anweisung dort.

### 2. Routes verwenden 🛣️

Ändere die MaterialApp so ab, dass sie einen Router verwendet. In unserem Fall haben wir hier nur eine Route zum Root unserer Applikation: `/`.

Hilfreich kann hierbei das [Implementations-Beispiel](https://pub.dev/packages/go_router/example) auf pub.dev sein oder die ebenfalls dort verlinkte Dokumentation.

Die Anwendung sollte jetzt wieder genauso funktionieren wie zum Start der Aufgabe.

### 3. Query Parameter annehmen 🫴

Über den `GoRouterState` des builders des GoRouters wollen wir nun Query-Parameter parsen. Entweder ihr probiert aus, wie man diese aus dem State extrahieren kann oder ihr werft einen Blick in die [Dokumentation](https://pub.dev/documentation/go_router/latest/topics/Configuration-topic.html) unter "Configuration/Parameters".

Die Parameter `lat` und `lang` sollen der bisherigen Applikation optional als String übergeben werden. 

### 4. Query Parameter benutzen 💪

In der Applikation wollen wir nun also die optional übergebenen Parameter benutzen. Sind diese nicht `null`, wollen wir sie zum initialen Laden der Seite direkt verwenden. Verwendet dazu die folgende Funktion innerhalb des States:

```dart
  @override
  void initState() {
    super.initState();
    ...
  }
```

### 4. State in die URL verlagern 🔝

Zuletzt wollen wir den kompletten Location-State in die URL verlagern. Das heißt: Auch Locations, die mit Hilfe der Search-Bar ausgewählt wurden, sollen als Koordinaten in der URL erscheinen. 

Verwendet dazu die vom GoRouter stammende Extension auf dem BuildContext `context.go(...)`



