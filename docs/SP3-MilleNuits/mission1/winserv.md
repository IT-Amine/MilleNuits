# DOCUMENTATION : CONFIGURATION ET MISE EN PLACE DE L'ACTIVE DIRECTORY (VM NUTANIX)

## 1. CONFIGURATION DE LA MACHINE VIRTUELLE
La machine virtuelle a été déployée sur l'infrastructure Nutanix avec les caractéristiques matérielles suivantes, permettant de faire fonctionner de manière fluide un contrôleur de domaine sous Windows Server :

* **Processeurs :** 2 vCPU
* **Mémoire vive (RAM) :** 4 Go
* **Stockage :** 50 Go

## 2. IDENTITÉ DU SERVEUR ET RÉSEAU
Le serveur a été renommé et configuré de manière statique afin d'être identifiable de façon pérenne sur le réseau et dans le domaine.

| Paramètre                 | Valeur attribuée      |
| :------------------------ | :-------------------- |
| **Nom de la machine**     | MN01                  |
| **Nom NetBIOS**           | MN010                 |
| **Adresse IP**            | 172.16.52.1           |
| **Masque de sous-réseau** | 255.255.255.0         |
| **Passerelle par défaut** | 172.16.52.252         |
| DNS                       | 172.16.52.1 & 1.1.1.1 |

## 3. SÉCURITÉ ET COMPTES D'ADMINISTRATION
Dans le cadre du durcissement du serveur, les mots de passe par défaut ont été modifiés. Ce compte Administrateur permet la gestion complète du serveur et de la forêt Active Directory.

<div class="calc-box">
🔐 <strong>Politique de mots de passe :</strong>
<ul>
<br>
<li><strong>Compte Administrateur :</strong> L'ancien mot de passe (<code>Etudiant_007</code>) a été remplacé par <code>Mille_Nuits26!</code>.</li>
<br>
<li><strong>Mode DSRM :</strong> Le mot de passe du Directory Services Restore Mode (utilisé en cas de crash et de restauration de l'annuaire) a également été défini sur <code>Mille_Nuits26!</code>.</li>
</ul>
</div>

## 4. DÉPLOIEMENT DU SERVICE ACTIVE DIRECTORY

### 4.1. Installation du rôle AD DS
Le rôle **Active Directory Domain Services (AD DS)** a été installé via l'interface graphique selon la procédure suivante :

1. Ouverture du **Gestionnaire de serveur**.

2. Clic sur **Gérer** > **Ajouter des rôles et des fonctionnalités**.

3. Dans la sélection des rôles, la case **Services AD DS** a été cochée (ainsi que l'ajout des fonctionnalités requises).

4. Validation des étapes jusqu'à l'installation complète du rôle.

### 4.2. Promotion en Contrôleur de Domaine
Une fois le rôle installé, le serveur a été promu pour créer le nouveau domaine de l'entreprise :

1. Clic sur l'icône de notification (drapeau jaune) dans le Gestionnaire de serveur.

2. Sélection de l'option **Promouvoir ce serveur en contrôleur de domaine**.

3. Choix de l'opération : **Ajouter une nouvelle forêt**.

4. Saisie du nom de domaine racine : `MN01.lan`.

5. Saisie du mot de passe de restauration DSRM (`Mille_Nuits26!`).

6. Lancement des vérifications préalables, puis clic sur **Installer**. Le serveur redémarre automatiquement à la fin du processus.

### 4.3. Structuration de l'annuaire
Afin d'organiser logiquement les objets de l'entreprise, des Unités d'Organisation (OU) ont été créées à la racine du domaine :

* 📁 Administratif

* 📁 Direction

* 📁 Logistique

* 📁 Production

* 📁 Vente

Cette structuration permet une meilleure gestion des utilisateurs, des groupes et la future application de stratégies de groupe (GPO).

## 5. CRÉATION DES UTILISATEURS ET GROUPES
Afin de respecter l'organisation fonctionnelle du domaine, un groupe de sécurité a été créé pour chaque OU (ex: *Groupe Administratif*, *Groupe Logistique*, etc.). Chaque utilisateur a ensuite été affecté à l'OU et au groupe correspondant à son service.

| Unité d'Organisation | Utilisateur | Identifiant / UPN | Mot de passe |
| :--- | :--- | :--- | :--- |
| **Administratif** | a.martin | `MN01\martin` | M@rtin1234 |
| **Logistique** | c.durand | `MN01\durand` | Dur@nd1234 |
| **Direction** | l.petit | `l.petit@MN01.lan` | Pet@t1234 |
| **Vente** | v.leroy | `v.leroy@MN01.lan` | Lero@1234 |
| **Production** | p.moreau | `p.moreau@MN01.lan` | More@u1234 |

<div class="calc-box">
ℹ️ <strong>Bénéfice des Groupes de Sécurité :</strong><br>
L'intégration des utilisateurs dans leurs groupes respectifs permet une gestion optimisée des droits, une administration simplifiée des accès aux ressources (comme les partages fichiers NAS) et une utilisation plus efficace des stratégies de sécurité.
</div>

## 6. SÉCURISATION DU SERVICE DNS

Le rôle DNS ayant été installé conjointement à l'AD DS, une configuration de sécurité spécifique a été appliquée : **la récursivité DNS a été désactivée.**

### 6.1. Procédure de désactivation

1. Ouverture de la console **Gestionnaire DNS** depuis les Outils d'administration.

2. Clic droit sur le nom du serveur (`MN01`) et sélection de **Propriétés**.

3. Dans l'onglet **Avancé**, la case **Désactiver la récursivité (désactive également les redirecteurs)** a été cochée, puis validée.

### 6.2. Objectifs de cette configuration
Cette action permet de :

* Empêcher le serveur de résoudre des noms externes (Internet).

* Limiter les réponses aux seules requêtes internes au domaine `MN01.lan`.

* Améliorer la sécurité globale du service DNS en évitant les attaques de type *DNS Amplification*. Le serveur fonctionne ainsi uniquement pour sa zone locale.