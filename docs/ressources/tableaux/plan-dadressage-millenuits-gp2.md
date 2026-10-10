# Plan d'adressage - Millenuits GP2

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
| Serveurs      | 52          | 172.16.52.0        | 255.255.255.0<br>/24     | 172.16.52.252  | 172.16.52.255             |
| DMZ           | 53          | 10.10.10.0         | 255.255.255.0<br>/24     | 10.10.10.254   | 10.10.10.255              |
