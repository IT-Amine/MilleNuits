<style>
:root {
    --couleur-lycee: #1e3a8a; /* Bleu */
    --couleur-titre: #d97706; /* Orange */
    --gris-clair: #f3f4f6;
}

h1 { color: var(--couleur-lycee); border-bottom: 2px solid var(--couleur-titre); padding-bottom: 10px; }
h2 { color: var(--couleur-lycee); margin-top: 30px; border-bottom: 1px solid #e5e7eb; padding-bottom: 5px; }
h3 { color: #333; border-left: 4px solid var(--couleur-titre); padding-left: 10px; margin-top: 25px; }

/* En-tête */
.header-container { 
    display: flex; align-items: center; justify-content: space-between; 
    margin-bottom: 40px; border-bottom: 1px solid #ddd; padding-bottom: 20px;
}
.logo img { 
    width: 250px; 
    height: auto; 
}
.info-box { text-align: right; color: #555; font-size: 1em; line-height: 1.4; }

/* Tableaux */
table { width: 100%; border-collapse: collapse; margin: 20px 0; border-radius: 5px; overflow: hidden; box-shadow: 0 0 10px rgba(0,0,0,0.05); }
th { background-color: var(--couleur-lycee); color: white; padding: 12px; text-transform: uppercase; font-size: 0.9em; }
td { border: 1px solid #e5e7eb; padding: 10px; text-align: center; }
td:first-child { text-align: left; font-weight: bold; color: var(--couleur-lycee); }
tr:nth-child(even) { background-color: #f9fafb; }

/* Boites */
.calc-box { 
    background-color: var(--gris-clair); 
    border-left: 4px solid var(--couleur-titre); 
    padding: 15px; 
    margin-bottom: 20px; 
    border-radius: 0 5px 5px 0;
}
.status-ok { color: #166534; font-weight: bold; background-color: #dcfce7; padding: 5px 10px; border-radius: 15px; }
</style>

# Procédures de Gestion d'Incidents

Ce guide explique comment utiliser GLPI pour le support informatique de **Mille Nuits**, couvrant le cycle de vie complet d'un ticket.

---

## 1. Création des Utilisateurs
Pour que les salariés d'Angers et Joué-les-Tours puissent déclarer des incidents, des comptes ont été créés.

* **Profil "u.ventes" (Utilisateur standard) :** Peut uniquement créer des tickets et voir ses propres demandes.
* **Profil "tech.support" (Service Info) :** Peut voir, s'attribuer et résoudre les tickets.
* **Profil "admin.sys" :** Configuration complète.

---

## 2. Déclarer un incident (Vue Salarié)

L'utilisateur rencontre un problème (ex: "Pas de connexion internet" ou "Souris HS").

1. Se connecter à GLPI.
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