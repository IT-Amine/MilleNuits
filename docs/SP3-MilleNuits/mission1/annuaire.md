

# DOCUMENTATION : ARBORESCENCE ACTIVE DIRECTORY (MN01)

## 1. CONTEXTE ET EXIGENCES

Suite à la promotion du serveur `MN01` (IP: `172.16.52.1`) en tant que contrôleur du domaine `MN01.lan`, il est nécessaire de structurer l'annuaire. Conformément au cahier des charges, l'infrastructure doit refléter l'organisation de l'entreprise :

* Création d'une Unité d'Organisation (UO) par service pour regrouper les postes et imprimantes.
* Création de deux comptes utilisateurs par service.

## 2. STRUCTURE LOGIQUE DÉPLOYÉE

Afin d'isoler les objets de l'entreprise des conteneurs par défaut de Windows, une UO racine "MilleNuits" a été créée.

* 📁 **MN01.lan** (Domaine Racine)
  * 📁 **MilleNuits** (UO Racine de l'entreprise)
    * 📁 **Administratif** (UO - Contient 2 utilisateurs + futurs PC/Imprimantes)
    * 📁 **Direction** (UO - Contient 2 utilisateurs + futurs PC/Imprimantes)
    * 📁 **Logistique** (UO - Contient 2 utilisateurs + futurs PC/Imprimantes)
    * 📁 **Production** (UO - Contient 2 utilisateurs + futurs PC/Imprimantes)
    * 📁 **Ventes** (UO - Contient 2 utilisateurs + futurs PC/Imprimantes)

## 3. SCRIPT DE DÉPLOIEMENT AUTOMATISÉ (POWERSHELL)

Afin d'éviter les erreurs de saisie manuelles et d'accélérer le déploiement, la structure a été générée via un script PowerShell exécuté en tant qu'Administrateur sur le serveur MN01.

```powershell
# 1. Définition des variables de base
$domain = "DC=MN01,DC=lan"
$pwd = ConvertTo-SecureString "MilleNuits2026!" -AsPlainText -Force

# 2. Création de l'UO Racine globale
New-ADOrganizationalUnit -Name "MilleNuits" -Path $domain
$rootOU = "OU=MilleNuits,$domain"

# 3. Liste des services de l'entreprise
$services = @("Administratif", "Direction", "Logistique", "Production", "Ventes")

# 4. Boucle de création automatique des UO et des utilisateurs
foreach ($srv in $services) {
    # Création de l'UO du service
    New-ADOrganizationalUnit -Name $srv -Path $rootOU
    $srvPath = "OU=$srv,$rootOU"
    
    # Création Utilisateur 1
    New-ADUser -Name "User1 $srv" -GivenName "User1" -Surname $srv -SamAccountName "u1.$srv" -UserPrincipalName "u1.$srv@MN01.lan" -Path $srvPath -AccountPassword $pwd -Enabled $true
    
    # Création Utilisateur 2
    New-ADUser -Name "User2 $srv" -GivenName "User2" -Surname $srv -SamAccountName "u2.$srv" -UserPrincipalName "u2.$srv@MN01.lan" -Path $srvPath -AccountPassword $pwd -Enabled $true
}

Write-Host "Le déploiement de l'arborescence Mille Nuits est terminé avec succès !" -ForegroundColor Green
```

<div class="calc-box"> 🔐 <strong>Politique de sécurité :</strong>

Tous les utilisateurs ont été créés avec le mot de passe standardisé <code>MilleNuits2026!</code>. Les comptes sont activés par défaut et prêts à être testés sur les postes clients. </div>

## 4. PROCÉDURE DE CRÉATION (INTERFACE GRAPHIQUE)

L'ensemble de la configuration a été réalisé via la console d'administration native de Windows Server.

## Étape A : Accès à la console d'administration

1. Ouvrir le **Gestionnaire de serveur**.
    
2. Dans le menu en haut à droite, cliquer sur **Outils** > **Utilisateurs et ordinateurs Active Directory**.
    

## Étape B : Création des Unités d'Organisation (UO)

1. Faire un clic droit sur le nom du domaine racine (`MN01.lan`).
    
2. Sélectionner **Nouveau** > **Unité d'organisation**.
    
3. Nommer l'UO `MilleNuits` et cliquer sur OK. (Laisser la case _Protéger le conteneur contre une suppression accidentelle_ cochée).
    
4. Faire un clic droit sur cette nouvelle UO `MilleNuits`, sélectionner **Nouveau** > **Unité d'organisation**, et répéter l'opération pour chaque service (`Administratif`, `Direction`, `Logistique`, etc.).
    

## Étape C : Création des Utilisateurs

Pour chaque service, deux collaborateurs ont été créés :

1. Faire un clic droit sur l'UO cible (ex: `Ventes`) > **Nouveau** > **Utilisateur**.
    
2. Remplir la fiche d'identité :
    
    - **Prénom :** _User1_
        
    - **Nom :** _Ventes_
        
    - **Nom de l'ouverture de session :** `u1.ventes` (@MN01.lan)
        
3. Cliquer sur **Suivant**.
    
4. Définir le mot de passe standardisé (ex: `MilleNuits2026!`).
    
5. Cocher l'option **Le mot de passe n'expire jamais** (pour faciliter les tests en laboratoire) et décocher _L'utilisateur doit changer le mot de passe à la prochaine ouverture de session_.
    
6. Cliquer sur **Suivant** puis **Terminer**.
    

<div class="calc-box"> 💡 <strong>Astuce d'administration :</strong>

  

Une fois le premier utilisateur créé et paramétré, il est possible de faire un clic droit dessus et de choisir <strong>Copier...</strong> pour créer le second utilisateur ("User2") du même service beaucoup plus rapidement, en conservant les paramètres de l'UO et du mot de passe. </div>

## 5. VALIDATION DE L'INFRASTRUCTURE

L'arborescence est désormais visible et structurée proprement dans la console `dsa.msc`. Le contrôleur de domaine est prêt à authentifier les premières connexions des postes clients dès que ces derniers seront intégrés (jonction) au domaine `MN01.lan`.