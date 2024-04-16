# State Mangament

Das Ausgangsprojekt zur Aufgabe `State Management`.

## Beschreibung

In dieser Aufgabe erstellen wir eine Web-Applikation die uns das aktuelle Wetter in einer Stadt sagt. Dazu nutzen wir mehrere Apis um eine Stadt zu geocodieren und dann mithilfe der Koordinaten das Wetter über die OpenWeather API anzufragen.

## Ziel der Aufgabe

Ziel der Aufgabe ist es erste Erfahrungen mit dem simplen State Management in Flutter zu erlangen. Dabei implementieren wir die Logik und das State Management in der Wetter Web-Applikation.

## Aufgaben

### 0. Vorbereitung

Führt den Befehl `flutter pub get` aus, um alle Dependencies, die für das Projekt benötigt werden, zu installieren.

### 1. Lasst uns den Ort bestimmen! 📍

Schaut euch die [`geo_location_search_bar.dart`](./lib/widgets/geo_location_search_bar.dart) an.
Das dort enthaltene Widget ist ein von uns geschriebener Wrapper um das native [`SearchAnchor`](https://api.flutter.dev/flutter/material/SearchAnchor-class.html) Widget von Flutter selbst (bzw. des Material Package).

Das native `SearchAnchor` Widget bietet super viele Funktionen out-of-the-box. Es gibt uns standardmäßig eine SearchBar, welche in einem Popover (Desktop/Web) oder einer Fullscreen Page (Mobile) Vorschläge anzeigen kann.

In unserer Aufgabe haben wir es genutzt, um eine GeoCoding API an zu sprechen, die nach einem Debounce Vorschläge für [`GeoLocations`](./lib/models/geo_location.dart)(Name + Koordinaten eines Orts) für den eingegeben Text gibt.

**Kommen wir zu eurer ersten Aufgabe:**

Ihr müsst implementieren, dass beim Auswählen einer Location diese an das Parent Widget [`WeatherApp`](./lib/widgets/app.dart) gegeben wird. Sucht dazu den `// TODO: ...` Kommentar der Funktion `_selectLocation`.

Kleiner Hinweis: Denkt nicht nur "innerhalb" der Funktion - Ihr müsst was am Widget verändern! 😉 (Konzept des Lifting State Up - Siehe Präsentation). Ebenfalls sollte der "State" auch gecleared werden, wenn das Textfeld gecleared wird...

### 2. Wie wird das Wetter heute? ☀️😎 [PART 1]

Da wir nun unsereren Ort haben, von dem wir das Wetter abfragen wollen, wäre es natürlich auch sinnvoll wenn wir eine weitere API anzapfen um diese Informationen zu erhalten, oder?

Geht dazu in die abstrakte Klasse [Api](./lib/data/api.dart) und **implementiert als erstes den fetch-Request** an die [OpenWeatherApi](https://openweathermap.org/current).

Link zum API-Endpunkt:

```
https://api.openweathermap.org/data/2.5/weather?lat=<LATITUDE>&lon=<LONGITUDE>&units=metric&appid=<API-KEY>
```

Keine Sorge - ihr braucht keinen API-Key erstellen, das haben wir für euch erledigt! Dazu gibt es auch bereits eine vordefinierte Funktion `getWeather`, welche ein `Future<Weather>` zurückgeben soll. Nutzt dazu das `http`-Package und nutzt als Hilfe ggf. die von uns bereits implementierte `getGeoLocations` Funktion. Die [`Weather`](./lib/models/weather.dart)-Klasse und eine `fromJson` haben wir ebenfalls bereits für euch definiert.

### 3. Wie wird das Wetter heute? ☀️😎 [PART 2]

Als nächtes müssen wir unsere Funktion natürlich auch verwenden. Dazu sollten wir uns die zunächst die [`WeatherCard`](./lib/widgets/weather_card.dart) anschauen:

Wie ihr sehen könnt, wird hier noch nichts an das Widget übergeben. Um das Wetter aber dynamisch zu rendern, sollten wir noch etwas übergeben... Was könnte dies wohl sein? 🤓🧐

Das Problem: Wir erhalten ja ein Future der oben "gesuchten" Klasse, wie behandeln wir das?

1. Ansatz: Wir übergeben nur die ausgewählte Location an das `WeatherCard`-Widget und managen von dort aus den API-Call.

2. Ansatz: Wir managen den API-Call innerhalb des `WeatherApp` Widgets, übergeben das Future an das `WeatherCard`-Widget und behandeln die Loading und Fehlerzustände in diesem.

3. Ansatz: Wir managen den API Call in unserem `WeatherApp` Widget, behandeln dort das Future und seine Zustände und übergeben und rendern erst das `WeatherCard` Widget, sobald die Daten geladen sind.

Alle 3 Ansätze kommen mit ihren Vor- und Nachteilen, welche wir bei Interesse gerne mit euch besprechen. Egal welcher Ansatz gewählt werden würde, da wir initial ja keine Wetter Daten erhalten, sondern erst eine `GeoLocation` ausgewählt werden muss, müssen wir diesen State verwalten...

Damit wir alle jedoch einen vergleichbaren Ansatz haben und wir auch eine Lösung bereitstellen können, treffen wir (mit einem Blick in die Zukunft) diese Entscheidung für euch: **Bitte nutzt den 3. Ansatz**

1.  Nutzt eure API implementierung und das Future als State (Property). Dazu müsst ihr die `WeatherApp` bzw. dessen State anpassen. Dazu erstellen wir ein State-Property `Future<Weather>? _weather` welches zunächst initial `null` sein soll (da wir ein Wetter erst anzeigen bzw. laden können, sobald eine `GeoLocation` ausgewählt wurde).

    Nun müssen wir unsere Funktion aus [Aufgabe 1](#1-lasst-uns-den-ort-bestimmen-📍) so erweitern, dass dieses Future<Weather?> zu unserem in [Aufgabe 2](#2-wie-wird-das-wetter-heute-☀️😎) zurückgegeben Future des API-Call gesetzt wird.

2.  Nutzt einen `FutureBuilder` um das Future zu verwalten (Loading States, Error State...). Schaut euch gerne dazu den FutureBuilder in der [`GeoLocationSearchBar`](./lib/widgets/geo_location_search_bar.dart) an oder fragt bei uns nach.

### 4. Make it pretty, please! 🎨 [OPTIONAL, für die Schnellen]

Wäre es nicht cool, wenn der Hintergrund unserer App sich ändert, wenn wir das Wetter haben? Also ein schöner, sonniger Tag, wenn es gerade auch sonnig ist oder ein regnerisches Bild, welches uns daran hindert hinaus zu gehen?

Damit ihr seht, dass manche Dinge auch deutlich komplizierter sind als ggf. in anderen Frameworks haben wir dazu eine Zusatzaufgabe: Schaut euch das von uns definierte [`AnimatedBackgroundImage`](./lib/widgets/animated_background_image.dart) an und überlegt euch wie und wo ihr es verwendet!

#### Hinweise zum Weiterkommen:

<details>
  <summary>Wo soll das AnimatedBackgroundImage-Widget hin?</summary>

Wie du siehst, hat das [`AnimatedBackgroundImage`](./lib/widgets/animated_background_image.dart)-Widget keine Child- oder Children-Properties und rendert diese auch nicht. Es kann also nicht als Container für darüberliegende Widgets dienen, sondern muss auf gleicher Ebene verwendet werden. Das geht z. B. durch die richtige Positionierung im [Stack-Widget](https://api.flutter.dev/flutter/widgets/Stack-class.html).

</details>
