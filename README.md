# Envoi_demails_en_masse
Projet du groupe WESTCOAST MARSEILLE du mardi 17 avril 2018















@Sam
@maxime
@jerome
@audreycouture
@damien

Programme pour scapper les emails et infos des mairies de Haute Corse, Bouches du Rhône et des Deux Sèvres, leur envoyer des mails promotionnels pour THP et les suivre sur twitter.

Méthode:
-Faire un git clone avec l'url
-Modifier le fichier a_modifier.env avec vos clés twitter puis renommer en .env
-Modifier le fihier a_modifier.json avec votre user et code gmail puis renommer en config.json
-faire un bundle install sur le dossier Envoie_demails_en_masse pour utiliser notre gemfile
-suivre les instruction de la gem gmail sur votre terminal


arborescence:
Le dossier
│
├── Scrappeur.rb
├── Mails.rb
├── Twitter.rb
├── README.md
├── .gitignore
├── a_modifier.json
├── a_modifier.env
├── logo_thp.png
├── Gemfile
└── Gemfile.lock (fichier apparaissant avec le bundle, ne pas le toucher)


Nous avons récupéré les noms des villes de Haute Corse, Bouches du Rhône et Deux sèvres. Les adresses mails de leurs mairies et leur département réspectifs que nous avons renseignés dans un fichier csv partagé sur google drive. Environ 500 mails multiplés par quelques tentatives ont été envoyés avec un joli logo de THP.

================================================================================


CONSIGNES

Le projet, en détails

Le CEO de get-email-corp est vraiment ravi de ton travail. Il veut donc monter une équipe de hackeurs et vous nommer en charge de la filliale send-email-corp, qui vient de décrocher un contrat à 300k€ pour une startup qui s'appelle The Hacking Project. Votre mission est d'envoyer un email à toutes les mairies de trois départements de votre choix et de leur dire qu'ils devraient monter un groupe THP dans leur commune.
⚠️ Il est à noter qu'il est INTERDIT de le faire pour le département du Val d'Oise (ainsi que pour le 75 qui n'a pas assez de mairies). Le but est d'apprendre, pas de copier-coller ?

1. Le scrappeur

Le programme de scrappeur devra récupérer les emails de trois départements choisis arbitrairement par vous. Puis il devra enregistrer ces emails dans un fichier CSV/JSON/Google-Spreadsheet. Pour chaque mairie, il devra y mettre :
l'email
Le nom de la commune
Le département (numéro ou nom)

2. Envoyer les emails

Le programme d'envoi d'emails va reprendre chaque colonne de ton CSV/JSON/Google-Spreadsheet et enverra un bel email à la mairie indiquée. Pour ceux qui ont peur d'utiliser leur adresse Gmail perso, vous êtes bien entendu libres d'utiliser une adresse d'une fausse personne, comme par exemple "Théophile Coutaind", vous n'aurez qu'à nous transférer les emails vers nous.
Une méthode send_email_to_line fait très bien l'affaire. Elle prendra l'email en colonne B, et lui enverra un message, qui pourra être alterné en fonction du nom de la mairie en colonne A.
Tu peux la coupler à une méthode go_through_all_the_lines
Je te conseille de faire une méthode get_the_email_html qui prend le nom de la ville concernée, et qui renvoie un beau HTML
(Aussi, nous te conseillons de partir sur un fichier sreadsheet qui contient des adresses email tests afin de voir si ça marche, avant d'envoyer la masse)
Pour l'email, tu peux créér un truc simple en HTML qui dit un truc du genre :
Bonjour,
Je m'appelle [PRÉNOM], je suis élève à The Hacking Project, une formation au code gratuite, sans locaux, sans sélection, sans restriction géographique. La pédagogie de ntore école est celle du peer-learning, où nous travaillons par petits groupes sur des projets concrets qui font apprendre le code. Le projet du jour est d'envoyer (avec du codage) des emails aux mairies pour qu'ils nous aident à faire de The Hacking Project un nouveau format d'éducation pour tous.

Déjà 300 personnes sont passées par The Hacking Project. Est-ce que la mairie de [NOM_COMMUNE] veut changer le monde avec nous ?


Charles, co-fondateur de The Hacking Project pourra répondre à toutes vos questions : 06.95.46.60.80

3. Petite relance Twitter
Un programme qui n'envoie que des emails, c'est un appel à pas de réponse ? Nous allons donc mettre en place une stratégie pour faire en sorte que les mairies se souviennent de nous avec un petit ping sur Twitter.
Le bot Twitter aura deux parties :
Un premier programme qui va repasser sur chaque élément du CSV/JSON/Google-Spreadsheet et ajouter une colonne supplémentaire avec le handle twitter
une recherche avec mairie [NOM_COMMUNE] en prenant le premier résultat devrait faire l'affaire ;)
Un second programme qui prend la colonne des handle Twitter, et qui follow les users concernés. Avec un compte genre "Apprendre à coder" c'est pas mal



