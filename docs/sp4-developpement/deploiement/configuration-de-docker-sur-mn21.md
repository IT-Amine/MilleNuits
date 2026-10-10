# SP 4 - Mission 1 - Configuration Sécurisée de Docker (Dev)

<div style="margin-top: 20px; border: 1px solid #ccc; padding: 20px; border-radius: 10px; background-color: var(--md-default-bg-color);">
    <p><strong>Auteur :</strong> KADA Amine</p>
    <p><strong>Classe :</strong> BTS SIO 2 - Option SISR</p>
    <p><strong>Date :</strong> 10/10/2026</p>
    <p><strong>Version :</strong> 1.0</p>
</div>



**SP 4 : Mise en place d’un espace de développement**

**Mission 1 : Mise en place d’un environnement de test conteneurisé dans une DMZ interne avec Docker et préparation d’une formation développeurs.**


---


## Sommaire

  - A. Configuration globale
  - B. Configuration de sécurité (Hardening)

---

## A. Configuration globale

1.  **Création ou modification du fichier de configuration.** Le démon Docker utilise le fichier `daemon.json` pour sa configuration centrale.

    ```bash
    sudoedit /etc/docker/daemon.json
    ```

    `sudoedit` : Permet de modifier un fichier avec les priviliège sudo.

    `/etc/docker/daemon.json` : Chemin absolu vers le fichier de configuration du moteur Docker.

2.  **Mise en place de la rotation des logs et du live-restore.** Ajout des paramètres pour limiter la taille des journaux et maintenir les conteneurs actifs si Docker redémarre.

    ```json
    {
        "log-driver": "json-file",
        "log-opts": {
        "max-size": "10m",
        "max-file": "3"
        },
        "live-restore": true
    }
    ```

    `"log-driver": "json-file"` : Définit le format de journalisation par défaut sur JSON.

    `"max-size": "10m"` : Limite la taille d'un fichier de log à 10 mégaoctets avant rotation.

    `"max-file": "3"` : Conserve un maximum de 3 fichiers de logs par conteneur.

    `"live-restore": true` : Permet aux conteneurs de continuer à fonctionner même si le démon Docker est indisponible ou redémarre.

---

## B. Configuration de sécurité (Hardening)

1.  **Ajout des paramètres d'isolation.** Complétez le fichier `daemon.json` créé à l'étape précédente avec les directives de sécurité.

    ```json
    {
      "log-driver": "json-file",
      "log-opts": {
        "max-size": "10m",
        "max-file": "3"
      },
      "live-restore": true,
      "userns-remap": "default",
      "no-new-privileges": true
    }
    ```

    `"userns-remap": "default"` : Active le mappage des espaces de noms utilisateurs. L'utilisateur `root` (UID 0) à l'intérieur du conteneur est converti en un utilisateur non privilégié (`dockremap`) sur le système hôte. Cela désactive les pleins pouvoirs de root sortant du conteneur.

    `"no-new-privileges": true` : Interdit aux processus du conteneur d'acquérir de nouveaux droits (bloque l'utilisation de `sudo` ou des exécutables SUID dans le conteneur).

2.  **Application de la configuration.** Redémarrage du service pour prendre en compte les nouveaux paramètres.

    ```bash
    sudo systemctl daemon-reload
    sudo systemctl restart docker
    ```

    `systemctl` : Outil de gestion des services sous systemd.

    `restart` : Commande qui arrête puis relance immédiatement le service spécifié.

    `docker` : Nom du service cible.

---

## Annexe

- Linux post-installation steps for Docker Engine