# Fiche de Procédure et de Recette : Intégration NAS et Partages Réseau

**Projet :** Mille Nuits
**Infrastructure :** Windows Server 2019 (MN01) & TrueNAS SCALE (MN03)
**Objectif :** Intégrer le NAS au domaine Active Directory, provisionner les partages réseau et automatiser le montage via GPO avec gestion stricte des droits (NTFS).

---

## PARTIE 1 : Fiche de Procédure

### Phase 1 : Préparation et Jonction au Domaine (Active Directory)

1. **Synchronisation temporelle (NTP) :**
   * *Prérequis vital pour Kerberos (écart max autorisé : 5 minutes).*
   * Accéder au Shell de TrueNAS.
   * Forcer la synchronisation avec l'AD : `sudo chronyc -a makestep` (ou paramétrer l'IP du serveur Windows comme serveur NTP exclusif dans *System Settings > General*).
2. **Jonction au domaine :**
   * Dans TrueNAS, naviguer vers **Credentials > Directory Services > Active Directory**.
   * **Domain Name :** `MN01.lan` (ou le nom du domaine).
   * **Domain Account Name :** `Administrateur`.
   * **Domain Account Password :** *Mot de passe administrateur du domaine*.
   * Cochez **Enable** et sauvegarder.
   * *Vérification :* Le statut doit passer à **HEALTHY**.

### Phase 2 : Création de l'espace de stockage et du partage SMB

1. **Création du Dataset :**
   * Naviguer vers **Storage**.
   * Sur le pool principal, ajouter un Dataset (ex: `Partages_MilleNuits`).
   * **Share Type :** `SMB` (Obligatoire pour la gestion des droits NTFS).
2. **Configuration du partage réseau :**
   * Naviguer vers **Shares > Windows (SMB) Shares**.
   * Ajouter le chemin pointant vers le dataset précédemment créé.
   * Nommer le partage (ex: `Dossiers_Pro`).
   * Vérifier que le paramètre *Allow Guest Access* est désactivé.

### Phase 3 : Gestion des droits d'accès (Permissions NTFS)

> **Note :** La gestion fine des droits s'effectue directement depuis le serveur Windows pour une intégration parfaite avec les groupes de sécurité de l'AD.

1. Depuis le serveur Windows (connecté en Administrateur du domaine), accéder au chemin réseau : `\\172.16.52.3\Dossiers_Pro`.
2. Créer l'arborescence des services (dossiers *Administratif*, *Direction*, *Ventes*, etc.).
3. Pour chaque dossier, configurer la sécurité :
   * Clic droit > **Propriétés** > Onglet **Sécurité** > **Avancé**.
   * Cliquer sur **Désactiver l'héritage** (Convertir les autorisations héritées).
   * **Supprimer** les groupes permissifs : `Tout le monde`, `Utilisateurs du domaine` et `builtin_users` (groupe natif TrueNAS).
   * **Ajouter** le groupe de sécurité AD correspondant au service (ex: `Groupe_Ventes`) et lui attribuer les droits de **Modification**.

### Phase 4 : Automatisation du montage réseau (GPO)

1. Sur le serveur Windows, ouvrir la **Gestion de stratégie de groupe**.
2. Créer une nouvelle GPO (ex: `GPO_Lecteur_NAS`) et la lier à l'Unité d'Organisation (UO) contenant les utilisateurs finaux.
3. Éditer la GPO : naviguer vers **Configuration utilisateur > Préférences > Paramètres Windows > Mappages de lecteurs**.
4. Créer un nouveau lecteur mappé :
   * **Action :** Mettre à jour.
   * **Emplacement :** `\\172.16.52.3\Dossiers_Pro` *(Le nom du partage doit obligatoirement être spécifié à la fin).*
   * **Reconnecter :** Activé.
   * **Lettre :** `Z:` (ou autre lettre définie).

---

## PARTIE 2 : Cahier de Recette (Tests et Validation)

| ID Test | Description du Test | Méthode de validation | Résultat Attendu | Statut |
| :--- | :--- | :--- | :--- | :---: |
| **TEST-01** | Jonction du NAS au domaine | Sur TrueNAS, vérifier *Credentials > Local Users*. Filtrer par *Active Directory Users*. | Les utilisateurs et groupes de l'AD (`MN010\admins du domaine`) apparaissent dans la liste TrueNAS. | ✅ OK |
| **TEST-02** | Accès global au partage réseau | Depuis un PC client, taper `\\172.16.52.3` dans l'explorateur. | Le dossier racine partagé est visible et accessible sans erreur réseau. | ✅ OK |
| **TEST-03** | Application des droits NTFS (Cas Passant) | Connecter l'utilisateur "martin" (Service Ventes). Tenter d'ouvrir et de modifier un fichier dans le dossier `Ventes`. | L'utilisateur accède au dossier, peut créer et supprimer un fichier. | ✅ OK |
| **TEST-04** | Application des droits NTFS (Cas Non-Passant) | Avec le même utilisateur ("martin"), tenter d'ouvrir le dossier `Direction` ou `Administratif`. | Un message d'erreur s'affiche : *"Vous n'avez pas l'autorisation d'accéder à ce dossier"*. Accès refusé. | ✅ OK |
| **TEST-05** | Application de la GPO (Mappage du lecteur) | Ouvrir une session sur un poste client Windows du domaine. Ouvrir "Ce PC". | Le lecteur réseau (ex: `Z:`) apparaît automatiquement, pointant vers le NAS. | ✅ OK |