# Vérifications coral.qmd
coral <- parse_rmd("../../coral.qmd",
  allow_incomplete = TRUE, parse_yaml = TRUE)

test_that("Le bloc-notes est-il compilé en un fichier final HTML ?", {
  expect_true(is_rendered("coral.qmd"))
  # La version compilée HTML du carnet de notes est introuvable
  # Vous devez créer un rendu de votre bloc-notes Quarto (bouton 'Rendu')
  # Vérifiez aussi que ce rendu se réalise sans erreur, sinon, lisez le message
  # qui s'affiche dans l'onglet 'Travaux' et corrigez ce qui ne va pas dans
  # votre document avant de réaliser à nouveau un rendu HTML.
  # IL EST TRES IMPORTANT QUE VOTRE DOCUMENT COMPILE ! C'est tout de même le but
  # de votre analyse que d'obtenir le document final HTML.

  expect_true(is_rendered_current("coral.qmd"))
  # La version compilée HTML du document Quarto existe, mais elle est ancienne
  # Vous avez modifié le document Quarto après avoir réalisé le rendu.
  # La version finale HTML n'est sans doute pas à jour. Recompilez la dernière
  # version de votre bloc-notes en cliquant sur le bouton 'Rendu' et vérifiez
  # que la conversion se fait sans erreur. Sinon, corrigez et regénérez le HTML.
})

test_that("La structure du document est-elle conservée ?", {
  expect_true(all(c("Introduction", "Analyses")
    %in% (rmd_node_sections(coral) |> unlist() |> unique())))
  # Les sections (titres) attendues du bloc-notes ne sont pas toutes présentes
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs titres indispensables par rapport aux exercices ont disparu ou ont
  # été modifié. Vérifiez la structure du document par rapport à la version
  # d'origine dans le dépôt "template" du document (lien au début du fichier
  # README.md).

  expect_true(all(c("setup", "cimport", "cskim", "cskimcomment", "cfact",
    "cfactcomment", "ccount", "cgain", "cclean", "ctab", "ctabcomment")
    %in% rmd_node_label(coral)))
  # Un ou plusieurs labels de chunks nécessaires à l'évaluation manquent
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs chunks indispensables par rapport aux exercices sont introuvables.
  # Vérifiez la structure du document par rapport à la version d'origine dans
  # le dépôt "template" du document (lien au début du fichier README.md).

  expect_true(any(duplicated(rmd_node_label(coral))))
  # Un ou plusieurs labels de chunks sont dupliqués
  # Les labels de chunks doivent absolument être uniques. Vous ne pouvez pas
  # avoir deux chunks qui portent le même label. Vérifiez et modifiez le label
  # dupliqué pour respecter cette règle. Comme les chunks et leurs labels sont
  # imposés dans ce document cadré, cette situation ne devrait pas se produire.
  # Vous avez peut-être involontairement dupliqué une partie du document ?
})

test_that("L'entête YAML a-t-il été complété ?", {
  expect_true(coral[[1]]$author != "___")
  expect_true(!grepl("__", coral[[1]]$author))
  expect_true(grepl("^[^_]....+", coral[[1]]$author))
  # Le nom d'auteur n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer votre nom dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.

  expect_true(grepl("[a-z]", coral[[1]]$author))
  # Aucune lettre minuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en majuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.

  expect_true(grepl("[A-Z]", coral[[1]]$author))
  # Aucune lettre majuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en minuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
})

test_that("Chunks 'cimport', 'cskim' & 'cskimcomment' : importation des données", {
  expect_true(is_identical_to_ref("cimport", "names"))
  # Les colonnes dans le tableau `coral` importées ne sont pas celles attendues
  # Votre jeu de données de départ n'est pas correct. Ce test échoue si vous
  # n'avez pas bien rempli le code du chunk 'cimport'. Si vous avez téléchargé
  #  un fichier erroné, une solution est de supprimer le fichier corals.csv
  #  ou encore d'ajouter l'argument force=TRUE dans la fonction read() afin de
  #  forcer le téléchargement.

  expect_true(is_identical_to_ref("cimport", "classes"))
  # La nature des variables (classe) dans le tableau `coral` est incorrecte
  # Vérifiez le chunk d'importation des données `cimport`. Si vous avez téléchargé
  #  un fichier erroné, une solution est de supprimer le fichier corals.csv
  #  ou encore d'ajouter l'argument force=TRUE dans la fonction read() afin de
  #  forcer le téléchargement.

  expect_true(is_identical_to_ref("cimport", "nrow"))
  # Le nombre de lignes dans le tableau `coral` est incorrect
  # Vérifiez l'importation des données dans le chunk d'importation `cimport` et
  # réexécutez-le pour corriger le problème. Si vous avez téléchargé
  #  un fichier erroné, une solution est de supprimer le fichier corals.csv
  #  ou encore d'ajouter l'argument force=TRUE dans la fonction read() afin de
  #  forcer le téléchargement.

  expect_true(is_identical_to_ref("cskimcomment"))
  # L'interprétation des tableaux de description des données est (partiellement)
  # fausse
  # Vous devez cochez les phrases qui décrivent le graphique d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'cfact' & 'cfactcomment' : Conversion en facteur", {
  expect_true(is_identical_to_ref("cfact", "names"))
  # Les colonnes dans le tableau `coral` ne sont pas celles attendues.
  # Avez-vous ajouté de nouvelles variables à votre tableau ?
  # Il fallait les convertir.

  expect_true(is_identical_to_ref("cfact", "classes"))
  # La nature des variables (classe) dans le tableau `coral` est incorrecte
  # La conversion des variables caractères et des variables numériques ne semble
  # pas réalisé.

  expect_true(is_identical_to_ref("cfactcomment"))
  # L'interprétation des tableaux de description des données est (partiellement)
  # fausse
  # Vous devez cochez les phrases qui décrivent le graphique d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'ccount' : Tableau résumé de dénombrements des individus", {
  expect_true(is_identical_to_ref("ccount", "names"))
  # Les colonnes dans le tableau `coral_count` ne sont pas celles attendues.
  # Vous devriez avoir un tableau résumé contenant les colonnes 'species',
  # 'localisation' et 'n'.

  expect_true(is_identical_to_ref("ccount", "nrow"))
  # Le nombre de lignes dans le tableau `coral_count` est incorrect
  # Ce tableau devrait comprendre 8 lignes.
})

test_that("Chunks 'cgain' : Calcule de nouvelles variables", {
  expect_true(is_identical_to_ref("cgain", "names"))
  # Les colonnes dans le tableau `coral` ne sont pas celles attendues.
  # Vous devriez avoir deux colonnes supplémentaires nommées gain_j et gain_std_j

  expect_true(is_identical_to_ref("cgain", "classes"))
  # La nature des variables (classe) dans le tableau `coral` est incorrecte
  # Un mauvais calcul peut produire une classe incorrecte. Vous devriez avoir
  # des variables numériques pour gain_j et gain_std_j
})

test_that("Chunks 'cclean' : Réduction du tableau coral", {
  expect_true(is_identical_to_ref("cclean", "names"))
  # Les colonnes dans le tableau `coral` ne sont pas celles attendues.
  # Vous devriez avoir trois colonnes en moins.

  expect_true(is_identical_to_ref("cclean", "nrow"))
  # Le nombre de lignes dans le tableau `coral` est incorrect
  # Avez-vous bien éliminé les valeurs strictement inférieures à 0 pour la variable
  # gain_j
})

test_that("Chunks 'ctab' & 'ctabcomment' : Tableau résumé par aquariums et espèces", {
  expect_true(is_identical_to_ref("ctab", "names"))
  # Les colonnes dans le tableau `coral_tab` ne sont pas celles attendues
  # Avez-vous bien respecté les noms des colonnes comme demandé dans la consignes.

  expect_true(is_identical_to_ref("ctab", "classes"))
  # La nature des variables (classe) dans le tableau `coral_tab` est incorrecte

  expect_true(is_identical_to_ref("ctab", "nrow"))
  # Le nombre de lignes dans le tableau `coral` est incorrect
  # Ce tableau doit comprendre 8 lignes, car il provient du groupement
  # des aquariums et des espèces.

  expect_true(is_identical_to_ref("ctabcomment"))
  # L'interprétation du tableau résumé est (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent le graphique d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})
