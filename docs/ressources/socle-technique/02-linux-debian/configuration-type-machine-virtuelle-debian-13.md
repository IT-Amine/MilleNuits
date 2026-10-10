# Configuration type machine virtuelle Debian 13

<div style="margin-top: 20px; border: 1px solid #ccc; padding: 20px; border-radius: 10px; background-color: var(--md-default-bg-color);">
    <p><strong>Auteur :</strong> KADA Amine</p>
    <p><strong>Classe :</strong> BTS SIO 2 - Option SISR</p>
    <p><strong>Date :</strong> 10/10/2026</p>
    <p><strong>Version :</strong> 1.0</p>
</div>




---
## Informations générales

- **Date de création** : 17/03/2026
- **Dernière modification** : 17/03/2026
- **Mainteneur** : KADA Amine

---
## Contexte

Cette procédure définit la configuration standard d'une machine virtuelle Debian 13 pour le projet Millenuits. Son objectif est de garantir un socle technique commun, sécurisé et uniformisé pour l'ensemble de l'infrastructure avant le déploiement de tout service spécifique.

---
## Sommaire

- A. Installation des paquets utilitaires
- B. Création des comptes nominatifs
- C. Configuration de SUDO
- D. Configuration SSH
- E. Configuration du MOTD

---
## A. Installation des paquets utilitaires

1. **Mise à jour du système.** Actualise la liste des paquets et installe les dernières mises à jour de sécurité.

```bash
apt update && apt upgrade -y
```

> - `apt update` : Met à jour l'index local des paquets disponibles.
> - `&&` : Permet d'enchaîner une seconde commande uniquement si la première a réussi.
> - `apt upgrade` : Installe les nouvelles versions des paquets.
> - `-y` : Valide automatiquement les demandes de confirmation.

2. **Installation des outils d'administration.** Déploie les logiciels indispensables à la gestion quotidienne du serveur.

```Bash
apt install vim curl git htop -y
```

> - `apt install` : Commande d'installation de paquets.
> - `vim` : Éditeur de texte en ligne de commande puissant.
> - `curl` : Outil de transfert de données réseau.
> - `git` : Système de contrôle de version.
> - `htop` : Moniteur système interactif (plus lisible que `top`).

---
## B. Création des comptes nominatifs

1. **Création de l'utilisateur.** Un compte dédié par administrateur garantit la traçabilité des actions.

```Bash
adduser prenom.nom
```

> - `adduser` : Script interactif qui crée l'utilisateur, génère son répertoire personnel (`/home/prenom.nom`), et demande la configuration d'un mot de passe sécurisé.

---
## C. Configuration de SUDO

1. **Installation du paquet.** S'assure que le gestionnaire de privilèges est présent.

```Bash
apt install sudo -y
```

> - `sudo` : Outil permettant à un utilisateur standard d'exécuter des commandes avec les privilèges d'un autre utilisateur (généralement `root`).

2. **Attribution des droits.** Ajoute le compte fraîchement créé au groupe des administrateurs.

```Bash
usermod -aG sudo prenom.nom
```

> - `usermod` : Commande de modification d'un compte utilisateur.
> - `-aG` : Options pour Ajouter (`-a` pour append) l'utilisateur à un Groupe supplémentaire (`-G`). Le groupe ciblé ici est `sudo`.

---
## D. Configuration SSH

1. **Import de la clé publique (Depuis la machine cliente).** Transfère la clé d'authentification vers le serveur.

```Bash
ssh-copy-id prenom.nom@ip-du-serveur
```

> - `ssh-copy-id` : Utilitaire qui copie automatiquement la clé publique locale dans le fichier `~/.ssh/authorized_keys` du serveur distant avec les bonnes permissions.

2. **Sécurisation du service SSH (Sur le serveur).** Désactive les connexions directes en root et l'authentification par mot de passe.

```Bash
sed -i 's/^#*PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
sed -i 's/^#*PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
systemctl restart ssh
```

> - `sed -i` : Édite un fichier directement en ligne de commande. Ici, la commande cherche les chaînes de configuration et les remplace pour interdire les mots de passe et le compte root.
> - `systemctl restart ssh` : Redémarre le service (`daemon`) SSH pour appliquer immédiatement les modifications du fichier de configuration.

---
## E. Configuration du MOTD

1. **Personnalisation du message d'accueil.** Édite le fichier MOTD (_Message Of The Day_) pour avertir les utilisateurs lors de leur connexion.

```Bash
vim /etc/motd
```

> - `/etc/motd` : Fichier texte brut affiché par le système après une connexion SSH réussie.

2. **Insérez le texte suivant dans le fichier :**

```Plaintext
**********************************************************************
*                                                                    *
*       "Un grand pouvoir implique de grandes responsabilités"       *
*                                                                    *
**********************************************************************

RAPPEL DES BONNES PRATIQUES :

1. TOUJOURS mettre à jour avant d'installer (apt update && upgrade).
2. JAMAIS de root direct, utilisez sudo pour tracer les actions.
3. SAUVEGARDEZ avant toute modification critique (cp fichier fichier.bak).
4. SURVEILLEZ les logs en cas d'erreur (/var/log/syslog ou auth.log).
5. FERMEZ les ports inutilisés (UFW/Firewall).
6. TESTEZ vos sauvegardes (une sauvegarde non testée n'existe pas).
7. DOCUMENTEZ vos modifications pour le futur vous.

**********************************************************************
```

