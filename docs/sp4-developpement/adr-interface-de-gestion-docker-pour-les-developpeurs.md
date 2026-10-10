# SP 4 - Mission 1 - ADR : Interface de gestion Docker pour les développeurs

<div style="margin-top: 20px; border: 1px solid #ccc; padding: 20px; border-radius: 10px; background-color: var(--md-default-bg-color);">
    <p><strong>Auteur :</strong> KADA Amine</p>
    <p><strong>Classe :</strong> BTS SIO 2 - Option SISR</p>
    <p><strong>Date :</strong> 10/10/2026</p>
    <p><strong>Version :</strong> 1.0</p>
</div>



**SP 4 : Mise en place d’un espace de développement**

**Mission 1 : Mise en place d’un environnement de test conteneurisé dans une DMZ interne avec Docker et préparation d’une formation développeurs.**


---

## Informations générales

  - **Date de création** : 03/04/2026
  - **Dernière modification** : 03/04/2026
  - **Mainteneur** : KADA Amine

---

## Sommaire

  - A. Définition des besoins de l'environnement de développement
  - B. Comparatif des solutions envisagées
  - C. Conclusion et Décision (ADR)

---

## A. Définition des besoins de l'environnement de développement

L'objectif est de fournir un environnement autonome aux développeurs tout en respectant les normes de sécurité de l'infrastructure.

1.  **Hébergement de stacks complètes.** Capacité à déployer des environnements hétérogènes (PHP, base de données MariaDB, frontend Javascript) via des fichiers `docker-compose`.
2.  **Gestion des données et images.** Possibilité de créer et d'attacher des volumes persistants pour les bases de données, et de tirer/gérer des images Docker personnalisées.
3.  **Sécurité et isolation (Zero-Shell).** C'est le besoin critique : les développeurs **ne doivent pas** avoir d'accès SSH ou de shell interactif sur la machine hôte. L'interaction doit se faire exclusivement via une interface restreinte.

---

## B. Comparatif des solutions envisagées

Trois approches ont été étudiées pour répondre aux besoins des développeurs dans la DMZ : **Portainer** (GUI Web complète), **Accès CLI / SSH** (Ligne de commande traditionnelle), et **Yacht** (GUI Web légère).

| Critères / Besoins | Portainer | Accès CLI (SSH) | Yacht |
| :--- | :---: | :---: | :---: |
| Déploiement via Docker Compose | ✅ Oui | ✅ Oui | ⚠️ Limité |
| Gestion des volumes persistants | ✅ Oui | ✅ Oui | ✅ Oui |
| Hébergement Stack (PHP, DB, JS) | ✅ Oui | ✅ Oui | ✅ Oui |
| **Sécurité : Aucun accès Shell hôte** | ✅ **Oui** | ❌ **Non** | ✅ **Oui** |
| Facilité d'utilisation (Interface Web) | ✅ Oui | ❌ Non | ✅ Oui |

### Analyse des avantages et inconvénients

1.  **Accès CLI (SSH classique)**

      * **Avantages :** Natif, aucune ressource supplémentaire requise, flexibilité maximale.
      * **Inconvénients :** Échec critique sur le besoin de sécurité (donne un accès shell à l'hôte). Exige des compétences d'administration système de la part des développeurs.

2.  **Yacht**

      * **Avantages :** Interface très légère, facile à déployer, bloque l'accès shell à l'hôte.
      * **Inconvénients :** Gestion des *Stacks* (Docker Compose) moins mature et parfois instable. Communauté plus restreinte.

3.  **Portainer**

      * **Avantages :** Interface web robuste, gestion visuelle complète (conteneurs, volumes, réseaux, images), support natif et avancé des fichiers `docker-compose` (Stacks), et bloque totalement l'accès shell à la machine hôte.
      * **Inconvénients :** Consomme un peu plus de ressources (RAM/CPU) qu'une solution sans interface.

---

## C. Conclusion et Décision (ADR)

**Décision :** Nous choisissons de déployer **Portainer**.

**Justification :** Portainer est la seule solution qui valide l'intégralité du cahier des charges avec un niveau de fiabilité adapté à un environnement professionnel.

Le critère bloquant de la sécurité est respecté : Portainer agit comme une barrière étanche entre les développeurs et l'OS du serveur. Les développeurs gagnent en autonomie grâce à un éditeur visuel pour écrire et déployer leurs fichiers `docker-compose` (PHP, MariaDB, JS) et gérer leurs volumes persistants, sans jamais compromettre l'intégrité de la machine hôte (aucun accès SSH requis). L'effort de formation est également drastiquement réduit grâce à son interface intuitive.