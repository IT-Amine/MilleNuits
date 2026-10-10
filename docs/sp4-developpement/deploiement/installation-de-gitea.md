# SP 4 - Mission 1 - Déploiement et configuration Initiale de Gitea

<div style="margin-top: 20px; border: 1px solid #ccc; padding: 20px; border-radius: 10px; background-color: var(--md-default-bg-color);">
    <p><strong>Auteur :</strong> KADA Amine</p>
    <p><strong>Classe :</strong> BTS SIO 2 - Option SISR</p>
    <p><strong>Date :</strong> 10/10/2026</p>
    <p><strong>Version :</strong> 1.0</p>
</div>



**SP 4 : Mise en place d’un espace de développement**

**Mission 1 : Mise en place d’un environnement de test conteneurisé dans une DMZ interne avec Docker et préparation d’une formation développeurs.**


---

## Informations générales

  - **Date de création** : 09/04/2026
  - **Dernière modification** : 09/04/2026
  - **Mainteneur** : KADA Amine

---

## Sommaire

  - A. Déploiement de l'infrastructure (Docker Compose)
  - B. Configuration initiale via l'interface Web

---

## A. Déploiement de l'infrastructure (Docker Compose)

Avant l'instanciation des services, la gestion des secrets doit être rigoureusement traitée conformément aux politiques de sécurité de l'infrastructure.

1.  **Génération et sauvegarde des secrets.** Générer un mot de passe cryptographiquement robuste pour la base de données PostgreSQL de l'application. Ce secret doit impérativement être consigné dans le coffre-fort Bitwarden de l'équipe système avec une nomenclature explicite (ex : `Gitea - Pré-production MN21 - DB Password`) avant toute manipulation sur l'infrastructure.

2.  **Préparation du fichier de déploiement.** Utiliser le fichier de configuration ci-dessous pour configurer Gitea sur le serveur de pré-production (MN21).

     [Docker compose - Gitea](./docker-compose_gitea.txt)

3.  **Injection des variables d'environnement dans Portainer.** Pour des raisons de sécurité, les secrets ne sont pas stockés en clair dans le code. Ils doivent être transmis dynamiquement lors de la création de la *Stack* dans Portainer.

    - Sur la page de configuration de la pile (Stack), faire défiler jusqu'à la section **Environment variables**.
    - Cliquer sur le bouton **Add an environment variable**.
    - Renseigner les champs comme suit :
        - **name** : `GITEA_DB_PASSWORD`
        - **value** : *[Coller le mot de passe préalablement sauvegardé dans Bitwarden]*
    - Répéter cette opération si d'autres variables d'environnement personnalisées sont ajoutées au fichier de déploiement.

---

## B. Configuration initiale via l'interface Web

Une fois les conteneurs instanciés, le service Gitea nécessite une configuration d'amorçage.

1. **Accès au portail d'installation.** Ouvrir un navigateur web et accéder à l'URL de l'application sur le port configuré.

    http://portainer.millenuits.lan:3000 ou http://gitea.millenuits.lan:3000

2. **Paramètres de la base de données.** Renseigner les champs permettant à Gitea de se connecter à l'instance PostgreSQL isolée.

    - **Type de base de données :** Sélectionner `PostgreSQL`.
    - **Hôte :** Saisir `gitea-db:5432` (correspond au nom du service Docker et à son port interne).
    - **Nom d'utilisateur :** Saisir `gitea`.
    - **Mot de passe :** Saisir le mot de passe défini dans le fichier Docker Compose.
    - **Nom de base de données :** Saisir `gitea`.
    - **SSL :** Sélectionner `Disable` (le trafic réseau étant chiffré et isolé dans le réseau virtuel Docker).

3. **Configuration générale.** Définir les paramètres d'identification et d'accessibilité du serveur.

    - **Titre du site :** Renseigner le nom souhaité (ex: `Gitea - Millenuits`).
    - **Domaine du serveur :** Saisir le nom de domaine (ex: `gitea.millenuits.lan`).
    - **Port du serveur SSH :** Laisser la valeur par défaut `22` (correspond au port interne du conteneur).
    - **Port d'écoute HTTP de Gitea :** Laisser la valeur par défaut `3000`.
    - **URL de base de Gitea :** Saisir l'URL complète avec le port `http://gitea.millenuits.lan:3000/`.

4. **Validation.** Descendre en bas de la page et cliquer sur le bouton d'installation. L'application va générer ses fichiers de configuration (`app.ini`) et redémarrer automatiquement pour appliquer les paramètres.