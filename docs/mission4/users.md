# DOCUMENTATION : GESTION DES UTILISATEURS GLPI

Ce document détaille la stratégie de gestion des accès et la procédure de création des comptes dans le système de Helpdesk (GLPI) pour l'infrastructure Mille Nuits. L'objectif est de garantir le principe de moindre privilège selon le rôle de chaque collaborateur.

## 1. MATRICE DES RÔLES ET PROFILS

Afin de sécuriser l'accès aux données et de simplifier l'interface pour les utilisateurs finaux, les comptes sont répartis selon les profils natifs de GLPI.

| Type d'Utilisateur | Identifiant (Exemple) | Profil GLPI | Droits et Permissions Accordés |
| :--- | :--- | :--- | :--- |
| **Administrateur** | `admin.sys` | **Super-Admin** | Accès total. Configuration du système, gestion des règles, création des utilisateurs et habilitations. |
| **Chef Informatique** | `manager.it` | **Supervisor** | Gestion globale du parc et du support. Peut assigner les tickets aux techniciens et consulter les statistiques. |
| **Support (Technicien)** | `tech.support` | **Technician** | Gestion de l'inventaire matériel et traitement/résolution des tickets d'incidents. Ne peut pas modifier la structure de GLPI. |
| **Employé (Client)** | `u.ventes` | **Self-Service** | Accès restreint au portail simplifié. Permet uniquement de créer un ticket d'assistance et de suivre ses propres demandes. |

## 2. PROCÉDURE DE CRÉATION D'UN COMPTE

La création d'un utilisateur et l'attribution de ses droits s'effectuent en deux étapes distinctes depuis un compte Super-Admin.

### Étape A : Création de l'identité
1. Naviguer dans le menu **Administration > Utilisateurs**.
2. Cliquer sur l'icône **+ (Ajouter)**.
3. Renseigner les informations obligatoires :
   * **Identifiant :** *(ex: initiale.nom)*
   * **Mot de passe :** *(Définir un mot de passe temporaire robuste)*
   * **Nom de famille et Prénom**
4. Valider en cliquant sur **Ajouter**.

### Étape B : Attribution des habilitations (Le Profil)
Une fois l'utilisateur créé, la fiche détaillée s'affiche :
1. Dans le menu de gauche de la fiche utilisateur, sélectionner l'onglet **Habilitations**.
2. Dans le bloc d'affectation :
   * Sélectionner l'**Entité** cible (ex: *Entité racine*).
   * Sélectionner le **Profil** défini dans la matrice (ex: *Technician*).
3. Cliquer sur **Ajouter** pour lier le profil à l'utilisateur.

<div class="calc-box">
⚠️ <strong>Attention :</strong><br>
Par défaut, GLPI peut attribuer automatiquement le profil "Self-Service" lors de la création d'un compte. Il est impératif de vérifier et de purger les habilitations incorrectes dans ce même onglet.
</div>

## 3. FICHE DE RECETTE (TESTS DE VALIDATION)

Tests effectués pour s'assurer de l'étanchéité des droits entre les différents profils configurés.

| ID Test     | Action Réalisée                                           | Résultat Attendu                                                           |                Statut                 |
| :---------- | :-------------------------------------------------------- | :------------------------------------------------------------------------- | :-----------------------------------: |
| **GLPI-01** | Connexion avec le compte **Employé** (`u.ventes`)         | Interface simplifiée affichée. Menu "Administration" et "Parc" invisibles. | <span class="status-ok">VALIDÉ</span> |
| **GLPI-02** | Création d'un ticket par l'**Employé**                    | Le ticket est bien enregistré et visible dans ses demandes en cours.       | <span class="status-ok">VALIDÉ</span> |
| **GLPI-03** | Connexion avec le compte **Technicien** (`tech.support`)  | Accès au parc matériel et à la file d'attente des tickets.                 | <span class="status-ok">VALIDÉ</span> |
| **GLPI-04** | Tentative de création d'utilisateur par le **Technicien** | Option indisponible (droits insuffisants).                                 | <span class="status-ok">VALIDÉ</span> |