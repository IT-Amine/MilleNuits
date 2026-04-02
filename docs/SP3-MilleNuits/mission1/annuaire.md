# 📂 PROJET MILLE NUITS - SP3
**Documentation :** Arborescence Active Directory (MN01)
**Date :** 02/04/2026
**Auteur :** KADA Amine

---

## 1. CONTEXTE ET EXIGENCES
Suite à la promotion du serveur **MN01** (IP: `172.16.52.1`) en tant que contrôleur du domaine `MN01.lan`, il est nécessaire de structurer l'annuaire. Conformément au cahier des charges, l'infrastructure doit refléter l'organisation de l'entreprise :

* Création d'une **Unité d'Organisation (UO)** par service pour regrouper les postes et imprimantes.
* Création de **Groupes de Sécurité** pour la gestion des droits d'accès aux fichiers (NAS).
* Création de **deux comptes utilisateurs** par service affectés à leurs groupes respectifs.

---

## 2. STRUCTURE LOGIQUE DÉPLOYÉE
Afin d'isoler les objets de l'entreprise des conteneurs par défaut de Windows, une UO racine `MilleNuits` a été créée.

```text
📁 MN01.lan (Domaine Racine)
└── 📁 MilleNuits (UO Racine de l'entreprise)
    ├── 📁 Administratif (UO)
    │   ├── 👥 Groupe_Administratif (Groupe de sécurité)
    │   └── 👤 2 Utilisateurs (membres du groupe)
    ├── 📁 Direction (UO)
    │   ├── 👥 Groupe_Direction (Groupe de sécurité)
    │   └── 👤 2 Utilisateurs (membres du groupe)
    ├── 📁 Logistique (UO)
    │   ├── 👥 Groupe_Logistique (Groupe de sécurité)
    │   └── 👤 2 Utilisateurs (membres du groupe)
    ├── 📁 Production (UO)
    │   ├── 👥 Groupe_Production (Groupe de sécurité)
    │   └── 👤 2 Utilisateurs (membres du groupe)
    └── 📁 Ventes (UO)
        ├── 👥 Groupe_Ventes (Groupe de sécurité)
        └── 👤 2 Utilisateurs (membres du groupe)
```

## 3. SCRIPT DE DÉPLOIEMENT AUTOMATISÉ (POWERSHELL)

Afin d'éviter les erreurs de saisie manuelles et d'accélérer le déploiement, la structure complète (OUs, Utilisateurs et Groupes) a été générée via un script PowerShell exécuté en tant qu'Administrateur sur le serveur MN01.

PowerShell

```
# 1. Définition des variables de base
$domain = "DC=MN01,DC=lan"
$pwd = ConvertTo-SecureString "MilleNuits2026!" -AsPlainText -Force

# 2. Création de l'UO Racine globale
New-ADOrganizationalUnit -Name "MilleNuits" -Path $domain
$rootOU = "OU=MilleNuits,$domain"

# 3. Liste des services de l'entreprise
$services = @("Administratif", "Direction", "Logistique", "Production", "Ventes")

# 4. Boucle de création automatique (UO, Groupes, Utilisateurs)
foreach ($srv in $services) {
    # Création de l'UO du service
    New-ADOrganizationalUnit -Name $srv -Path $rootOU
    $srvPath = "OU=$srv,$rootOU"
    
    # Création du Groupe de Sécurité pour les droits d'accès
    New-ADGroup -Name "Groupe_$srv" -GroupCategory Security -GroupScope Global -Path $srvPath
    
    # Création Utilisateur 1
    New-ADUser -Name "User1 $srv" -GivenName "User1" -Surname $srv -SamAccountName "u1.$srv" -UserPrincipalName "u1.$srv@MN01.lan" -Path $srvPath -AccountPassword $pwd -Enabled $true
    
    # Création Utilisateur 2
    New-ADUser -Name "User2 $srv" -GivenName "User2" -Surname $srv -SamAccountName "u2.$srv" -UserPrincipalName "u2.$srv@MN01.lan" -Path $srvPath -AccountPassword $pwd -Enabled $true
    
    # Ajout des utilisateurs dans leur groupe de sécurité respectif
    Add-ADGroupMember -Identity "Groupe_$srv" -Members "u1.$srv", "u2.$srv"
}

Write-Host "Le déploiement de l'arborescence Mille Nuits est terminé avec succès !" -ForegroundColor Green
```

> **Politique de sécurité :** Tous les utilisateurs ont été créés avec le mot de passe standardisé `MilleNuits2026!`. Les comptes sont activés par défaut. Les mots de passe n'expirent pas pour faciliter les tests en laboratoire.

---

## 4. PROCÉDURE DE CRÉATION (INTERFACE GRAPHIQUE)

_(Alternative au script PowerShell)_ L'ensemble de la configuration a été réalisé via la console d'administration native de Windows Server.

### Étape A : Accès à la console d'administration

1. Ouvrir le **Gestionnaire de serveur**.
    
2. Dans le menu en haut à droite, cliquer sur **Outils** > **Utilisateurs et ordinateurs Active Directory**.
    

### Étape B : Création des Unités d'Organisation (UO)

1. Faire un clic droit sur le nom du domaine racine (`MN01.lan`).
    
2. Sélectionner **Nouveau** > **Unité d'organisation**.
    
3. Nommer l'UO `MilleNuits` et cliquer sur OK. _(Laisser la case Protéger le conteneur contre une suppression accidentelle cochée)_.
    
4. Faire un clic droit sur cette nouvelle UO `MilleNuits`, sélectionner **Nouveau** > **Unité d'organisation**, et répéter l'opération pour chaque service (_Administratif_, _Direction_, etc.).
    

### Étape C : Création des Groupes de Sécurité (Vital pour le NAS)

> **Attention :** Une UO sert à appliquer des stratégies (GPO) et classer les objets. Pour donner des droits sur des dossiers réseau, il faut obligatoirement créer un **Groupe de Sécurité**.

1. Faire un clic droit sur l'UO du service (ex: _Ventes_) > **Nouveau** > **Groupe**.
    
2. Nommer le groupe (ex: `Groupe_Ventes`).
    
3. S'assurer que le type de groupe est sur **Sécurité** et l'étendue sur **Globale**. Faire OK.
    

### Étape D : Création des Utilisateurs et intégration aux groupes

1. Faire un clic droit sur l'UO cible (ex: _Ventes_) > **Nouveau** > **Utilisateur**.
    
2. Remplir la fiche d'identité (Prénom: _User1_, Nom: _Ventes_, Ouverture de session: _u1.ventes_).
    
3. Définir le mot de passe (`MilleNuits2026!`). Cocher _Le mot de passe n'expire jamais_.
    
4. Une fois l'utilisateur créé, double-cliquer sur le `Groupe_Ventes` créé à l'étape C.
    
5. Dans l'onglet **Membres**, cliquer sur **Ajouter**, taper le nom de l'utilisateur (`u1.ventes`) et valider.
    

>  **Astuce d'administration :** Une fois le premier utilisateur créé, il est possible de faire un clic droit dessus et de choisir **Copier...** pour créer le second utilisateur beaucoup plus rapidement en conservant les paramètres de l'UO et du mot de passe.