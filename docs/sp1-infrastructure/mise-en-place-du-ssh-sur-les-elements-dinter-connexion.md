**Mission 2 : Mise en place de l'infrastructure réseau**

**Contexte : MilleNuits**


---
## Informations générales

- **Date de création** : 05/03/2026
- **Auteur** : KADA Amine

---
## Sommaire

A. Configuration du SSH sur le routeur
B. Configuration du SSH sur le switch d'interconnexion

---
### A. Configuration du SSH sur le routeur

**1. Activation de SSH et sécurisation des accès.** Le routeur `rt_millenuits-01` nécessite un domaine, des clés de chiffrement et un compte local pour activer SSH.

```CISCO
enable
configure terminal
ip domain-name millenuits.lab
crypto key generate rsa modulus 2048
username admin privilege 15 secret <MOT_DE_PASSE_ADMIN_CISCO>
line vty 0 4
login local
transport input ssh
exit
```

- `enable` : Bascule du mode utilisateur au mode d'exécution privilégié.
- `configure terminal` : Ouvre le mode de configuration globale.
- `ip domain-name` : Définit le nom de domaine, prérequis indispensable à la génération des clés.
- `crypto key generate rsa modulus 2048` : Génère une paire de clés asymétriques RSA de 2048 bits pour chiffrer la connexion.
- `username ... privilege 15 secret ...` : Crée un compte administrateur local avec tous les droits (privilège 15) et un mot de passe fortement chiffré.
- `line vty 0 4` : Entre dans la configuration des 5 premières terminaux virtuels (accès distants).
- `login local` : Exige que les connexions s'authentifient via la base de données locale.
- `transport input ssh` : Bloque Telnet et autorise uniquement le protocole sécurisé SSH.

**2. Ajout du VLAN Management sur le routeur.** Le switch utilise déjà l'IP 172.40.2.145/28 pour le Vlan99. Nous configurons l'IP suivante pour la passerelle sur le routeur.

```CISCO
interface GigabitEthernet0/0.99
encapsulation dot1Q 99
ip address 172.40.2.158 255.255.255.240
exit
```

- `interface GigabitEthernet0/0.99` : Crée et sélectionne une sous-interface logique rattachée à l'interface physique.
- `encapsulation dot1Q 99` : Indique que cette sous-interface traite le trafic taggé pour le VLAN 99 (norme 802.1Q).
- `ip address ...` : Attribue l'adresse IP et le masque de sous-réseau à la passerelle de ce VLAN.

---
### B. Configuration du SSH sur le switch d'interconnexion

**1. Activation de SSH et sécurisation des accès.** La démarche est identique sur le switch `sw_coeur-01` pour uniformiser la sécurité.

```CISCO
enable
configure terminal
ip domain-name millenuits.lab
crypto key generate rsa modulus 2048
username admin privilege 15 secret <MOT_DE_PASSE_ADMIN_CISCO>
line vty 0 15
login local
transport input ssh
exit
```

- _(Les explications des commandes sont identiques à celles du routeur)_.
- `line vty 0 15` : Sur un switch, on sécurise généralement l'ensemble des 16 lignes virtuelles disponibles de 0 à 15.

**2. Affectation du VLAN Management aux ports dédiés.** Nous assignons les ports 23 et 24 au VLAN d'administration existant (Vlan99).

```CISCO
interface range FastEthernet0/23 - 24
switchport mode access
switchport access vlan 99
exit
```

- `interface range ...` : Permet d'appliquer une configuration par lot sur plusieurs interfaces simultanément.
- `switchport mode access` : Force le port à agir comme un port d'accès pour un équipement final (désactive la négociation trunk).
- `switchport access vlan 99` : Place de manière statique les ports ciblés dans le VLAN 99.