# Installation de GLPI (Service Desk)

**Serveur :** MN09
**OS :** Debian 12
**Rôle :** Gestionnaire de Parc et Incidents

---

## 1. Prérequis et Pile LAMP

GLPI nécessite un serveur Web, une base de données et PHP. Nous installons la version **PHP 8.2** pour garantir la compatibilité avec GLPI 10.

### A. Installation des paquets
```
# Mise à jour du système
sudo apt update && sudo apt upgrade -y

# Installation Apache, MariaDB et extensions PHP requises
sudo apt install apache2 mariadb-server php8.2 php8.2-fpm php8.2-mysql \
php8.2-curl php8.2-gd php8.2-intl php8.2-mbstring php8.2-xml \
php8.2-zip php8.2-bz2 php8.2-ldap -y
```

### B. Configuration PHP & Apache

Activation des modules nécessaires et redémarrage des services :

```
sudo a2enconf php8.2-fpm
sudo a2enmod proxy_fcgi setenvif rewrite
sudo systemctl restart apache2
```

---

## 2. Base de Données (MariaDB)

Nous créons une base dédiée à l'environnement **Mille Nuits**.

> note "🔐 Identifiants Database" 
>  **Base :** `db_millenuits_glpi` 
>  **Utilisateur :** `admin_millenuits` 
> **Mot de passe :**`M1lleNuits_Secret!2026`

**Procédure SQL :**

SQL

```
-- Connexion en root
sudo mysql -u root

-- Création de la base (UTF8MB4 pour supporter les émojis dans les tickets)
CREATE DATABASE db_millenuits_glpi CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Création de l'utilisateur
CREATE USER 'admin_millenuits'@'localhost' IDENTIFIED BY 'M1lleNuits_Secret!2026';

-- Attribution des droits
GRANT ALL PRIVILEGES ON db_millenuits_glpi.* TO 'admin_millenuits'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

---

## 3. Installation des fichiers GLPI

Nous installons la version stable **10.0.12** dans le dossier web.

```
cd /tmp
# Téléchargement
wget [https://github.com/glpi-project/glpi/releases/download/10.0.12/glpi-10.0.12.tgz](https://github.com/glpi-project/glpi/releases/download/10.0.12/glpi-10.0.12.tgz)

# Extraction et déplacement
tar -xzvf glpi-10.0.12.tgz
sudo mv glpi /var/www/html/

# Attribution des permissions (CRITIQUE pour le fonctionnement)
sudo chown -R www-data:www-data /var/www/html/glpi/
sudo chmod -R 755 /var/www/html/glpi/
```

---

## 4. Configuration Apache (VirtualHost)

Fichier : `/etc/apache2/sites-available/glpi.conf`

Apache

```
<VirtualHost *:80>
    ServerName glpi.millenuits.lan
    DocumentRoot /var/www/html/glpi

    <Directory /var/www/html/glpi>
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog ${APACHE_LOG_DIR}/error-glpi.log
    CustomLog ${APACHE_LOG_DIR}/access-glpi.log combined
</VirtualHost>
```

**Activation du site :**

```
sudo a2ensite glpi.conf
sudo a2dissite 000-default.conf
sudo systemctl reload apache2
```

---

## 5. Finalisation Web

1. Ouvrir le navigateur sur le poste Administrateur.
    
2. Accéder à l'URL : `http://172.16.52.20` (IP du serveur GLPI-MN09).
    
3. Suivre l'assistant d'installation.
    

**Paramètres de connexion BDD :**

|Champ|Valeur|
|---|---|
|**Serveur SQL**|`localhost`|
|**Utilisateur**|`admin_millenuits`|
|**Mot de passe**|`M1lleNuits_Secret!2026`|


!!! warning "⚠️ Sécurité Post-Installation" 
Une fois l'installation terminée, il est impératif de supprimer le fichier d'installation pour empêcher une réinitialisation malveillante : 
`sudo rm /var/www/html/glpi/install/install.php` 