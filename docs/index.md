# Projet Mille Nuits : Infrastructure Informatique

<div style="margin-top: 20px; border: 1px solid #ccc; padding: 20px; border-radius: 10px; background-color: var(--md-default-bg-color);">
    <p><strong>Auteur :</strong> Amine & Lucka</p>
    <p><strong>Classe :</strong> BTS SIO 2 - Option SISR</p>
    <p><strong>Date :</strong> 10/10/2026</p>
    <p><strong>Version :</strong> 1.0</p>
</div>



Bienvenue sur la documentation technique officielle du projet **Mille Nuits**.
Ce site regroupe l'ensemble des procédures, comparatifs et guides techniques réalisés pour la modernisation et la sécurisation de l'infrastructure informatique de l'entreprise.

## Plan d'adressage (VLSM) 

| ID VLAN | Service             | Adresse Réseau |      Masque (CIDR)      | Adresse de Diffusion | Passerelle (Gateway) |
| :-----: | :------------------ | :------------- | :---------------------: | :------------------- | :------------------- |
| **30**  | **Production**      | `172.40.0.0`   |  `/24` (255.255.255.0)  | `172.40.0.255`       | **172.40.0.254**     |
| **20**  | **Autres**          | `172.40.1.0`   | `/25` (255.255.255.128) | `172.40.1.127`       | **172.40.1.126**     |
| **10**  | **Administratif**   | `172.40.1.128` | `/25` (255.255.255.128) | `172.40.1.255`       | **172.40.1.254**     |
| **50**  | **Ventes & Études** | `172.40.2.0`   | `/26` (255.255.255.192) | `172.40.2.63`        | **172.40.2.62**      |
| **40**  | **Logistique**      | `172.40.2.64`  | `/26` (255.255.255.192) | `172.40.2.127`       | **172.40.2.126**     |
| **52**  | **Serveurs**        | `172.16.52.0`  |  `/24` (255.255.255.0)  | `172.16.52.255`      | **172.16.52.253**    |

Le projet est divisé en deux grandes situations professionnelles (SP) :

---

## SP2 : Gestion du Parc Informatique

Le service administratif de **Mille Nuits** a initié une refonte de son parc informatique suite à l'obsolescence de ses postes (Windows 8).

**Objectifs principaux :**
> * Remplacer et moderniser les postes de travail vers Windows 11.
> * Industrialiser le déploiement des nouveaux postes via une solution de clonage (FOG).
> * Fiabiliser la gestion des incidents et le support utilisateur avec un outil de ticketing (GLPI).

**Missions de la SP2 :**

* [Mission 1 : Documentation](sp2-parc/documentation/comparatif-editeurs.md) (Mise en place de cet environnement Zensical)

* [Mission 2 : Installation Postes Clients](sp2-parc/clients/masterisation-windows.md) (Préparation du master Windows 11)

* [Mission 3 : Déploiement Automatisé](sp2-parc/deploiement/installation-serveur-fog.md) (Mise en place de FOG)

* [Mission 4 : Gestion d'Incidents](sp2-parc/support/presentation-outil-glpi.md) (Déploiement de GLPI)

---

## SP3 : Gestion des services principaux AD et DHCP

L'entreprise Mille Nuits ne disposait pas de politique de sécurisation ni de gestion centralisée. La SP3 vise à mettre en place une véritable **Gestion des Identités et des Accès**, ainsi qu'à automatiser la configuration réseau.

**Objectifs principaux :**
> * Déployer un domaine Active Directory (Windows Server 2019) pour centraliser l'authentification.
> * Mettre en place un service DHCP (Serveur Linux) pour la distribution automatique des adresses IP.
> * Intégrer une solution de stockage centralisée (NAS) avec redirection de dossiers liée à l'AD.

**Missions de la SP3 :**

* **[Mission 1 : Active Directory & DNS](sp3-services/ad-dns/configuration-windows-server-2019.md)** (Serveur MN01 sous Windows Server 2019)

* **[Mission 2 : Serveur DHCP Linux](sp3-services/dhcp/configuration-relais-cisco.md)** (Serveur MN11 sous Linux et relais DHCP Cisco)

* **[Mission 3 : Serveur NAS](sp3-services/stockage/installation-nas-truenas.md)** (Serveur MN07 intégré à l'AD pour le stockage centralisé)

---

## Informations Projet
**Équipe :** 2 Étudiants (Amine & Lucka)
