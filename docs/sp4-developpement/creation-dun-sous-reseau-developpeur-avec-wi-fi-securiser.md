# SP 4 - Mission 2 - Plan d'adressage

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

  - **Date de création** : 02/04/2026
  - **Dernière modification** : 30/04/2026
  - **Mainteneur** : KADA Amine

---

## Contexte 

Il faut mettre en place un nouveaux sous-réseau pour que les développeurs puissent se connecter via un Wi-Fi spécifique, mais avant de mettre en place ce réseau il faut tout d'abord établir le plan d'adressage.

## 1. Plan d'adressage

Voici le plan d'adressage de tout le réseau avec le VLAN 16 dédier pour les développeurs,

| **Nom**       | **N° VLAN** | **Adresse Réseau** | **Masque (CIDR)**        | **Passerelle** | **Diffusion (Broadcast)** |
| ------------- | ----------- | ------------------ | ------------------------ | -------------- | ------------------------- |
| Production    | 10          | 172.40.0.0         | 255.255.255.0 (/24)      | 172.40.0.254   | 172.40.0.255              |
| Autres        | 11          | 172.40.1.0         | 255.255.255.128 (/25)    | 172.40.1.126   | 172.40.1.127              |
| Administratif | 12          | 172.40.1.128       | 255.255.255.128 (/25)    | 172.40.1.254   | 172.40.1.255              |
| VentesEtudes  | 13          | 172.40.2.0         | 255.255.255.192<br>(/26) | 172.40.2.62    | 172.40.2.63               |
| Logistique    | 14          | 172.40.2.64        | 255.255.255.192 (/26)    | 172.40.2.126   | 172.40.2.127              |
| Invité        | 15          | 172.40.2.128       | 255.255.255.240<br>/28   | 172.40.2.142   | 172.40.2.143              |
| Management    | 99          | 172.40.2.144       | 255.255.255.240<br>/28   | 172.40.2.158   | 172.40.2.159              |
| Developpeur   | 16          | 172.40.2.160       | 255.255.255.240<br>/28   | 172.40.2.174   | 172.40.2.175              |
| Serveurs      | 51          | 172.16.51.0        | 255.255.255.0<br>/24     | 172.16.51.252  | 172.16.51.255             |
| DMZ           | 53          | 10.10.10.0         | 255.255.255.0<br>/24     | 10.10.10.254   | 10.10.10.255              |

## 2. Limiter l'accès

Pour plus de sécurité il faut autoriser l'accès à cet access point seulement aux développeurs, nous utiliserons une pass phrase qui se définit sur notre access point et nous autorisons seulement les personnes faisant parties du bon VLAN à y accéder

#### Paramètre du Access Point :

__Nom__ : AP_Dev
__SSID__ : dev-millenuit-dreamteam
__Pass-phrase__ : Dev5-SaNs!-Ia

L'Access point feras partie du VLAN développeur ce qui va lui permettre d'accéder à la DMZ et de recevoir son adresse IP via le Serveur DHCP.

Pour pouvoir limiter les accès au Vlan développeur nous pouvons mettre en place des ACL dans le but de contrôler les communication vers le Vlan souhaiter (ici le vlan 16), en autre de permettre au Vlan DEV de communiquer avec la DMZ, d'empêcher Internet de communiquer avec le Vlan sans quel le Vlan ne l'ai interroger en premier et enfin interdire tout connexion des autres Vlan vers le Dev.

Voici le Groupe d'ACL écrit en console sur le routeur de MilleNuits.

```bash 
ip access-list extended Filtrage_Dev 

! 1. Autoriser explicitement le trafic vers la DMZ 
permit ip 172.40.2.160 0.0.0.15 10.10.10.0 0.0.0.255 

! 2. Autoriser UNIQUEMENT le retour du trafic TCP de la DMZ (réponses aux requêtes du Dev) 
permit tcp 10.10.10.0 0.0.0.255 172.40.2.160 0.0.0.15 established

! 3. Interdire tout accès du Dev vers les autres réseaux privés internes
deny ip 172.40.2.160 0.0.0.15 172.40.0.0 0.0.255.255 

! 4. Autoriser l'accès à Internet pour les développeurs
permit ip 172.40.2.160 0.0.0.15 any

! 5. Bloquer tout le reste (Implicit deny pour les logs) : 
deny ip any any

! Application de l'ACL sur l'interface du VLAN Développeur
interface GigabitEthernet0/0.16
 ip access-group Filtrage_Dev in
 exit
```