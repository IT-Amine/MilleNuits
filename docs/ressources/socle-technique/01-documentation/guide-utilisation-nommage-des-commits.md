# Guide utilisation - Nommage des commits

<div style="margin-top: 20px; border: 1px solid #ccc; padding: 20px; border-radius: 10px; background-color: var(--md-default-bg-color);">
    <p><strong>Auteur :</strong> KADA Amine</p>
    <p><strong>Classe :</strong> BTS SIO 2 - Option SISR</p>
    <p><strong>Date :</strong> 10/10/2026</p>
    <p><strong>Version :</strong> 1.0</p>
</div>




---
## Informations générales

- **Date de création** : 17/03/2026
- **Dernière modification** : 17/03/2026
- **Mainteneur** : KADA Amine

---
## Contexte

Ce guide d'utilisation présente les règles de nommage des commits sur le dépôt du projet. L'objectif est d'adopter un standard professionnel, basé sur la spécification *Conventional Commits*, pour rendre l'historique du projet lisible, propre et compréhensible par tous les collaborateurs. Un historique bien nommé permet de savoir immédiatement ce qui a été modifié sans avoir à analyser les fichiers un par un.

---
## Matrice de nommage

La syntaxe d'un message de commit doit toujours respecter la structure suivante : 

`type: description de l'action`.

**Matrice présentant les différentes règles de nommage sur le dépôt :**

| Nom du commit (Type) | Description |
| -------------------- | ----------- |
| `docs:` | **Ajout ou modification de texte.** Utilisé pour la rédaction pure des fichiers Markdown.<br>*Exemple : `docs: ajout de la procédure d'installation Debian`* |
| `feat:` | **Nouvelle fonctionnalité.** Utilisé lors de l'ajout d'un nouvel élément technique au site (comme un plugin MkDocs).<br>*Exemple : `feat: ajout du module de recherche sur le site`* |
| `fix:` | **Correction.** Utilisé pour corriger une erreur, une coquille, ou réparer un lien mort dans un document.<br>*Exemple : `fix: correction de l'adresse IP du serveur DNS`* |
| `style:` | **Mise en forme.** Utilisé pour les corrections de formatage (espaces, alignement de tableaux) sans impact sur le contenu.<br>*Exemple : `style: alignement de la matrice des flux`* |
| `refactor:` | **Restructuration.** Utilisé lors du déplacement ou du renommage de fichiers/dossiers sans modifier l'information.<br>*Exemple : `refactor: déplacement des schémas vers le dossier ressources`* |
| `chore:` | **Maintenance.** Utilisé pour les tâches invisibles pour le lecteur final (mise à jour de configuration).<br>*Exemple : `chore: mise à jour du fichier mkdocs.yaml`* 