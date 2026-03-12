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

# Installation et Configuration de FOG (Serveur MN08)

Cette documentation décrit la procédure technique pour transformer le serveur **MN08** en serveur de déploiement FOG Project, conformément aux besoins de l'infrastructure **Mille Nuits**.

---

## 1. Prérequis Serveur

Avant d'installer FOG, le serveur Linux (Debian 11/12 ou Ubuntu Server) doit être configuré avec une **adresse IP Statique**. FOG ne peut pas fonctionner correctement avec une IP dynamique (DHCP).

* **Nom du serveur :** FOG-MN08
* **OS :** Linux (Debian 13)
* **IP Statique :** 172.16.52.10 /24
* **Passerelle** : 172.16.52.252 (.254 celui du réseau pédagogique)

---

## 2. Installation de FOG Project
L'installation s'effectue en ligne de commande via le script officiel.

### Étape 2.1 : Téléchargement
Nous utilisons Git pour récupérer la dernière version stable.

```
sudo -i
apt-get update && apt-get install git -y
git clone [https://github.com/FOGProject/fogproject.git](https://github.com/FOGProject/fogproject.git) /opt/fogproject
```

### Étape 2.2 : Lancement du script d'installation
```
cd /opt/fogproject/bin
./installfog.sh
```

### Étape 2.3 : Réponses aux questions de l'installateur

Durant l'installation, voici les choix effectués pour l'environnement Mille Nuits :

1. **OS :** (Détecté automatiquement) - _Debian/Ubuntu_
    
2. **Type of Installation :** `Normal Server` (N)
    
3. **Change Network Interface :** `No` (Garder l'interface par défaut)
    
4. **Setup DHCP Router Address :** `Yes` (Indiquer l'IP du routeur Cisco 1921 )
    
5. **Setup DNS Address :** `Yes` (Indiquer le DNS : 8.8.8.8 ou 1.1.1.1)
    
6. **Would you like to use the FOG server for DHCP Service?**
    
    - _Réponse :_ **OUI** (Si FOG doit gérer le PXE de manière autonome).
        
    - _Réponse :_ **NON** (Si le DHCP est géré par le routeur Cisco ou un serveur Windows. Dans ce cas, il faudra configurer les options 66/67 sur le DHCP existant).
        
7. **Internationalization :** `Yes` (Français)
    

---

## 3. Configuration de l'Interface Web

Une fois le script terminé en console, il demande de se rendre sur une page Web pour créer la base de données.

1. Ouvrir un navigateur sur : `http://<IP_SERVEUR_MN08>/fog/management`
    
2. Cliquer sur le bouton **"Install/Update Now"** pour initialiser la base de données MariaDB.
    
3. Se connecter avec les identifiants par défaut :
    
    - **User :** `admin.sys`
        
    - **Password :** `@dmin26!`
        

> **Sécurité :** La première action réalisée a été de changer le mot de passe par défaut dans _User Management_.

---

## 4. Gestion des Images (Capture & Déploiement)

Pour répondre à la mission de déploiement des 20 postes , voici la procédure configurée :

### A. Enregistrement du Master (Inventory)

1. Démarrer la VM "Master-MilleNuits-W11" en **PXE** (Network Boot).
    
2. Dans le menu FOG qui apparaît, choisir **"Quick Registration"**.
    
3. La machine apparaît dans l'interface Web sous "Hosts".
    

### B. Capture de l'image

1. Dans l'interface Web, aller dans **Images** > **Create New Image**.
    
    - Nom : `Image_W11_Admin`
        
    - OS : Windows 10/11
        
    - Type : Resizable
        
2. Aller dans **Hosts**, sélectionner le Master et lui associer cette image.
    
3. Aller dans **Basic Tasks** > **Capture**.
    
4. Redémarrer le Master en PXE : FOG capture le disque et l'envoie sur le serveur MN08.
    

![[MkDocs-MilleNuits/docs/assets/fog.png]]

---

## 5. Intégration Post-Installation (Snapins)

FOG permet également de pousser des logiciels après le déploiement.

- _Configuration actuelle :_ Le service "FOG Client" est installé sur l'image Master. Il permet au serveur FOG de renommer les machines à distance et de les joindre au domaine automatiquement après le clonage.
