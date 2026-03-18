# Projet Mille Nuits : Gestion du Parc Informatique

Bienvenue sur la documentation technique officielle du projet **SP2 - Mille Nuits**.
Ce site regroupe l'ensemble des procédures, comparatifs et guides techniques réalisés pour la modernisation de l'infrastructure informatique du service administratif.

---

## Contexte du Projet

Le service administratif de **Mille Nuits** a initié une refonte de son parc informatique. Les postes actuels (Windows 8) sont obsolètes.

**Objectifs principaux :**
> * Remplacer et moderniser les postes de travail (Windows 11).
> * Industrialiser le déploiement des nouveaux postes.
> * Fiabiliser la gestion des incidents et le support utilisateur.

---

## Architecture et Environnement

Cette documentation s'appuie sur l'environnement technique suivant :

| Catégorie | Équipements / Logiciels |
| :--- | :--- |
| **Infrastructure** | Ferme de serveurs (Hyperviseur Nutanix) |
| **Réseau** | Routeur Cisco 1921, Switch Cisco 2960, Borne Wifi DLink |
| **Serveurs** | Serveurs Linux (MN06 pour GLPI, MN08 pour FOG) |
| **Clients** | 20 Postes Windows 11 (Firefox, LibreOffice, VLC) |

---

## Suivi des Missions

### [Mission 1 : Documentation](mission1/comparatif.md)
*Mise en place de l'environnement de documentation collaborative.*

**Outils :** Markdown, MkDocs, GitHub Pages.

**Statut :** Validé.

### [Mission 2 : Installation Postes Clients](mission2/master.md)
*Préparation du master Windows 11 et configuration logicielle.*

**Cible :** Création d'un poste maître avec compte Administrateur local.

**Logiciels :** Firefox, LibreOffice, VLC, Lecteur PDF.

### [Mission 3 : Déploiement Automatisé](mission3/fog.md)
*Mise en place d'une solution de clonage pour les 19 autres postes.*

**Solution retenue :** Serveur FOG (Linux).

**Objectif :** Déploiement multicast rapide.

### [Mission 4 : Gestion d'Incidents (GLPI)](mission4/glpi.md)
*Professionnalisation du support technique.*

**Problème actuel :** Gestion informelle et perte d'informations.

**Solution :** Mise en place d'un outil de ticketing (GLPI) pour le suivi et les statistiques.

---

## Informations Projet
**Date de livraison finale :** 12 Mars 2026
<br>
**Équipe :** 2 Étudiants (Amine & Lucka)
