#!/bin/bash
cd docs

mkdir -p sp2-parc/documentation
mkdir -p sp2-parc/clients
mkdir -p sp2-parc/deploiement
mkdir -p sp2-parc/support

mkdir -p sp3-services/ad-dns
mkdir -p sp3-services/dhcp
mkdir -p sp3-services/stockage

mv SP2-MilleNuits/mission1/comparatif.md sp2-parc/documentation/comparatif-editeurs.md
mv SP2-MilleNuits/mission1/installMk.md sp2-parc/documentation/installation-zensical.md
mv SP2-MilleNuits/mission2/master.md sp2-parc/clients/masterisation-windows.md
mv SP2-MilleNuits/mission2/sysprep.md sp2-parc/clients/explication-sysprep.md
mv SP2-MilleNuits/mission3/comparatif.md sp2-parc/deploiement/comparatif-solutions.md
mv SP2-MilleNuits/mission3/fonctionnement_fog.md sp2-parc/deploiement/fonctionnement-fog.md
mv SP2-MilleNuits/mission3/fog.md sp2-parc/deploiement/installation-serveur-fog.md
mv SP2-MilleNuits/mission4/glpi.md sp2-parc/support/presentation-outil-glpi.md
mv SP2-MilleNuits/mission4/procedures.md sp2-parc/support/procedures-incidents.md
mv SP2-MilleNuits/mission4/users.md sp2-parc/support/gestion-utilisateurs-glpi.md

mv SP3-MilleNuits/mission1/winserv.md sp3-services/ad-dns/configuration-windows-server-2019.md
mv SP3-MilleNuits/mission1/annuaire.md sp3-services/ad-dns/mise-en-place-annuaire.md
mv SP3-MilleNuits/mission2/dhcp.md sp3-services/dhcp/theorie-dhcp.md
mv SP3-MilleNuits/mission2/cisco.md sp3-services/dhcp/configuration-relais-cisco.md
mv SP3-MilleNuits/mission2/isc.md sp3-services/dhcp/installation-dhcp-isc.md
mv SP3-MilleNuits/mission2/kea.md sp3-services/dhcp/installation-dhcp-kea.md
mv SP3-MilleNuits/mission3/nas.md sp3-services/stockage/installation-nas-truenas.md

rm -rf SP2-MilleNuits
rm -rf SP3-MilleNuits
