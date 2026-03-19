# DOCUMENTATION : DÉPLOIEMENT DU SERVEUR KEA DHCP (MN11)

L'utilisation du service moderne Kea DHCP a été privilégiée en remplacement de l'historique ISC DHCP Server, ce dernier étant obsolète (End of Life). La configuration s'opère désormais via un format JSON structuré.

## 1. PRÉREQUIS

* **OS :** Debian 13 (Trixie)
* **Adresse IP statique du serveur :** `172.16.52.11` (/24)
* **Passerelle :** `172.16.52.253`
* Privilèges d'administration (`root` ou `sudo`).

## 2. INSTALLATION DU SERVICE KEA

Mettre à jour la liste des paquets et installer le module IPv4 de Kea :

```bash
apt update
apt install kea-dhcp4-server -y
```

## 3. CONFIGURATION (FORMAT JSON)

Le fichier de configuration principal de Kea se trouve dans `/etc/kea/kea-dhcp4.conf`.

<div class="calc-box"> ⚠️ <strong>Syntaxe JSON stricte :</strong>

Contrairement à l'ancien système, le format JSON ne tolère aucune erreur de syntaxe. Une virgule manquante ou en trop empêchera le service de démarrer. </div>

Sauvegarder la configuration d'origine et éditer un nouveau fichier propre :


```Bash
mv /etc/kea/kea-dhcp4.conf /etc/kea/kea-dhcp4.conf.backup
nano /etc/kea/kea-dhcp4.conf
```

Copier-coller la configuration suivante (remplacer `ens33` par le nom exact de votre carte réseau, ex: `eth0`) :


```JSON
{
  "Dhcp4": {
    "interfaces-config": {
      "interfaces": ["ens33"]
    },
    "lease-database": {
      "type": "memfile",
      "persist": true,
      "name": "/var/lib/kea/kea-leases4.csv"
    },
    "valid-lifetime": 7200,
    "option-data": [
      {
        "name": "domain-name-servers",
        "data": "172.16.52.1"
      }
    ],
    "subnet4": [
      {
        "id": 1,
        "subnet": "172.16.52.0/24",
        "comment": "Reseau des Serveurs (VLAN 52) - Aucune distribution"
      },
      {
        "id": 10,
        "subnet": "172.40.1.128/25",
        "pools": [ { "pool": "172.40.1.130 - 172.40.1.250" } ],
        "option-data": [ { "name": "routers", "data": "172.40.1.254" } ]
      },
      {
        "id": 20,
        "subnet": "172.40.1.0/25",
        "pools": [ { "pool": "172.40.1.10 - 172.40.1.120" } ],
        "option-data": [ { "name": "routers", "data": "172.40.1.126" } ]
      },
      {
        "id": 30,
        "subnet": "172.40.0.0/24",
        "pools": [ { "pool": "172.40.0.10 - 172.40.0.250" } ],
        "option-data": [ { "name": "routers", "data": "172.40.0.254" } ]
      },
      {
        "id": 40,
        "subnet": "172.40.2.64/26",
        "pools": [ { "pool": "172.40.2.70 - 172.40.2.120" } ],
        "option-data": [ { "name": "routers", "data": "172.40.2.126" } ]
      },
      {
        "id": 50,
        "subnet": "172.40.2.0/26",
        "pools": [ { "pool": "172.40.2.10 - 172.40.2.50" } ],
        "option-data": [ { "name": "routers", "data": "172.40.2.62" } ]
      }
    ]
  }
}
```

_Sauvegarder et quitter (Ctrl+O, Entrée, Ctrl+X)._

## 4. DÉMARRAGE ET VÉRIFICATION

Lancer le service Kea DHCP et vérifier son état de fonctionnement :


```bash
systemctl restart kea-dhcp4-server
systemctl status kea-dhcp4-server
```

Le service doit indiquer **`active (running)`**.

Pour s'assurer du démarrage automatique lors du boot du serveur :


```bash
systemctl enable kea-dhcp4-server
```

## 5. LECTURE DES BAUX ACTIFS (LOGS)

Avec Kea, les adresses IP distribuées (baux) sont enregistrées dans un fichier CSV (défini plus haut dans le bloc `lease-database`). Pour consulter les IP attribuées en temps réel :


```bash
cat /var/lib/kea/kea-leases4.csv
```

## 6.MISE EN PLACE SUR LE ROUTEUR L'AIDE DHCP

Les commandes suivantes permettent d'indiquer au routeur de transférer les requêtes DHCP entrantes sur les sous-interfaces clientes directement vers l'adresse IP (Unicast) du serveur MN11.

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