# Table de routage - Millenuits GP2

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

| Commentaire   | Destination  | Masque          | Passerelle    | Interface     | Type |
| ------------- | ------------ | --------------- | ------------- | ------------- | ---- |
| Default       | 0.0.0.0      | 0.0.0.0         | 172.16.31.254 | 172.16.29.11  | S    |
| Production    | 172.40.0.0   | 255.255.255.0   | 172.40.0.254  | 172.40.0.254  | C    |
| Autres        | 172.40.1.0   | 255.255.255.128 | 172.40.1.126  | 172.40.1.127  | C    |
| Administratif | 172.40.1.128 | 255.255.255.128 | 172.40.1.254  | 172.40.1.254  | C    |
| VentesEtudes  | 172.40.2.0   | 255.255.255.192 | 172.40.2.62   | 172.40.2.63   | C    |
| Logistique    | 172.40.2.64  | 255.255.255.192 | 172.40.2.126  | 172.40.2.127  | C    |
| Invité        | 172.40.2.128 | 255.255.255.240 | 172.40.2.142  | 172.40.2.143  | C    |
| Management    | 172.40.2.144 | 255.255.255.240 | 172.40.2.158  | 172.40.2.158  | C    |
| Serveurs      | 172.16.52.0  | 255.255.255.0   | 172.16.52.252 | 172.16.52.252 | C    |
