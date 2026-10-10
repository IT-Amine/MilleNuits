# Mille Nuits - Documentation d'Infrastructure (BTS SIO)

Bienvenue sur le dépôt documentaire du projet **Mille Nuits**, réalisé dans le cadre du BTS SIO (option SISR). 

Ce dépôt contient l'ensemble des procédures, recettes et documentations techniques visant à refondre, centraliser et sécuriser l'infrastructure informatique de l'entreprise fictive Mille Nuits.

## 📌 À propos du projet

L'objectif de ce projet est de répondre à deux grandes Situations Professionnelles (SP) :

* **SP2 - Gestion du Parc Informatique :** Renouvellement des postes clients (Windows 11), automatisation du déploiement via FOG Project et mise en place d'un centre de services (Helpdesk) avec GLPI.
* **SP3 - Services d'Infrastructure :** Implémentation d'un domaine Active Directory (Windows Server 2019), d'un service DHCP sécurisé (Kea sur Debian) géré via relais Cisco, et d'une solution de stockage centralisée (TrueNAS).

## 🚀 Consultation de la documentation

La documentation a été générée de manière statique à l'aide de **Zensical** (basé sur le format TOML et Markdown).

### Pour visualiser le site localement :
1. Assurez-vous d'avoir Python et Zensical d'installés.
2. Clonez ce dépôt.
3. Lancez le serveur local :
   ```bash
   zensical serve
   ```
4. Ouvrez votre navigateur sur `http://127.0.0.1:8000`.

## 📂 Structure du projet

Conformément aux standards de l'audit technique et des bonnes pratiques, la documentation est structurée selon l'arborescence suivante (Kebab-case) :

```
├── docs/
│   ├── index.md                      # Page d'accueil du projet
│   ├── sp2-parc/
│   │   ├── clients/                  # Procédures Master et Sysprep
│   │   ├── deploiement/              # Configuration et déploiement FOG
│   │   ├── documentation/            # Choix techniques et comparatifs
│   │   └── support/                  # Documentation ITSM (GLPI)
│   └── sp3-services/
│       ├── ad-dns/                   # Création de domaine et sécurisation DNS
│       ├── dhcp/                     # Service ISC/Kea DHCP et Agent relais Cisco
│       └── stockage/                 # Implémentation TrueNAS
├── zensical.toml                     # Fichier de configuration du générateur
└── README.md                         # Ce fichier
```

## 🔒 Sécurité et Bonnes pratiques
Tous les documents respectent les conventions professionnelles attendues d'un administrateur système (absence de mots de passe en clair, plans de retour arrière, tests de recette systématiques et commandes vérifiées).

---
*Projet réalisé par Amine & Lucka - Classe de BTS SIO 2 (SISR)*
