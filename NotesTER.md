Réunion toutes les 2 semaines

Travail à faire :

- Lecture/Code/Contribution ptet

Mettre en place 

- Git
- Cahier de labo
  - Document où on note TOUT et on n'efface rien
  - Important pour la note d'orga et pour que l'encadrant voit ce que je fais

Implémentation supporte la science

Lire la référence 

- Color-mapped noise vector field for generating procedural micro-pattern
- Real-time terrain enhancement with controlled procedural patterns

Récap : 
Texture générée par les maths

2 textures qui partent de uv sur un carré
1 donne le x
1 donne le y
et on échantillone une texture à partir du x y qui donne une hauteur qui donnera la vague

Point biblio : **GOOGLE SCHOLAR**

- Accès libre à la fac
- Types de papiers 
  - Articles => Court mais pointu
  - Etats de l'art => Long mais parle de tout
  - Thèses   => Long ET pointu
- FAIRE PLUSIEURS LECTURES
  - Première lecture : abstract puis intro puis conclusion => Comprendre les grandes lignes
- Avoir un document où j'ai des résumés d'articles pour simplifier le rapport

Pour semaine pro : résumé d'articles 5-10 lignes
Quoi/Pourquoi (et comment rapidement)

**Jeudi 6 14h** => Venir avec des questions

Rendu le 27 mai
Rapport le 20 mai rendu
Essayer d'avoir un premier jet le 27 avril pour repasser plusieurs fois sur le rapport et être sur

Relire bien le 2e article

Se familiariser avec l'algorithme de Tiling et Blending (Pavage et Mélange)

- Prendre 3 tuiles d'un bruit et pouvoir générer un bruit à l'intersection des 3

Puis utiliser ça pour faire bouger la texture

Faire glisser le bruit final

Faire glisser les tuiles du pavage et mélange pour un meilleur résultat

Faire changer la valeur de l'exemple : les sinusoïdes qui génèrent le bruit gaussien

Faire bouger la fonction de transfert (essayer de trouver des idées dans l'exemple que j'avais codé)

Lundi 24 14h

Pour doctorat : S'y prendre vraiment à l'avance pour essayer d'avoir un financement

Jeudi 6 14h

Vendredi 14 à 14h

OUBLIE PAS LE CAHIER DE LABO ET LES RESUMES D'ARTICLE

Faire résumé d'articles et les centraliser

COMMENCER L EXPERIMENTATION LE PLUS RAPIDEMENT EN FAISANT DES MESURES

Mardi 25 15h30

avril résultats + rapport et mai prêt o7

Rapport : 

intro

Etat de l'art

ce que je propose + tests et avis dessus

conclusion

Que mettre dans l'intro 

vagues : 

Approche eulerienne : discrétiser l'espace => Tu fais bouger des valeurs dans un espace discret (maps)

Approche lagrangienne : discrétiser la matière => Vertex displacement

Ici on fait les 2 => Prise de recul sur l'état de l'art

outil :

Grenier : noise vector fields : Modèle xy pour les vagues

Terrain enhancement : générer les 2 images

Les 2 s'appuient sur le Pavage et Mélange (Tiling and Blending) HN18 => Background methamituque

Important dans un rapport :

Contexte => Définitions

Problématique => Qu'est-ce qu'on fait et pourquoi c'est compliqué ?

Etat de l'art => Où on se situe par rapport aux autres travaux

A LIRE :

SIMULATING OCEAN WATERS TESSENDORF

https://people.computing.clemson.edu/~jtessen/reports/papers_files/coursenotes2004.pdf

A simple model of ocean waves, fournier reeves

https://dl.acm.org/doi/pdf/10.1145/15886.15894
