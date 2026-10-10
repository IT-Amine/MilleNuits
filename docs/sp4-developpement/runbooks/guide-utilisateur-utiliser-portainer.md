# SP 4 - Mission 1 - Guide utilisateur - Utiliser Portainer

<div style="margin-top: 20px; border: 1px solid #ccc; padding: 20px; border-radius: 10px; background-color: var(--md-default-bg-color);">
    <p><strong>Auteur :</strong> KADA Amine</p>
    <p><strong>Classe :</strong> BTS SIO 2 - Option SISR</p>
    <p><strong>Date :</strong> 10/10/2026</p>
    <p><strong>Version :</strong> 1.0</p>
</div>



**SP 4 : Mise en place d’un espace de développement**

**Mission 1 : Mise en place d’un environnement de test conteneurisé dans une DMZ interne avec Docker et préparation d’une formation développeurs.**


---

## Informations générales

  - **Date de création** : 09/04/2026
  - **Dernière modification** : 09/04/2026
  - **Mainteneur** : KADA Amine

---

## Sommaire

  - A. Consultation des journaux (Logs) d'un conteneur
  - B. Vérification des ports exposés par l'application
  - C. Résolution des erreurs courantes sur Portainer

---

## A. Consultation des journaux (Logs) d'un conteneur

La consultation des journaux est l'étape fondamentale pour diagnostiquer un dysfonctionnement. Les logs centralisent la sortie standard (les événements normaux) et les erreurs générées par le processus principal de l'application (comme une erreur de syntaxe PHP ou un échec de connexion SQL).

1. **Accès à la liste des conteneurs.** Dans le menu latéral de gauche de l'interface Portainer, cliquer sur l'onglet **Containers** afin d'afficher l'ensemble des ressources en cours d'exécution.

2. **Ouverture de l'interface des journaux.** Repérer le conteneur lié à l'application. Dans la colonne **Quick actions**, cliquer sur le premier bouton **Logs** (représenté par une icône de document textuel).

3. **Analyse et filtrage des événements.** L'interface affiche l'historique des exécutions. Il est recommandé d'utiliser la fonction **Auto-refresh** (Actualisation automatique) dans les paramètres d'affichage pour voir apparaître les erreurs en temps réel lors de l'actualisation de la page web défectueuse.

---

## B. Vérification des ports exposés par l'application

Afin qu'une application conteneurisée soit accessible, Docker utilise un mécanisme de "Port Mapping". Ce processus relie un port public du serveur Portainer vers le port privé et isolé du conteneur.

1. **Identification du mappage réseau.** Depuis l'interface **Containers**, observer la colonne **Published Ports** sur la ligne correspondant au serveur web de l'application.

2. **Lecture du port public.** Le format affiché est généralement `IP:PortHôte -> PortConteneur` (par exemple : `0.0.0.0:8080->80/tcp`). La valeur située *avant* la flèche indique le port d'écoute sur le serveur hôte. C'est ce port qui doit être utilisé pour joindre l'application.

3. **Accès au service web.** Ouvrir un nouvel onglet dans le navigateur et formuler l'URL en combinant le nom de domaine du serveur et le port identifié à l'étape précédente.

    ```text
    http://portainer.millenuits.lan:<port>
    ```

---

## C. Résolution des erreurs courantes sur Portainer

Cette section documente les incidents classiques liés au déploiement des environnements de développement et leurs procédures de remédiation respectives.

1. **Erreur : "Bind for 0.0.0.0:xxxx failed: port is already allocated"**

    Le port que l'application tente de réserver sur le serveur hôte est déjà utilisé par le projet d'un autre développeur.

    **Solution :** 

      - Modifier le fichier `docker-compose.yml` du dépôt Git. Dans la directive `ports:` du service web, incrémenter le port hôte (la valeur de gauche) avec un port disponible, par exemple en passant de `"8080:80"` à `"8081:80"`.

2. **Erreur : "service didn't complete successfully: exit 1"**

    Le processus principal du conteneur a subi un crash et s'est arrêté prématurément. Cela survient généralement lorsqu'un script d'initialisation échoue ou qu'une variable d'environnement critique est manquante.

    **Solution :** 
    
      - L'interface Portainer ne donnera pas plus de détails sur l'écran d'accueil. Il est impératif d'utiliser la procédure détaillée en **Partie A** pour lire les logs du conteneur arrêté et identifier la nature exacte de l'échec.

3. **Statut : "Unhealthy" sur la base de données**

    Le conteneur MariaDB/MySQL fonctionne, mais les tests de viabilité internes échouent systématiquement, ce qui empêche le serveur web de s'y connecter.

    **Solution :** 
    
      - Vérifier que les variables d'environnement d'authentification (`DB_USER`, `DB_PASSWORD`, `DB_NAME`) injectées via l'interface de Portainer correspondent scrupuleusement à celles attendues par le code de l'application. S'assurer également qu'aucun script d'importation SQL défectueux ne bloque le démarrage complet du moteur de base de données.