

# Comparatif des Solutions de Déploiement

## Objectif de l'étude
Dans le cadre du renouvellement du parc informatique de **Mille Nuits**, nous devons déployer une image Windows 11 standardisée sur 20 postes clients .
Pour éviter une installation manuelle fastidieuse, nous avons comparé trois solutions du marché permettant d'industrialiser ce processus via le réseau.

---

## Tableau Comparatif

Nous avons analysé **FOG Project**, **Clonezilla Server** et **Microsoft WDS/MDT**.

| Critères                 | **FOG Project** (Retenu)   | **Clonezilla Server** (Alternative) | **Microsoft WDS / MDT**                 |
| :----------------------- | :------------------------- | :---------------------------------- | :-------------------------------------- |
| **Type**                 | Open Source (Libre)        | Open Source (Libre)                 | Propriétaire                            |
| **Coût**                 | **Gratuit**                | **Gratuit**                         | Payant (Licences Windows Server + CALs) |
| **OS Serveur**           | Linux (Debian, Ubuntu...)  | Linux (DRBL)                        | Windows Server uniquement               |
| **Interface de gestion** | **Interface Web complète** | Ligne de commande / Texte           | Console MMC (Complexe)                  |
| **Mode de déploiement**  | Unicast & **Multicast**    | Unicast & Multicast                 | Unicast & Multicast                     |
| **Gestion de parc**      | Oui (Inventaire, Snapins)  | Non (Clonage pur)                   | Oui (Très complet)                      |

---

## Analyse Détaillée

### 1. FOG Project
Solution de clonage open-source basée sur une interface web.

* **Fonctionnalités :** Capture et déploiement d'images, gestion d'inventaire, déploiement de logiciels (Snapins), gestion des imprimantes.

* **Points forts :** Gratuit, interface web intuitive, gestion du **Multicast** (permet de cloner les 20 postes en même temps sans saturation), fonctionne sur le serveur Linux MN08 disponible.

* **Points faibles :** Configuration initiale du réseau (DHCP/PXE) parfois délicate.

### 2. Clonezilla Server (SE)
La version serveur du célèbre outil de clonage de disque.

* **Fonctionnalités :** Clonage de masse efficace.

* **Points forts :** Très léger, très rapide, gratuit.

* **Points faibles :** Pas d'interface de gestion centralisée persistante (pas de base de données des machines), interface utilisateur "vieillissante" (ncurses), moins adapté à la gestion de parc sur le long terme.

### 3. Microsoft WDS + MDT
La solution standard de Microsoft pour les entreprises.

* **Fonctionnalités :** Déploiement natif, injection de pilotes dynamique, personnalisation poussée.

* **Points forts :** Intégration parfaite avec l'Active Directory et Windows.

* **Points faibles :** **Coût élevé** (nécessite des licences Windows Server), lourd à mettre en place pour "seulement" 20 postes, incompatible avec notre contrainte de serveur Linux MN08.

---

## Choix de la Solution : FOG Project

Conformément à la décision de la DSI , nous avons retenu **FOG Project**.

**Justification du choix :**

1.  **Coût :** La solution est gratuite, contrairement aux solutions Microsoft .

2.  **Infrastructure :** Elle s'installe nativement sur le serveur **MN08** (Linux) mis à disposition .

3.  **Efficacité :** La gestion du Multicast permet de déployer les 19 postes restants simultanément en un temps record.

4.  **Gestion :** L'interface Web permet une gestion centralisée des incidents et des tâches, facilitant la maintenance future.