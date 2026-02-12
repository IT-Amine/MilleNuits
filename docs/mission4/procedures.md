# 📘 Procédures de Gestion d'Incidents

Ce guide explique comment utiliser GLPI pour le support informatique de **Mille Nuits**, couvrant le cycle de vie complet d'un ticket.

---

## 1. Création des Utilisateurs
Pour que les salariés d'Angers et Joué-les-Tours puissent déclarer des incidents, des comptes ont été créés.

* **Profil "Self-Service" (Utilisateur standard) :** Peut uniquement créer des tickets et voir ses propres demandes.
* **Profil "Technician" (Service Info) :** Peut voir, s'attribuer et résoudre les tickets.
* **Profil "Admin" :** Configuration complète.

---

## 2. Déclarer un incident (Vue Salarié)

L'utilisateur rencontre un problème (ex: "Pas de connexion internet" ou "Souris HS").

1. Se connecter à GLPI (`glpi.millenuits.lan`).
2. Cliquer sur **"Créer un ticket"**.
3. Remplir les champs :
    * **Type :** Incident.
    * **Catégorie :** Matériel / Réseau / Logiciel.
    * **Urgence :** Moyenne / Haute.
    * **Titre :** Description courte (ex: *PC ne démarre plus*).
    * **Description :** Détail du problème.
4. Valider. Le ticket passe au statut **"Nouveau"**.

---

## 3. Traitement de l'incident (Vue Technicien)

Le service informatique reçoit la demande.

### Étape A : Prise en compte
1. Le technicien se connecte et voit le nouveau ticket dans le tableau de bord.
2. Il ouvre le ticket et change le statut en **"En cours (Attribué)"**.
3. Il s'assigne le ticket (bouton "S'attribuer").

### Étape B : Résolution et Documentation
1. Le technicien intervient (à distance ou sur place).
2. Il ajoute une tâche dans l'onglet **"Traitement du ticket"** pour expliquer ce qu'il a fait (ex: *Remplacement du câble RJ45*).
    * *Cela permet de documenter la solution pour les collègues futurs.*
3. Une fois résolu, il passe le statut à **"Résolu"**.

### Étape C : Clôture
1. L'utilisateur reçoit une notification.
2. Il valide la solution (ou le ticket se clôture automatiquement après 24h).
3. Statut final : **"Clos"**.

---
## 4. Statistiques

Le DSI peut consulter les statistiques globales dans le menu **Accueil > Tableau de bord** :
* Nombre de tickets ouverts ce mois-ci.
* Temps moyen de résolution.
* Technicien le plus actif.