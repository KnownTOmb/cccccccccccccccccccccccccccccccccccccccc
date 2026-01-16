* [ ] zróżnicowanie zapytań:
* [X] trigger po usunięciu użytkownika usuwa:
  * [X] wszystkie uprawnienia
  * [X] go z tablic na których byl
  * [X] jego opis
  * [X] jego dane osobowe
  * [X] jego adres tylko wtedy gdy nikt wicej pod nim nie mieszka
  * [X] jego relacje
  * [X] jego posty

> wypełnianie nieużywanych id przy dodawaniu ogłoszenia

* [X] dodanie screenów z dzialania trigerow procedur i widokow

* [] dodac załozenia projektu (server na linuxie zmora oznacza to, matuzal oznacza tamto)

> opisy widoków sa w sekcji widoków to nie wiem czy trzeba to definiowac tutaj.

* [ ] problem 3 zdjęć
* [X] porawic widoki w diagram erd
* [X] dodać do widzi dane w pokrewienstwo default na 0
* [X] uga buga diagram zdj spokre
* [X] **naprawic opis uzytkownika bo przypisuje wielu uzytkownikom jeden opis**

> [X] cos jest popsute w widioku plodnosc kreatorow postów bo sa wartosci NULL na poczatku
> niewazne widok jest popsuty przez to ze wielu uzytkowników ma ten sam opis

* [X] poszukac czy gdzies nie ma na screenach tinyint(4) bo nwm czamu ale tak był i zmieniłem na tinyint(1)
* [X] rozwiazac problem tego ze przy usuwaniu uzytkownika to razem z nim musza poleciec jego posty -

> dodac uzytkownika usuniety uzytkownik i ustawiac go na autora przed usinieciem

* [ ] dopisać w pdfie i gdzie tam trzeba że kombinacja id tablicy i użytkownika jest unikalna w uprawnieniach ()
* [X] usunąć kolumnę ogłoszeniecol z ogłoszeń
* [ ] poprawić kiedyś błędy językowe/niechlujstwa w pdfie
* [X] login ma być null, dopisać to do pdfa
* [X] zdjecie profilowe nie może być null, default to 1
* [X] opis dla usuniętego użytkownika, w opisie ma należeć do nieznanej rodziny też dopisać do pdfa
* [X] posortuj po liczbie użytkowników w płodności tablic
* [ ] na końcu screeny zweryfikować i typy danych
* [ ] administracje
* [ ] widok opis imie nazwisko na końcu jak czas
* [X] dodac nowe triggery do trigerow
* [ ] zapytania napisac z 8 podpunktu
* [ ] zabić projekt



> Życie po śmiertne
* [ ] oddzielna tabela do haseł i loginów 

```
Adam i Maria siedzą na brzegu małego jeziora, gdzie woda lśni jak rozpuszczone srebro. Zachód słońca barwi niebo w odcieniach moreli i fiołku. Adam wyciąga z kieszeni małe, aksamitne pudełeczko. Maria patrzy na niego zdziwiona, serce bije jej szybciej.

Adam łapie jej dłonie w swoje i mówi:
„Maria… każdy dzień z Tobą jest jak odkrywanie nowego nieba. Chcę, żeby nasze przygody nigdy się nie kończyły. Czy zostaniesz moją żoną?”

W tym momencie otwierają się pudełeczko, a w nim pierścionek, który odbija ostatnie promienie słońca. Maria, z łzami szczęścia w oczach, odpowiada „Tak!”, a Adam wciąga ją w czuły uścisk.

W tle migoczą ogniki świetlików, a wiatr niesie ich śmiech nad taflą jeziora. Wszystko jest idealnie – jakby świat na chwilę przestał się spieszyć, tylko dla nich dwojga. 💖
```
