# Guide utilisation - Ajout de documentation

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

Cette procédure explique comment ajouter ou modifier des documentations sur le dépôt de documentation du projet Millenuits. Elle s'appuie sur le principe de branches de travail (Feature Branch Workflow) afin d'isoler les développements de chaque collaborateur, de protéger la branche principale et d'éviter les conflits de modifications.

---
## Sommaire

- A. Préparation de l'environnement local
- B. Création de la branche de travail
- C. Validation et enregistrement des modifications
- D. Publication et fusion (Merge)
- E. Debug : Résolution des conflits

---
## A. Préparation de l'environnement local

1. **Basculer sur la branche principale.** Assurez-vous d'être sur la branche de référence avant de commencer.

```bash
git checkout main
```

> `git checkout` : Commande permettant de naviguer entre les différentes branches. `main` est le nom de la branche cible.

2. **Mettre à jour le dépôt local.** Récupérez les dernières modifications effectuées par vos collaborateurs.

```Bash
git pull
```

> `git pull` : Commande qui télécharge les données du dépôt distant et les fusionne (merge) immédiatement avec votre branche locale actuelle.

---
## B. Création de la branche de travail

1. **Créer une branche isolée.** Chaque nouvelle documentation ou modification doit posséder sa propre branche, nommée explicitement.

```Bash
git checkout -b ajout-doc-infrastructure
```

> `-b` : Cette option indique à Git de créer une nouvelle branche avec le nom spécifié, puis de basculer automatiquement dessus.

---
## C. Validation et enregistrement des modifications

1. **Ajouter les fichiers modifiés.** Une fois la documentation rédigée, préparez les fichiers à sauvegarder.

```Bash
git add docs/chemin/vers/fichier.md
```

> `git add` : Ajoute les modifications d'un fichier spécifique dans la zone de préparation (staging area), indiquant qu'elles feront partie du prochain commit. Vous pouvez utiliser `git add .` pour inclure tous les fichiers modifiés.

2. **Créer le commit.** Enregistrez vos modifications avec un message clair. Veuillez vous référer au document **"Guide utilisation - Nommage des commits"** pour respecter les conventions du projet.

```Bash
git commit -m "docs: ajout de la procédure de configuration serveur"
```

> `git commit` : Valide les modifications préparées dans l'historique local.
> `-m` : Option permettant de passer le message de validation directement en ligne de commande.

---
## D. Publication et fusion (Merge)

1. **Pousser la branche vers le serveur distant.** Envoyez votre travail sur le dépôt central pour le rendre accessible.

```Bash
git push origin ajout-doc-infrastructure
```

> `git push` : Transfère vos commits locaux vers le serveur.
> `origin` : Nom par défaut désignant le serveur distant.

2. **Créer une demande de fusion.** Rendez-vous sur l'interface web (GitHub/GitLab) pour créer une _Pull Request_ (PR) ou _Merge Request_ (MR) de votre branche vers `main`. Après relecture, la branche pourra être fusionnée.

---
## E. Debug : Résolution des conflits

Un conflit survient lors de la fusion si deux personnes ont modifié la même ligne d'un fichier. Git met alors le processus en pause.

1. **Identifier les fichiers en conflit.**

```Bash
git status
```

> `git status` : Affiche l'état du répertoire de travail. Les fichiers en conflit seront listés en rouge sous la mention "both modified".

2. **Comprendre et corriger le conflit.** Ouvrez le fichier en conflit dans votre éditeur. Vous y verrez des balises insérées par Git :

 **️ Règle de sécurité** : Ne supprimez jamais le code de l'autre sans concertation.

*Éditez le fichier manuellement pour conserver la version finale souhaitée, puis supprimez les balises `<<<<<<<`, `=======` et `>>>>>>>`.*

```Plaintext
<<<<<<< HEAD
Votre texte actuel sur la branche.
=======
Le texte de votre collaborateur provenant de la branche fusionnée.
>>>>>>> nom-de-la-branche-distante
```

3. **Valider la résolution.** Une fois les fichiers corrigés, indiquez à Git que le conflit est résolu.

```Bash
git add le-fichier-corrige.md
git commit -m "fix: résolution du conflit sur la doc infrastructure"
```

> L'enchaînement de `add` et `commit` finalise l'opération de fusion interrompue par le conflit.
