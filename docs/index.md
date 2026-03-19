# Projet Mille Nuits : Infrastructure Informatique

Bienvenue sur la documentation technique officielle du projet **Mille Nuits**.
Ce site regroupe l'ensemble des procédures, comparatifs et guides techniques réalisés pour la modernisation et la sécurisation de l'infrastructure informatique de l'entreprise.

Le projet est divisé en deux grandes situations professionnelles (SP) :

---

## SP2 : Gestion du Parc Informatique

Le service administratif de **Mille Nuits** a initié une refonte de son parc informatique suite à l'obsolescence de ses postes (Windows 8).

**Objectifs principaux :**
> * Remplacer et moderniser les postes de travail vers Windows 11.
> * Industrialiser le déploiement des nouveaux postes via une solution de clonage (FOG).
> * Fiabiliser la gestion des incidents et le support utilisateur avec un outil de ticketing (GLPI).

**Missions de la SP2 :**

* [Mission 1 : Documentation](SP2-MilleNuits/mission1/comparatif.md) (Mise en place de cet environnement MkDocs)

* [Mission 2 : Installation Postes Clients](SP2-MilleNuits/mission2/master.md) (Préparation du master Windows 11)

* [Mission 3 : Déploiement Automatisé](SP2-MilleNuits/mission3/fog.md) (Mise en place de FOG)

* [Mission 4 : Gestion d'Incidents](SP2-MilleNuits/mission4/glpi.md) (Déploiement de GLPI)

---

## SP3 : Gestion des services principaux AD et DHCP

L'entreprise Mille Nuits ne disposait pas de politique de sécurisation ni de gestion centralisée. La SP3 vise à mettre en place une véritable **Gestion des Identités et des Accès**, ainsi qu'à automatiser la configuration réseau.

**Objectifs principaux :**
> * Déployer un domaine Active Directory (Windows Server 2019) pour centraliser l'authentification.
> * Mettre en place un service DHCP (Serveur Linux) pour la distribution automatique des adresses IP.
> * Intégrer une solution de stockage centralisée (NAS) avec redirection de dossiers liée à l'AD.

**Missions de la SP3 :**

* **[Mission 1 : Active Directory & DNS](SP3-MilleNuits/mission1/winserv.md)** (Serveur MN01 sous Windows Server 2019)

* **[Mission 2 : Serveur DHCP Linux](SP3-MilleNuits/mission2/cisco.md)** (Serveur MN11 sous Linux et relais DHCP Cisco)

* **Mission 3 : Serveur NAS** (Serveur MN07 intégré à l'AD pour le stockage centralisé)

---

## Informations Projet
**Équipe :** 2 Étudiants (Amine & Lucka)
