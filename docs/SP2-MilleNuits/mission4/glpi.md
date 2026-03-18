<style>
:root {
    --couleur-lycee: #1e3a8a; /* Bleu */
    --couleur-titre: #d97706; /* Orange */
    --gris-clair: #f3f4f6;
}

h1 { color: var(--couleur-lycee); border-bottom: 2px solid var(--couleur-titre); padding-bottom: 10px; }
h2 { color: var(--couleur-lycee); margin-top: 30px; border-bottom: 1px solid #e5e7eb; padding-bottom: 5px; }
h3 { color: #333; border-left: 4px solid var(--couleur-titre); padding-left: 10px; margin-top: 25px; }

/* En-tête */
.header-container { 
    display: flex; align-items: center; justify-content: space-between; 
    margin-bottom: 40px; border-bottom: 1px solid #ddd; padding-bottom: 20px;
}
.logo img { 
    width: 250px; 
    height: auto; 
}
.info-box { text-align: right; color: #555; font-size: 1em; line-height: 1.4; }

/* Tableaux */
table { width: 100%; border-collapse: collapse; margin: 20px 0; border-radius: 5px; overflow: hidden; box-shadow: 0 0 10px rgba(0,0,0,0.05); }
th { background-color: var(--couleur-lycee); color: white; padding: 12px; text-transform: uppercase; font-size: 0.9em; }
td { border: 1px solid #e5e7eb; padding: 10px; text-align: center; }
td:first-child { text-align: left; font-weight: bold; color: var(--couleur-lycee); }
tr:nth-child(even) { background-color: #f9fafb; }

/* Boites */
.calc-box { 
    background-color: var(--gris-clair); 
    border-left: 4px solid var(--couleur-titre); 
    padding: 15px; 
    margin-bottom: 20px; 
    border-radius: 0 5px 5px 0;
}
.status-ok { color: #166534; font-weight: bold; background-color: #dcfce7; padding: 5px 10px; border-radius: 15px; }
</style>


# Installation de GLPI (Service Desk)

**Serveur :** MN06

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
> 
>  **Base :** `db_millenuits_glpi` 
>  
>  **Utilisateur :** `admin_millenuits` 
>  
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
    
2. Accéder à l'URL : `http://172.16.52.20` (IP du serveur GLPI-MN06).
    
3. Suivre l'assistant d'installation.
    

**Paramètres de connexion BDD :**

|Champ|Valeur|
|---|---|
|**Serveur SQL**|`localhost`|
|**Utilisateur**|`admin_millenuits`|
|**Mot de passe**|`M1lleNuits_Secret!2026`|

<div class="calc-box">
⚠️ <strong>Sécurité Post-Installation </strong><br>
Une fois l'installation terminée, il est impératif de supprimer le fichier d'installation pour empêcher une réinitialisation malveillante : 

`sudo rm /var/www/html/glpi/install/install.php`
</div>