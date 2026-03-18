# DOCUMENTATION : CONFIGURATION DU RELAIS DHCP

## 1. CONTEXTE ET PROBLÉMATIQUE

Dans l'infrastructure Mille Nuits, le serveur DHCP (MN11) est centralisé au sein du VLAN 52 (Serveurs). Par défaut, les requêtes DHCP (qui sont des messages de diffusion "Broadcast") émises par les PC clients des autres VLANs (10, 20, 30, 40, 50) sont bloquées par le routeur. 

Afin de permettre la distribution automatique des adresses IP sur tout le parc, il est nécessaire de configurer un **relais DHCP** (Agent de relais) sur le routeur central.

## 2. PRÉREQUIS

* **Serveur DHCP (MN11) opérationnel :** L'adresse IP fixe du serveur Linux doit être connue. Dans cette procédure, l'adresse utilisée est `172.16.52.11`.
* **Pools configurés :** Les plages d'adresses pour les réseaux `172.40.x.x` doivent être actives sur le serveur.

![[MkDocs-MilleNuits/docs/img/dhcplinux.jpg]]

## 3. PROCÉDURE DE DÉPLOIEMENT (CLI CISCO)

Les commandes suivantes permettent d'indiquer au routeur 1921 de transférer les requêtes DHCP entrantes sur les sous-interfaces clientes directement vers l'adresse IP (Unicast) du serveur MN11.

```
enable
configure terminal

! Configuration du relais pour le VLAN 10 (Administratif)
interface GigabitEthernet0/0.10
 ip helper-address 172.16.52.11
 exit

! Configuration du relais pour le VLAN 20 (Autres / Direction)
interface GigabitEthernet0/0.20
 ip helper-address 172.16.52.11
 exit

! Configuration du relais pour le VLAN 30 (Production)
interface GigabitEthernet0/0.30
 ip helper-address 172.16.52.11
 exit

! Configuration du relais pour le VLAN 40 (Logistique)
interface GigabitEthernet0/0.40
 ip helper-address 172.16.52.11
 exit

! Configuration du relais pour le VLAN 50 (Ventes & Études)
interface GigabitEthernet0/0.50
 ip helper-address 172.16.52.11
 exit

! Enregistrement de la configuration en NVRAM
end
write memory
```



<div class="calc-box"> <strong>Explication technique :</strong>

La commande <code>ip helper-address</code> intercepte les broadcasts UDP sur les ports 67 et 68 (DHCP) et les encapsule dans un paquet Unicast à destination du serveur ciblé. </div>

## 4. VALIDATION ET TESTS

1. Se connecter sur un poste de travail du réseau client (ex: PC de la Logistique).
    
2. Basculer la configuration de la carte réseau d'IP Statique à **DHCP**.
    
3. Vérifier que le statut passe en `DHCP request successful`.
    
4. Contrôler les informations reçues avec la commande `ipconfig` en invite de commandes :
    
    - L'adresse IP doit appartenir au sous-réseau configuré.
        
    - La passerelle par défaut doit correspondre à la sous-interface du routeur.
        
    - Le serveur DNS doit indiquer `172.16.52.1`.