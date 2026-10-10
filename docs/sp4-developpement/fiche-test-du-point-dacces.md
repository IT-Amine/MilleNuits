# SP 4 - Mission 2 - Configuration du Wifi

<div style="margin-top: 20px; border: 1px solid #ccc; padding: 20px; border-radius: 10px; background-color: var(--md-default-bg-color);">
    <p><strong>Auteur :</strong> KADA Amine</p>
    <p><strong>Classe :</strong> BTS SIO 2 - Option SISR</p>
    <p><strong>Date :</strong> 10/10/2026</p>
    <p><strong>Version :</strong> 1.0</p>
</div>



**SP 4 : Mise en place d’un espace de développement**

**Mission 2 : Création d’un sous-réseau développeurs avec accès Wi-Fi sécurisé**


---

## Informations générales

  - **Date de création** : 30/04/2026
  - **Dernière modification** : 30/04/2026
  - **Mainteneur** : KADA Amine

___
## Fiche de Test Réseau : Validation de la Connectivité Wi-Fi

**Projet :** Configuration réseau Dev-Millenuit

**Date du test :** 30 Avril 2026

**Équipement source :** Laptop Dev (connecté via SSID `dev-millenuit-dreamteam`)

### 1. Synthèse des tests de connectivité (ICMP)

Le tableau suivant récapitule les tests effectués dans l'environnement de simulation :

|**Source**|**Destination**|**Type**|**Résultat**|**Observation**|
|---|---|---|---|---|
|**Laptop Dev**|MN21 - Environnement de dev|ICMP|**Succès**|La liaison sans fil et l'accès au serveur de dev sont opérationnels.|
|**Laptop Dev**|PC VENTE|ICMP|**Échec**|L'accès vers le réseau VENTE est bloqué (attendu si segmentation présente).|
|**PC VENTE**|Laptop Dev|ICMP|**Échec**|Le réseau VENTE ne peut pas joindre la machine de développement.|

---

### 2. Protocole de validation pour la maquette physique

Lors du passage au matériel réel, les étapes suivantes devront être validées pour confirmer le bon fonctionnement malgré le masquage du SSID :

- **Test de visibilité :** Vérifier que le SSID `dev-millenuit-dreamteam` n'apparaît pas dans la liste des réseaux Wi-Fi disponibles.
    
- **Test d'association manuelle :** Configurer manuellement le profil sur le **Laptop Dev** avec :
    
    - **SSID :** `dev-millenuit-dreamteam`
        
    - **Sécurité :** WPA2-PSK (AES)
        
    - **Clé :** `Dev5-SaNs!-la`
        
- **Test de Persistance :** Redémarrer le Laptop et vérifier que la reconnexion automatique au SSID caché s'effectue correctement.
    

### 3. Conclusion des tests

Les tests actuels confirment que le **Laptop Dev** communique parfaitement avec son environnement dédié (**MN21**). L'isolation entre le réseau de développement et le PC VENTE est également validée par les échecs de ping mutuels.

___
