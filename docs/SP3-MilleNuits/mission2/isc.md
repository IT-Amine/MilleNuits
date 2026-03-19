# DOCUMENTATION : DÉPLOIEMENT DU SERVEUR DHCP (MN11) SOUS DEBIAN 13

## 1. PRÉREQUIS

Avant de commencer l'installation, le serveur Linux (MN11) doit posséder une configuration réseau statique.

* **OS :** Debian 13 (Trixie)

* **Adresse IP du serveur :** `172.16.52.11`

* **Masque :** `255.255.255.0` (/24)

* **Passerelle :** `172.16.52.253` (Interface du VLAN Serveurs sur le routeur)

* Les commandes doivent être exécutées en tant que `root` (ou précédées de `sudo`).

## 2. INSTALLATION DU SERVICE

Mettre à jour la liste des paquets et installer le service DHCP officiel (`isc-dhcp-server`) :

```bash
apt update
apt install isc-dhcp-server -y
```

<div class="calc-box"> ⚠️ <strong>Note de déploiement :</strong>
Il est tout à fait normal que le service affiche une erreur (FAILED) juste après l'installation. Le service tente de démarrer alors qu'il n'est pas encore configuré. Cela sera résolu à l'étape 4. </div>

## 3. DÉCLARATION DE L'INTERFACE D'ÉCOUTE

Il faut indiquer au service sur quelle carte réseau il doit écouter les requêtes (provenant du relais IP Helper du routeur). Éditer le fichier de configuration par défaut :


```Bash
nano /etc/default/isc-dhcp-server
```

Trouver la ligne `INTERFACESv4=""` (tout en bas du fichier) et ajouter le nom de la carte réseau (ex: `ens33`, `eth0` ou `enp0s3`selon l'hyperviseur) :


```Bash
INTERFACESv4="ens33"
```

_Sauvegarder et quitter (Ctrl+O, Entrée, Ctrl+X)._

## 4. CONFIGURATION DES ÉTENDUES (POOLS)

C'est ici que l'on définit les règles de distribution pour les différents VLANs de l'entreprise. Éditer le fichier de configuration principal :

```Bash
nano /etc/dhcp/dhcpd.conf
```

Vider ou commenter l'ancien contenu, puis coller la configuration suivante adaptée à l'infrastructure Mille Nuits :


```Bash
# Options globales
default-lease-time 600;
max-lease-time 7200;
authoritative;

# OBLIGATOIRE : Déclaration du sous-réseau du serveur lui-même (VLAN 52)
# On ne met pas de "range" car on ne distribue pas d'IP aux serveurs
subnet 172.16.52.0 netmask 255.255.255.0 {
}

# POOL 1 : VLAN 10 (Administratif)
subnet 172.40.1.128 netmask 255.255.255.128 {
    range 172.40.1.130 172.40.1.250;
    option routers 172.40.1.254;
    option domain-name-servers 172.16.52.1;
}

# POOL 2 : VLAN 20 (Autres / Direction)
subnet 172.40.1.0 netmask 255.255.255.128 {
    range 172.40.1.10 172.40.1.120;
    option routers 172.40.1.126;
    option domain-name-servers 172.16.52.1;
}

# POOL 3 : VLAN 30 (Production)
subnet 172.40.0.0 netmask 255.255.255.0 {
    range 172.40.0.10 172.40.0.250;
    option routers 172.40.0.254;
    option domain-name-servers 172.16.52.1;
}

# POOL 4 : VLAN 40 (Logistique)
subnet 172.40.2.64 netmask 255.255.255.192 {
    range 172.40.2.70 172.40.2.120;
    option routers 172.40.2.126;
    option domain-name-servers 172.16.52.1;
}

# POOL 5 : VLAN 50 (Ventes & Études)
subnet 172.40.2.0 netmask 255.255.255.192 {
    range 172.40.2.10 172.40.2.50;
    option routers 172.40.2.62;
    option domain-name-servers 172.16.52.1;
}
```

_Sauvegarder et quitter (Ctrl+O, Entrée, Ctrl+X)._

## 5. DÉMARRAGE ET VÉRIFICATION

Redémarrer le service pour appliquer les modifications, puis vérifier son statut :


```Bash
systemctl restart isc-dhcp-server
systemctl status isc-dhcp-server
```

Le service doit afficher un point vert et la mention **`active (running)`**.

Pour s'assurer que le service se lance automatiquement à chaque redémarrage de la machine :


```Bash
systemctl enable isc-dhcp-server
```

## 6. LECTURE DES BAUX (LOGS)

Pour vérifier en temps réel si le serveur attribue bien des adresses IP lorsqu'un client (Windows 10/11) en fait la demande, il suffit de lire le fichier des baux DHCP :


```Bash
cat /var/lib/dhcp/dhcpd.leases
```

Chaque nouvelle adresse distribuée apparaîtra dans ce fichier avec l'adresse MAC du client associé.