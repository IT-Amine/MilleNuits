# SP 4 - Mission 1 - Installation de Docker sur MN21

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

  - **Date de création** : 02/04/2026
  - **Dernière modification** : 03/04/2026
  - **Mainteneur** : KADA Amine

---

## Sommaire

  - A. Installation de Docker

---

## A. Installation de Docker

1.  **Préparation du système.** Mise à jour des paquets et installation des dépendances requises pour autoriser APT à utiliser des dépôts HTTPS de manière sécurisée.

    ```bash
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    ```

    `apt-get update` : Met à jour le cache des paquets locaux.

    `ca-certificates` et `curl` : Outils permettant les requêtes web chiffrées.

    `install -m 0755 -d` : Crée le répertoire `/etc/apt/keyrings` (`-d`) en lui attribuant les permissions `0755` (lecture/exécution pour tous, écriture uniquement pour root).

2.  **Ajout de la clé GPG officielle.** Étape indispensable pour garantir l'intégrité et l'authenticité des paquets téléchargés depuis les serveurs de Docker.

    ```bash
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    ```

    `curl -fsSL` : Télécharge le fichier en mode silencieux (`-s`), suit les redirections (`-L`) et renvoie une erreur stricte si le lien échoue (`-f`).

    `-o` : Redirige la sortie du téléchargement vers le fichier spécifié.

    `chmod a+r` : Modifie les droits d'accès pour que tous les utilisateurs (y compris le processus `apt`) puissent lire (`+r`) la clé GPG.

3.  **Ajout des sources de Docker.** Déclaration du dépôt officiel dans le système Debian pour cibler spécifiquement l'architecture matérielle et la version de l'OS.

    ```bash
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    ```

    `dpkg --print-architecture` : Commande récupérant l'architecture du serveur (ex: `amd64`).

    `. /etc/os-release && echo "$VERSION_CODENAME"` : Script inline qui source les variables de l'OS pour extraire le nom de code Debian (ex: `bookworm`).

    `tee` : Outil permettant d'écrire l'entrée standard dans un fichier système avec des droits élevés (`sudo`), tout en redirigeant la sortie console vers le vide (`> /dev/null`).

4.  **Installation des composants.** Déploiement du moteur principal et de l'outillage officiel de Docker.

    ```bash
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    ```

    `docker-ce` : Moteur de conteneurisation communautaire (le démon).

    `docker-ce-cli` : Interface de ligne de commande pour piloter le démon.

    `containerd.io` : Runtime sous-jacent responsable de l'exécution brute des conteneurs.

    `docker-buildx-plugin` et `docker-compose-plugin` : Modules complémentaires gérant les builds avancés et l'orchestration multi-conteneurs.

---

## Annexe

- [Configuration de Docker sur MN21](./SP%204%20-%20Mission%201%20-%20Configuration%20de%20Docker%20sur%20MN21.md)