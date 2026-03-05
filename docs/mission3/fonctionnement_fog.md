# Fonctionnement de FOG & Interaction Sysprep

## 1. Qu'est-ce que FOG Project ?

**FOG** (Free Open Source Ghost) est une solution de clonage et de gestion de parc informatique open-source.
Elle permet de capturer l'image d'un disque dur (le Master) pour la redescendre (déployer) sur un grand nombre d'ordinateurs via le réseau.

**Pourquoi FOG pour Mille Nuits ?**

* **Gratuit :** Répond à la contrainte budgétaire.
* **Interface Web :** Gestion centralisée de tout le parc.
* **Rapidité :** Utilise le Multicast pour déployer 20 postes en même temps sans saturer le réseau.

---

## 2. Architecture Technique



FOG ne fonctionne pas seul, il s'appuie sur plusieurs services réseaux standards :

1.  **DHCP :** L'ordinateur client démarre et demande une IP. Le DHCP lui répond et lui dit : *"Va voir le serveur FOG (Option 66/67)"*.
2.  **TFTP / PXE :** Le client télécharge un petit système de démarrage via le réseau (iPXE).
3.  **NFS / FTP :** Utilisés pour transférer les gros fichiers de l'image disque.
4.  **Base de données (MariaDB) :** Stocke l'inventaire des machines (adresses MAC, noms, images associées).

---

## 3. Le Cycle de Vie : Sysprep ➔ FOG ➔ Déploiement

C'est ici que tout se joue. Voici la chronologie exacte des opérations pour réussir la Mission 3.

### Phase A : La Préparation (Côté Master)
1.  On installe Windows et les logiciels sur la VM.
2.  **On lance Sysprep (Généraliser + Éteindre).**
    * *État :* La VM est éteinte, sans identité (pas de nom, pas de SID), prête à être dupliquée.

### Phase B : La Capture (Côté Serveur FOG)
1.  On déclare l'adresse MAC de la VM Master dans l'interface Web de FOG.
2.  On programme une tâche de **"Capture"**.
3.  On allume la VM Master en **Boot Réseau (PXE)**.
    * ⚠️ *Important :* Elle ne doit pas démarrer sur son disque dur (sinon Sysprep s'annule), mais sur la carte réseau.
4.  FOG prend le relais, lit le disque dur "sysprepé", le compresse et l'envoie sur le serveur MN08.

### Phase C : Le Déploiement (Côté Clients)
1.  On démarre les 19 nouveaux PC en Boot Réseau (PXE).
2.  FOG écrit l'image sur leurs disques durs.
3.  Au redémarrage, Windows se lance.
4.  **Grâce au Sysprep :** Windows détecte qu'il est sur un nouveau matériel. Il génère un **nouveau SID unique** et installe les pilotes spécifiques.

---

## 4. Résumé du Workflow

| Étape | Outil         | Action                                                |
| :---- | :------------ | :---------------------------------------------------- |
| 1     | **Windows**   | Installation OS + Logiciels (Firefox, VLC...).        |
| 2     | **Sysprep**   | Suppression du SID et extinction.                     |
| 3     | **BIOS/UEFI** | Démarrage en PXE (Réseau).                            |
| 4     | **FOG**       | Capture de l'image vers le serveur MN08.              |
| 5     | **FOG**       | Descente de l'image sur les 20 postes clients.        |
| 6     | **Windows**   | Finalisation (OOBE) automatique au premier démarrage. |