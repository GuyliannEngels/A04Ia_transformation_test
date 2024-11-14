# Vérifications pima.qmd
pima <- parse_rmd("../../pima.qmd",
  allow_incomplete = TRUE, parse_yaml = TRUE)

test_that("Le bloc-notes est-il compilé en un fichier final HTML ?", {
  expect_true(is_rendered("pima.qmd"))
  # La version compilée HTML du carnet de notes est introuvable
  # Vous devez créer un rendu de votre bloc-notes Quarto (bouton 'Rendu')
  # Vérifiez aussi que ce rendu se réalise sans erreur, sinon, lisez le message
  # qui s'affiche dans l'onglet 'Travaux' et corrigez ce qui ne va pas dans
  # votre document avant de réaliser à nouveau un rendu HTML.
  # IL EST TRES IMPORTANT QUE VOTRE DOCUMENT COMPILE ! C'est tout de même le but
  # de votre analyse que d'obtenir le document final HTML.

  expect_true(is_rendered_current("pima.qmd"))
  # La version compilée HTML du document Quarto existe, mais elle est ancienne
  # Vous avez modifié le document Quarto après avoir réalisé le rendu.
  # La version finale HTML n'est sans doute pas à jour. Recompilez la dernière
  # version de votre bloc-notes en cliquant sur le bouton 'Rendu' et vérifiez
  # que la conversion se fait sans erreur. Sinon, corrigez et regénérez le HTML.
})

test_that("La structure du document est-elle conservée ?", {
  expect_true(all(c("Introduction", "Analyses")
    %in% (rmd_node_sections(pima) |> unlist() |> unique())))
  # Les sections (titres) attendues du bloc-notes ne sont pas toutes présentes
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs titres indispensables par rapport aux exercices ont disparu ou ont
  # été modifié. Vérifiez la structure du document par rapport à la version
  # d'origine dans le dépôt "template" du document (lien au début du fichier
  # README.md).

  expect_true(all(c("setup", "pimport", "pskim", "pskimcomment", "pbmi_cat",
    "pcount", "pcountcomment", "psub", "ptab")
    %in% rmd_node_label(pima)))
  # Un ou plusieurs labels de chunks nécessaires à l'évaluation manquent
  # Ce test échoue si vous avez modifié la structure du document, un ou
  # plusieurs chunks indispensables par rapport aux exercices sont introuvables.
  # Vérifiez la structure du document par rapport à la version d'origine dans
  # le dépôt "template" du document (lien au début du fichier README.md).

  expect_true(any(duplicated(rmd_node_label(pima))))
  # Un ou plusieurs labels de chunks sont dupliqués
  # Les labels de chunks doivent absolument être uniques. Vous ne pouvez pas
  # avoir deux chunks qui portent le même label. Vérifiez et modifiez le label
  # dupliqué pour respecter cette règle. Comme les chunks et leurs labels sont
  # imposés dans ce document cadré, cette situation ne devrait pas se produire.
  # Vous avez peut-être involontairement dupliqué une partie du document ?
})

test_that("L'entête YAML a-t-il été complété ?", {
  expect_true(pima[[1]]$author != "___")
  expect_true(!grepl("__", pima[[1]]$author))
  expect_true(grepl("^[^_]....+", pima[[1]]$author))
  # Le nom d'auteur n'est pas complété ou de manière incorrecte dans l'entête
  # Vous devez indiquer votre nom dans l'entête YAML à la place de "___" et
  # éliminer les caractères '_' par la même occasion.

  expect_true(grepl("[a-z]", pima[[1]]$author))
  # Aucune lettre minuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en majuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.

  expect_true(grepl("[A-Z]", pima[[1]]$author))
  # Aucune lettre majuscule n'est trouvée dans le nom d'auteur
  # Avez-vous bien complété le champ 'author' dans l'entête YAML ?
  # Vous ne pouvez pas écrire votre nom tout en minuscules. Utilisez une
  # majuscule en début de nom et de prénom, et des minuscules ensuite.
})

test_that("Chunks 'pimport', 'pskim' & 'pskimcomment' : importation des données", {
  expect_true(is_identical_to_ref("pimport", "names"))
  # Les colonnes dans le tableau `pima` importé ne sont pas celles attendues
  # Votre jeu de données de départ n'est pas correct. Vérifiez le chunk
  # d'importation des données `pimport`.

  expect_true(is_identical_to_ref("pimport", "classes"))
  # La nature des variables (classe) dans le tableau `pima` est incorrecte
  # Vérifiez le chunk d'importation des données `pimport`.

  expect_true(is_identical_to_ref("pimport", "nrow"))
  # Le nombre de lignes dans le tableau `pima` est incorrect
  # Vérifiez l'importation des données dans le chunk d'importation `pimport`.

  expect_true(is_identical_to_ref("pskimcomment"))
  # L'interprétation des tableaux de description des données est (partiellement)
  # fausse
  # Vous devez cochez les phrases qui décrivent le graphique d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'pbmi_cat' : Découpage en classe de la variable bmi", {
  expect_true(is_identical_to_ref("pbmi_cat", "names"))
  # Les colonnes dans le tableau `pima` ne sont pas celles attendues.
  # Avez-vous ajouté la nouvelle variable à votre tableau ?

  expect_true(is_identical_to_ref("pbmi_cat", "classes"))
  # La nature des variables (classe) dans le tableau `pima` est incorrecte
  # La dernière variable créé doit être une variable qualitative ordonnée.
})

test_that("Chunks 'pcount' & 'pcountcomment' : graphique en barres des catégories d'IMC", {
  expect_true(is_identical_to_ref("pcount"))
  # Le graphique en barres produit par 'pcount' n'est pas celui attendu
  # Avez-vous bien employé des aplats de couleurs pour le diabète ? Lisez bien
  # la consigne et corrigez l'erreur, puis refaites un 'Rendu' du document
  # avant de retester.

  expect_true(is_identical_to_ref("pcountcomment"))
  # L'interprétation du graphique en barres est (partiellement) fausse
  # Vous devez cochez les phrases qui décrivent le graphique d'un 'x' entre les
  # crochets [] -> [x]. Ensuite, vous devez recompiler la version HTML du
  # bloc-notes (bouton 'Rendu') sans erreur pour réactualiser les résultats.
  # Assurez-vous de bien comprendre ce qui est coché ou pas : vous n'aurez plus
  # cette aide plus tard dans le travail de groupe ou les interrogations !
})

test_that("Chunks 'psub': réduction de la taille du tableau", {
  expect_true(is_identical_to_ref("psub", "names"))
  # Les colonnes dans le tableau `pima_sub` ne sont pas celles attendues.
  # Il est probable que vous avez employé une mauvaise fonction et éliminé des
  # colonnes. Vérifiez le chunk `pimport`.

  expect_true(is_identical_to_ref("psub", "classes"))
  # La nature des variables (classe) dans le tableau `pima_sub` est incorrecte
  # Vérifiez le chunk d'importation des données `psub`.

  expect_true(is_identical_to_ref("psub", "nrow"))
  # Le nombre de lignes dans le tableau `pima_sub` est incorrect
  # La réduction des lignes est probablement incorrecte.
})

test_that("Chunks 'ptab' : Tableau résumé pour les des personnes diabétiques en surpoids ou obèses", {
  expect_true(is_identical_to_ref("ptab", "names"))
  # Les colonnes dans le tableau `pima_tab` ne sont pas celles attendues
  # Avez-vous bien respecté les noms des colonnes comme demandé dans la
  # consignes.

  expect_true(is_identical_to_ref("ptab", "classes"))
  # La nature des variables (classe) dans le tableau `pima_tab` est incorrecte

  expect_true(is_identical_to_ref("ptab", "nrow"))
  # Le nombre de lignes dans le tableau `pima` est incorrect
  # Ce tableau doit comprendre 4 lignes car il provient du groupement
  # des bmi_cat et de diabete.
})

test_that("Les commentaires sont-ils complétés pour le tableau résumé 'ptab'", {
  expect_true(!(rmd_select(pima, by_section("Analyses")) |>
    as_document() |> grepl("^- +\\.+ *$", x = _) |> any()))
  # Vous devez compléter la liste d'observations sous le tableau résumé obtenu
  # au chunk 'ptab'. Si le test échoue, ce n'est pas encore fait.
})
