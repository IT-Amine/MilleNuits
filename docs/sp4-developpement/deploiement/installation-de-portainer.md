# SP 4 - Mission 1 - Installation de Portainer sur MN21

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

  - **Date de création** : 03/04/2026
  - **Dernière modification** : 03/04/2026
  - **Mainteneur** : KADA Amine

---

## Sommaire

  - A. Préparation de la persistance des données
  - B. Déploiement du conteneur Portainer
  - C. Vérification et premier accès

---

## A. Préparation de la persistance des données

1.  **Création du volume Docker dédié.** Cette action provisionne un espace de stockage géré nativement par Docker, isolé du système de fichiers hôte classique, pour stocker la base de données de Portainer.

    ```bash
    sudo docker volume create portainer_data
    ```

    `docker volume create` : Commande de création d'un volume persistant.

    `portainer_data` : Nom explicite attribué au volume pour faciliter sa gestion future (sauvegardes, migrations).

---

## B. Déploiement du conteneur Portainer

L'installation s'effectue en téléchargeant et en exécutant l'image officielle. Étant donné que le démon Docker est durci (`userns-remap`), nous devons autoriser ce conteneur d'administration à accéder au socket hôte.

1. **Exécution du conteneur avec privilèges d'administration ciblés.** Lancement du service avec attachement au socket Docker et exception de namespace.

    ```bash
    sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always --userns=host -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.40.0-alpine
    ```

    `-d` : Détache le conteneur en arrière-plan.

    `-p 8000:8000` et `-p 9443:9443` : Expose les ports pour l'agent (8000) et l'interface Web HTTPS (9443).

    `--name portainer` : Nomme le conteneur de manière explicite.

    `--restart=always` : Garantit la haute disponibilité (redémarrage automatique en cas de crash).

    `--userns=host` : Cette commande désactive le "User Namespace Remapping" *uniquement* pour ce conteneur. C'est indispensable pour qu'un outil d'administration puisse lire le socket Docker (`/var/run/docker.sock`) avec les droits `root` de l'hôte, tout en maintenant les autres conteneurs isolés.

    `-v /var/run/docker.sock:/var/run/docker.sock` : Connecte Portainer au moteur Docker local.

    `-v portainer_data:/data` : Attache le volume persistant pour les configurations.

---

## C. Vérification et premier accès

1.  **Vérification du statut du service.** S'assurer que le conteneur est en cours d'exécution et écoute sur les ports définis.

    ```bash
    sudo docker ps --filter "name=portainer"
    ```

    `docker ps` : Liste les conteneurs actifs.

    `--filter "name=portainer"` : Isole l'affichage au seul conteneur nommé "portainer" pour une lecture concise.

2.  **Initialisation de l'administrateur.** Accéder à l'interface web pour configurer le compte root de l'application.

      * Ouvrez un navigateur web et accédez à : `https://[IP-DU-SERVEUR-MN21]:9443`
      * Acceptez l'avertissement de sécurité lié au certificat auto-signé.
      * Créez le mot de passe du compte administrateur initial (cette étape doit être réalisée dans les 5 minutes suivant le lancement du conteneur par mesure de sécurité).

---

## Annexe

- Install Portainer CE with Docker on Linux