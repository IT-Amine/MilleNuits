# SP 4 - Mission 1 - Recette - Espace de développement

<div style="margin-top: 20px; border: 1px solid #ccc; padding: 20px; border-radius: 10px; background-color: var(--md-default-bg-color);">
    <p><strong>Auteur :</strong> KADA Amine</p>
    <p><strong>Classe :</strong> BTS SIO 2 - Option SISR</p>
    <p><strong>Date :</strong> 10/10/2026</p>
    <p><strong>Version :</strong> 1.0</p>
</div>



**SP 4 : Mise en place d’un espace de développement**

**Mission 1 : Mise en place d’un environnement de test conteneurisé dans une DMZ interne avec Docker et préparation d’une formation développeurs.**


-----

## Informations générales

  - **Date de création** : 09/04/2026
  - **Dernière modification** : 09/04/2026
  - **Mainteneur** : KADA Amine

-----

## Sommaire

1.  Test d'isolation réseau (DMZ)
2.  Test de configuration de sécurité Docker (Hardening)
3.  Test de contrôle des accès (Portainer)
4.  Test de déploiement automatisé (GitOps)
5.  Test d'accessibilité des services applicatifs

-----

## 1. Test d'isolation réseau (DMZ)

**Description du test** :

> Vérifier que l'environnement de test est strictement isolé du réseau de production de l'entreprise. Depuis la console du serveur MN21, exécuter une commande de diagnostic réseau (ping) ciblant une adresse IP critique du réseau de production.
> `ping -c 4 [IP_RESEAU_PRODUCTION]`

**Résultats Attendus** :

> Les paquets ICMP doivent être rejetés. Le résultat doit indiquer 100% de perte de paquets ou retourner une erreur "Destination Host Unreachable", confirmant l'imperméabilité de la DMZ vers la production.

Réception :

  - [ ] Reçu
  - [ ] Reçu avec réserve
  - [ ] Refusé :

Commentaire :

|
|
|

-----

## 2. Test de configuration de sécurité Docker (Hardening)

**Description du test** :

> Vérifier l'application des restrictions de sécurité sur le démon Docker du serveur MN21, notamment l'isolation des privilèges (User Namespace Remapping). Exécuter la commande suivante sur l'hôte :
> `docker info | grep userns`

**Résultats Attendus** :

> La commande doit retourner la valeur confirmant l'activation du remappage.
> `Security Options: name=userns`

Réception :

  - [ ] Reçu
  - [ ] Reçu avec réserve
  - [ ] Refusé :

Commentaire :

|
|
|

-----

## 3. Test de contrôle des accès (Portainer)

**Description du test** :

> Vérifier que les accès à l'espace de développement sont limités aux seuls développeurs autorisés[cite: 70]. Se connecter à l'interface d'administration `https://172.16.52.21:9443` en utilisant les identifiants d'un compte développeur standard (non-administrateur).

**Résultats Attendus** :

> L'authentification réussit. Le tableau de bord affiche uniquement l'environnement délégué (local). Les menus d'administration globale du serveur Portainer (Users, Settings) doivent être inaccessibles ou masqués.

Réception :

  - [ ] Reçu
  - [ ] Reçu avec réserve
  - [ ] Refusé :

Commentaire :

|
|
|

-----

## 4. Test de déploiement automatisé (GitOps)

**Description du test** :

> Vérifier que la solution est reproductible facilement via le système de versionning des configurations. Depuis l'interface Portainer d'un développeur, déployer une nouvelle "Stack" en utilisant la méthode "Repository" avec l'URL d'un dépôt Git contenant un fichier `docker-compose.yml` valide.

**Résultats Attendus** :

> Le déploiement s'effectue sans erreur. La liste des conteneurs indique que le conteneur d'initialisation (alpine) s'est exécuté avec succès (Exit 0) et que le service web ainsi que la base de données sont à l'état "running".

Réception :

  - [ ] Reçu
  - [ ] Reçu avec réserve
  - [ ] Refusé :

Commentaire :

|
|
|

-----

## 5. Test d'accessibilité des services applicatifs

**Description du test** :

> Vérifier que l'application de test déployée, incluant un service web et une base de données, est fonctionnelle et accessible depuis le sous-réseau des développeurs. Ouvrir un navigateur depuis un poste de travail développeur et naviguer vers :
> `http://172.16.52.21:8080`

**Résultats Attendus** :

> Le serveur HTTP répond correctement (Code 200). La page d'accueil de l'application PHP s'affiche sans erreur de permission "403 Forbidden" ni erreur de connexion à la base de données MariaDB.

Réception :

  - [ ] Reçu
  - [ ] Reçu avec réserve
  - [ ] Refusé :

Commentaire :

|
|
|