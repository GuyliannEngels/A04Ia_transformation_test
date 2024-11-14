# Importation et remaniement des données

## Avant-propos

Ce projet nécessite d'avoir assimilé l'ensemble des notions du cinquième module du cours de science des données biologiques 1. Il correspond au dépôt GitHub <https://github.com/BioDataScience-Course/A05Ia_transformation>. Il est distribué sous licence [CC BY-NC-SA 4.0](https://creativecommons.org/licenses/by-nc-sa/4.0/).

## Objectifs

Ceci est un projet **individuel**, **court** et **cadré**. Il permettra de démontrer que vous avez acquis les compétences suivantes :

-   Être capable d'importer des données depuis différents formats et différentes sources avec la fonction `read()`.

-   Maîtriser le remaniement de données, filtrer un tableau et le résumer afin d'en extraire l'information importante.

-   Comprendre et utiliser l'opérateur `%>.%` pour le chaînage des instructions.

## Consignes

### Croissance de coraux en mésocosme

Complétez le fichier `coral.qmd` en suivant les instructions qui s'y trouvent. Le tableau de données est disponible via le lien suivant :

> <https://filedn.com/lzGVgfOGxb6mHFQcRn9ueUb/coral/corals.csv>

Le jeu de données reprend des mesures de croissance de différentes espèces de coraux. La masse des coraux est mesurée au début de l'expérience (temps t0) puis une seconde fois après 7 jours (temps t7). Les variables du jeu de données sont :

-   **localisation :** aquarium dans lequel la bouture de corail est placée. Les installations sont composées de deux unités indépendantes (A et B) et de plusieurs aquariums par unité, reliés entre eux,
-   **species :** espèce étudiée,
-   **id :** code de la bouture de corail,
-   **salinity :** salinité mesurée en t7, grandeur sans unité,
-   **temperature :** température mesurée dans l'eau en t7, en °C,
-   **date :** date de la mesure en t7,
-   **time :** nombre de jours écoulés entre la mesure initiale et finale,
-   **gain :** gain de masse entre t0 et t7, en g,
-   **gain_std :** gain/masse initiale, sans unité.

### Cas de diabète chez des femmes PIMA

Complétez le fichier `pima.qmd`. Le jeu de données employé provient du package {MASS}. Vous avez à votre disposition une page d'aide pour mieux appréhender les variables de ce dernier.
