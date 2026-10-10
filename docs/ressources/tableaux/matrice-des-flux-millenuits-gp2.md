# Matrice des flux - Millenuits GP2

<div style="margin-top: 20px; border: 1px solid #ccc; padding: 20px; border-radius: 10px; background-color: var(--md-default-bg-color);">
    <p><strong>Auteur :</strong> KADA Amine</p>
    <p><strong>Classe :</strong> BTS SIO 2 - Option SISR</p>
    <p><strong>Date :</strong> 10/10/2026</p>
    <p><strong>Version :</strong> 1.0</p>
</div>



<div style="display: flex; gap: 10px;">
  </div>

---

- **Mainteneur** : KADA Amine
- **Dernière édition** : 23/02/2026

---

|**Source**|**Destination**|**Protocole / Port**|**Action**|**Interface / Sens**|
|---|---|---|---|---|
|**VLAN 15 - Invité** (172.40.2.128/28)|Réseaux internes (172.16.0.0/12)|IP (Tout)|Deny|Routeur (Vlan15) - IN|
|**VLAN 15 - Invité** (172.40.2.128/28)|Internet (Any)|TCP/UDP 80, 443, 53|Permit|Routeur (Vlan15) - IN|
|**VLAN 10 - Production** (172.40.0.0/24)|Autres VLANs|IP (Tout)|Deny|Routeur (Vlan10) - IN|
|**Tous les VLANs internes**|Serveur MN01 (AD/DNS/DHCP)|UDP 53, 67, 68|Permit|Routeur (Vlans respectifs) - IN|
|**VLANs 12 & 13** (Admin / Ventes)|Serveur MN03 (PGI)|TCP (Ports PGI)|Permit|Routeur (Vlan12 & 13) - IN|
|**Tous les VLANs internes**|Serveur MN06 (Incidents) 172.16.52.6|TCP 80, 443|Permit|Routeur (Vlans respectifs) - IN|
|**Any**|**Any**|IP (Tout)|Deny|Règle implicite (Fin d'ACL)|
