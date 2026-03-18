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
# Préparation au Clonage : Sysprep

## 1. Qu'est-ce que Sysprep ?

**Sysprep** (System Preparation Tool) est un utilitaire Microsoft natif indispensable lors du déploiement d'images Windows.

Il permet de **"généraliser"** une installation Windows. Concrètement, il nettoie le système de toutes les informations spécifiques à la machine sur laquelle il a été installé, afin de pouvoir cloner ce disque dur sur d'autres ordinateurs.

---

## 2. Pourquoi est-ce obligatoire ?

Chaque installation de Windows possède un **SID (Security Identifier)** unique. C'est la carte d'identité numérique de la machine sur le réseau.

### Le problème :
Si nous clonons notre "Master" tel quel sur 19 autres postes :

* Les 20 ordinateurs auront le **MÊME SID**.
* **Conséquences :** Conflits graves dans l'Active Directory, problèmes de mises à jour (WSUS), et instabilité réseau.

### La solution Sysprep :
L'action de "Généraliser" va :

1. Supprimer le SID unique.
2. Supprimer le nom de l'ordinateur.
3. Supprimer les pilotes matériels spécifiques (pour forcer une redétection au démarrage).
4. Remettre le système en mode "OOBE" (Out-Of-Box Experience), c'est-à-dire l'écran de bienvenue comme au premier démarrage.

---

## 3. La Procédure Technique

Sur notre machine virtuelle "Master-MilleNuits-W11", une fois tous les logiciels installés (Firefox, LibreOffice, VLC...), voici la procédure à suivre **en tout dernier lieu**.

### Étape 1 : Lancer l'outil

1. Ouvrir l'explorateur de fichiers.
2. Se rendre dans : `C:\Windows\System32\Sysprep\`
3. Exécuter le fichier **`sysprep.exe`** en tant qu'administrateur.

### Étape 2 : Configuration (Crucial)

Une fenêtre s'ouvre. Il faut impérativement choisir les options suivantes :

* **Action de nettoyage du système :**
  * Choisir : `Entrer en mode OOBE (Out-of-Box Experience)`
  * Cocher la case : **`Généraliser`** (C'est l'option la plus importante !).

* **Options d'arrêt :**
  * Choisir : `Arrêter le système` (Shutdown).

### Étape 3 : Validation
1. Cliquer sur **OK**.
2. Sysprep va travailler quelques instants ("Traitement de la phase de généralisation...").
3. La VM va s'éteindre toute seule.

---

## ⚠️ Avertissement Important

**UNE FOIS LA VM ÉTEINTE APRÈS LE SYSPREP, NE LA RALLUMEZ SURTOUT PAS !**

* **Si vous la rallumez :** Windows va générer un nouveau SID immédiatement. Votre image n'est plus "généralisée". Il faut refaire le Sysprep.
* **La bonne action :** Laisser la VM éteinte et passer immédiatement à la **Mission 3**.