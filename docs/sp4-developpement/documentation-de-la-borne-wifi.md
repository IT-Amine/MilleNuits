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

---
## Documentation : Configuration du Point d'Accès Sans Fil (AP_Dev)

Cette section détaille la configuration Wi-Fi mise en place pour permettre la communication entre l'équipement **AP_Dev** et le terminal **Laptop Dev**.

### 1. Paramètres de Diffusion (SSID)

Le réseau sans fil est identifié par les paramètres suivants :

- **SSID :** `dev-millenuit-dreamteam`

- **Canal (2.4 GHz) :** 6

- **Portée de couverture :** 140 mètres


> **Note importante :** Pour la phase de test sur simulateur, le SSID est actuellement visible. Cependant, lors du passage à la **maquette physique**, le SSID sera **caché** (Broadcast désactivé) pour renforcer la discrétion du réseau.

### 2. Sécurité et Authentification

Pour garantir l'intégrité des données et restreindre l'accès au réseau, le protocole de sécurité suivant a été appliqué :

- **Type d'authentification :** WPA2-PSK

- **Chiffrement :** AES (Advanced Encryption Standard)

- **Clé partagée (Passphrase) :** `Dev5-SaNs!-la`


### 3. Connectivité Client

Le terminal **Laptop Dev** doit être configuré avec les mêmes paramètres de sécurité (WPA2-AES) et la clé correspondante pour établir la liaison sans fil avec l'Access Point. Une fois le SSID caché sur la maquette physique, la connexion devra se faire par une configuration manuelle du profil réseau sur le laptop.

___
