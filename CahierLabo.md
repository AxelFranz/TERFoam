22/03

Implémentation finie du code de base pour l'eau normalement. Cependant, j'ai l'impression que dès que je modifie UV, le tnb me produit des texutres impossibles ou quasiment vides. Je vais commencer l'expérimentation en faisant bouger les 3 panels pour voir si ça vient vraiment de là ou de mon implé.

23/03 

Je dois louper quelque chose, même ajouter un (1,1) produit un écran noir et même maintenant l'offset des vertices ne marche plus

25/03

Bien penser à ramener les coordonnées de (-1,1) à (0,1)

Enlever le viewport pour tout faire en un shader

Voir code pour les 3 pistes

Pour le début du rapport, je peux faire une partie sur les 3 approches de l'animations

Prochaine réunion à 10h30 le 8 avril pour présentation des résultats.

Décrire les différents effets de l'animation et les comparer pour arriver au résultat/combinaison qui rend le mieux

[Faudra réécrire toute la partie qui s'est pas sauvegardée :c]

14/04 

Animation tuile : rend plutôt bien et je n'ai pas l'air de voir de periodicité

Animation rotation Tnb : Très périodique mais fait bouger l'eau plus rapidement

Animation UV : Fait seulement un effet de tapis roulant, vraiment pas agréable

Tuile + Rota : joli

Tuile + UV  : ok

Je pense rester sur Tuile-only

24/04

Il faudra dire dans le rapport qu'on a décidé de changer d'approche du problème pour se focaliser sur l'animation

Dire qu'on est parti du modèle des ravines [CGS]

Explication maths

Notre modèle se base sur un o(u) => Hauteur en fonction d'une position

On a O(u) = H o G à la base (H carte de profil et G bruit gaussien [GGGS24]

$G(u) = \Sigma_i{w_i(u)E_i(u)}$ avec $E_i(u)$ la tuile de l'exemplar

1ere modif : $O(u) = H$o$G(u+o(t))$ => Offset sur l'UV

2e modif : $G(u) = \Sigma_i{w_i(u)E(u+o(t))}$ => Faire bouger les tuiles

3e modif : $O(u) = H$o$R(t)$o$G(u)$ avec $R(t)$ la rotation et $o(t)$ l'offset

Peut-être ajouter une section Theorical Background pour poser les équations qu'on utilise (pas les versions modifiées).

Notre approche est un peu floue entre les deux car on utilise une texture (eulerien) pour bouger des sommets (lagrangien).

oral

- Essayer d'avoir 10 minutes de contexte pendant l'oral, faut vraiment que les gens comprennent de quoi en parle.

- Très peu utiliser les maths, plutôt se baser sur du support visuel

- Si j'utilise des supports visuels pendnat l'oral, bien préciser quand c'est pas les miens

Mardi 29 10h30 Prochaine Réu

Simulating ocean waters : utilise la TF

lire A simple model of ocean waves pour la prochaine fois

court résumé : ils font des sommes de vagues tronchoïdes (gertsner) et au final on se retrouve avec un offset par point 3D



Mardi 13 10h30 prochaine réu

Réunion pour avoir un premier retour sur le papier, les retours ont été mis en commentaire sur le fichier par M. Fournier (supprimés depuis les nouvelles versions).

Amélioration du modèle en faisant une moyenne et calculant aussi dans le fragment shader. Rendu joli mais on voit la grille du tiling and blending, je ne comprends pas pourquoi
