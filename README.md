#Fiszki

Aplikacja edukacyjna stworzona we frameworku **Flutter**, służąca do efektywnej nauki słówek z języka angielskiego. Projekt wykorzystuje interaktywne fiszki, zewnętrzne API oraz lokalną bazę danych, aby zapewnić płynne działanie zarówno online, jak i offline.

## Główne funkcjonalności

* **Kategorie tematyczne:** Słówka podzielone na grupy (np. Podróże, Praca, Dom, Jedzenie).
* **Interaktywne Fiszki:** Animacja obracania karty (przód: słowo angielskie, tył: tłumaczenie polskie).
* **Tryb Hybrydowy:**
    * **Offline:** Błyskawiczny dostęp do tłumaczeń i definicji z lokalnej bazy danych.
    * **Online:** Pobieranie rozszerzonych definicji, fonetyki i przykładów użycia z API.
* **Ulubione:** Możliwość zapisywania trudnych słówek (trwały zapis w pamięci urządzenia dzięki `shared_preferences`).
* **Wyszukiwarka:** Szybkie odnajdywanie słówek z całej bazy danych.
* **Szczegóły:** Możliwość podglądu synonimów i wymowy fonetycznej.

## Użyte API

Aplikacja korzysta z darmowego **Free Dictionary API** do pobierania szczegółowych danych lingwistycznych (definicje, fonetyka, przykłady zdań) dla języka angielskiego.

* **Link do dokumentacji API:** [https://freedictionaryapi.dev/](https://freedictionaryapi.dev/)

## Wspierane platformy

Aplikacja została przygotowana z myślą o urządzeniach mobilnych:
* **Android** (telefon/tablet)
* **iOS** (iPhone/iPad)

## Technologie i biblioteki

* **Flutter & Dart**
* `http` - do komunikacji z API.
* `flip_card` - do animacji obracania fiszek.
* `shared_preferences` - do trwałego zapisywania ulubionych słówek.

## Instrukcja uruchomienia

Aby uruchomić projekt na swoim komputerze, wykonaj poniższe kroki:

1.  **Pobierz repozytorium** (lub rozpakuj pliki projektu).
2.  Otwórz terminal w głównym katalogu projektu.
3.  **Pobierz zależności:**
    ```bash
    flutter pub get
    ```
4.  **Uruchom aplikację:**
    Podłącz telefon lub uruchom emulator, a następnie wpisz:
    ```bash
    flutter run
    ```
