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

# Comparatif des Éditeurs Markdown

## Objectif
Pour garantir une documentation pérenne et maintenable pour le projet **Mille Nuits**, nous avons comparé trois solutions modernes. L'objectif est de trouver l'équilibre entre :

1. Une rédaction fluide et sans distraction (pour le contenu).
2. La gestion locale des fichiers (pour MkDocs).
3. L'intégration avec le versioning **Git**.

---

## Tableau Comparatif

Nous avons analysé trois outils aux philosophies différentes : **HackMD** (Cloud), **Visual Studio Code** (Tech) et **Obsidian** (Knowledge Base).

| Critères | HackMD | Visual Studio Code (VS Code) | Obsidian |
| :--- | :--- | :--- | :--- |
| **Type** | Éditeur Collaboratif Cloud | IDE (Environnement de Dév) | Gestionnaire de Connaissances |
| **Stockage** | En ligne (Cloud) | Local (Fichiers) | Local (Coffre/Vault) |
| **Prévisualisation**| Double panneau (Split) | Double panneau | **Live Preview** (WYSIWYG) |
| **Prise en main** | Immédiate | Complexe (Technique) | Intuitive et fluide |
| **Gestion Git** | Synchronisation limitée | Native (Terminal intégré) | Via Plugin (Obsidian Git) |
| **Philosophie** | Collaboration temps réel | Développement & Code | **Liens & Structure** |

---

## Analyse Détaillée

### 1. HackMD
Solution entièrement en ligne très populaire pour la prise de notes rapide.
* **Points forts :** Idéal pour travailler à plusieurs en même temps sur un même fichier (comme Google Docs).
* **Points faibles :** Dépendance à Internet. Difficile à intégrer dans un flux de travail automatisé avec MkDocs car les fichiers ne sont pas stockés localement par défaut.

### 2. Visual Studio Code
L'outil standard des développeurs.

* **Points forts :** Puissance absolue. Le terminal intégré permet de lancer `mkdocs serve` directement.
* **Points faibles :** Interface "lourde" pour de la simple rédaction. L'aspect "code" peut distraire de l'écriture du contenu pur.

### 3. Obsidian
Un outil puissant basé sur des fichiers Markdown locaux, conçu pour créer une base de connaissances interconnectée.

* **Points forts :**
    * Travaille directement sur le dossier local (compatible à 100% avec la structure MkDocs).
    * Mode "Live Preview" qui masque la syntaxe Markdown inutile.
    * Gestion des liens entre pages très performante.
    * Extensible via une immense communauté de plugins.
* **Points faibles :** Nécessite l'installation d'un plugin pour gérer Git.

---

## Solution Retenue : Obsidian

Après analyse, nous avons choisi **Obsidian** pour la rédaction de la documentation du projet Mille Nuits.

**Justification du choix :**
Bien que VS Code soit plus complet techniquement, **Obsidian** offre une expérience d'écriture supérieure, indispensable pour produire une documentation claire et riche.

1. **Structure native :** Le "Coffre" Obsidian correspond parfaitement au dossier `docs/` de MkDocs.
2. **Qualité rédactionnelle :** L'interface épurée permet de se concentrer sur le fond (le contenu technique) plutôt que la forme.
3. **Gestion Git :** Grâce au plugin communautaire **"Obsidian Git"**, nous pouvons sauvegarder nos versions automatiquement sans quitter l'interface, répondant ainsi aux exigences de gestion de version du projet.

L'utilisation d'Obsidian garantit une documentation agréable à rédiger et facile à maintenir sur le long terme.