<p align="center">
  <img src="assets/logo.png" alt="DigitPilot Logo" width="140" height="140" />
</p>

<h1 align="center">Digit'Pilot</h1>

<p align="center">
  <strong>La suite d'ingénierie système, d'optimisation et de dépannage 1-clic pour Windows.</strong><br>
  <em>100% Hors-Ligne • Zéro Télémétrie • Protection Noyau Failsafe</em>
</p>

<p align="center">
  <a href="https://github.com/Digit-Info/DigitPilot/releases/latest"><img src="https://img.shields.io/badge/Version-0.1.3--build2-00F0FF?style=for-the-badge&logo=windows11&logoColor=white" alt="Version 0.1.3"></a>
  <a href="https://github.com/Digit-Info/DigitPilot/releases/latest"><img src="https://img.shields.io/badge/Plateforme-Windows_10_%7C_11_(x64)-7C3AED?style=for-the-badge&logo=windows&logoColor=white" alt="Plateforme"></a>
  <img src="https://img.shields.io/badge/Runtime-.NET_8.0_WPF-00FF94?style=for-the-badge&logo=dotnet&logoColor=black" alt=".NET 8 WPF">
  <img src="https://img.shields.io/badge/Confidentialité-100%25_Offline-blue?style=for-the-badge&logo=shield&logoColor=white" alt="100% Hors Ligne">
  <img src="https://img.shields.io/badge/Licence-Commerciale-yellow?style=for-the-badge" alt="Licence">
</p>

<p align="center">
  <a href="#-téléchargement--installation">⚡ Télécharger</a> •
  <a href="#-fonctionnalités-phares">✨ Fonctionnalités</a> •
  <a href="#-architecture--spécifications-techniques">🏗️ Spécifications</a> •
  <a href="#-sécurité--intégrité-système">🛡️ Sécurité</a> •
  <a href="#-faq">❓ FAQ</a>
</p>

---

## 💡 Qu'est-ce que Digit'Pilot ?

**Digit'Pilot** est une station de contrôle et de maintenance avancée pour Windows 10 et 11. Conçu pour pallier les risques des optimiseurs traditionnels (qui détruisent souvent la base de registre ou des composants système critiques), Digit'Pilot repose sur une **politique stricte « Zéro-Casse »** et une infrastructure **100% locale sans aucun appel réseau**.

Que ce soit pour libérer de l'espace disque, débloquer Windows Update en 1 clic, inspecter l'usure réelle d'une batterie d'ordinateur portable, ou diagnostiquer les plantages de jeux compétitifs (*VALORANT / Riot Vanguard*), Digit'Pilot apporte la précision d'un technicien informatique dans une interface moderne et accessible.

> [!TIP]
> **Zéro Dépendance Distante :** Aucune donnée, aucun fichier, aucune télémétrie n'est transmise sur Internet. Le logiciel fonctionne intégralement hors-ligne avec chiffrement matériel Windows DPAPI.

---

## 🎛️ Fonctionnalités Phares

```
               ┌─────────────────────────────────────────────────────────────┐
               │                 DIGIT'PILOT — Modules Clés                  │
               └──────────────────────────────┬──────────────────────────────┘
                                              │
    ┌──────────────────┬──────────────────────┼──────────────────────┬──────────────────┐
    ▼                  ▼                      ▼                      ▼                  ▼
[TABLEAU DE BORD] [BATTERIE EXPERT]    [NETTOYAGE PRO]        [RESCUE KIT 1-CLIC]   [TRADUCTEUR ERREURS]
• Santé en direct  • ACPI & Cycles    • 0 Risque Système     • Réseau & DNS        • Crash BSOD en clair
• CPU / RAM / SSD  • Tension réelle   • Doublons SHA-256     • Windows Update      • Diagnostic Vanguard
```

### 1. ⚡ Tableau de Bord & Santé en Temps Réel
* **Score de Vitalité Global :** Analyse synthétique instantanée de l'état opérationnel du système.
* **Télémétrie Haute Fréquence :** Monitoring CPU (charge globale et caches L1/L2/L3), RAM physique/virtuelle, et disques NVMe/SATA avec inspection de l'intégrité **S.M.A.R.T.**

### 2. 🧹 Nettoyage Garanti « Zéro-Casse » & Doublons SHA-256
* **Garde-Fou Noyau :** Liste blanche stricte interdisant formellement l'accès aux bibliothèques système critiques, pilotes et points de restauration.
* **Détecteur de Doublons à 3 Niveaux :**
  1. Filtre rapide par taille exacte en octets.
  2. Échantillonnage d'en-tête (pre-hash).
  3. Signature cryptographique complète **SHA-256** garantissant l'identification des doublons sans faux-positifs.

### 3. 🔋 Bilan Expert de la Batterie (Laptops)
* **Détection du Taux d'Usure Réel :** Comparaison entre la capacité d'usine (*Design Capacity*) et la charge maximale effective (*Full Charge Capacity*).
* **Compteur de Cycles & Analyse ACPI :** Surveillance de la santé des cellules lithium et outil de réinitialisation/recalibrage du pilote d'alimentation Windows en cas de coupure inopinée.

### 4. 🧰 Rescue Kit : Dépannage Express en 1 Clic
Résolution automatique des pannes Windows les plus fréquentes :
* 🔄 **Windows Update :** Réinitialisation des services WUAUSERV, BITS, CryptSvc et purge du cache de téléchargement corrompu `SoftwareDistribution`.
* 🌐 **Pile Réseau & DNS :** Vidage du cache DNS, réinitialisation du catalogue Winsock et renouvellement de bail DHCP.
* 🖨️ **Spouleur d'Impression :** Vidage d'urgence de la file d'attente bloquée et relance du service.
* 🖼️ **Cache d'Icônes :** Reconstruction de la base `IconCache.db` pour éliminer les icônes blanches ou corrompues.
* ⏰ **Synchronisation Temporelle :** Resynchronisation forcée de l'horloge avec les serveurs NTP Windows (résout les erreurs de certificats HTTPS).

### 5. 🔍 Traducteur d'Erreurs Windows & Crashs BSOD
* Interrogation ciblée des journaux d'événements Windows (*System* et *Application*).
* Traduction des codes hexadécimaux obscurs (ex: `0x80070002`, `0xC0000005`, `PAGE_FAULT_IN_NONPAGED_AREA`) en **diagnostic vulgarisé en français clair** avec plan d'action correctif.

### 6. 🎮 Diagnostic Anti-Triche Compétitif (Riot Vanguard / VALORANT)
* Audit de conformité matérielle pour les moteurs anti-triche modernes :
  * Détection du pilote noyau `vgk.sys`.
  * Vérification de l'activation du **Secure Boot** UEFI.
  * Validation du module de plateforme sécurisée **TPM 2.0**.

---

## 🏗️ Architecture & Spécifications Techniques

| Caractéristique | Détail Technique |
| :--- | :--- |
| **Langage & Framework** | C# 12.0 sur **Microsoft .NET 8.0** (`net8.0-windows`) |
| **Interface Graphique** | Windows Presentation Foundation (WPF) avec accélération matérielle DirectX |
| **Thème & Design** | Cyber-Glass Obsidian (`#0A0713`), néons Cyan/Violet/Émeraude, typographie Segoe Fluent |
| **Conditionnement** | Binaire autonome scellé (`PublishSingleFile=true`) |
| **Sécurité & Protection** | Obfuscation IL avancée (Obfuscar 2.2.50) & Chiffrement matériel **Windows DPAPI** |
| **Signature Numérique** | Authenticode SHA-256 (`CN=Digit'Pilot Technologies`) |
| **Compatibilité** | Windows 10 (20H2+) et Windows 11 (21H2+) — Architecture 64-bit exclusive |

---

## 📥 Téléchargement & Installation

### Option 1 : Téléchargement Direct (Recommandé)
1. Rendez-vous sur la page des [Releases Officielles](https://github.com/Digit-Info/DigitPilot/releases/latest).
2. Téléchargez l'archive `DigitPilot_0.1.3_Installateur.zip`.
3. Extrayez l'archive et exécutez `Setup_DigitPilot.exe` (ou `Installer_DigitPilot.bat`).

```powershell
# Exemple de décompression rapide via PowerShell
Expand-Archive -Path "DigitPilot_0.1.3_Installateur.zip" -DestinationPath "$env:USERPROFILE\Downloads\DigitPilot"
```

> [!IMPORTANT]
> **Privilèges Administrateur :** Digit'Pilot interagit avec les interfaces de bas niveau Windows (WMI, ACPI, services système). Le lancement avec élévation de privilèges (UAC) est requis pour l'accès aux fonctions de dépannage et de diagnostic matériel.

---

## 🛡️ Sécurité & Intégrité Système

* **Aucun Risque Registre :** Digit'Pilot ne procède à aucun « nettoyage aveugle » de la base de registre, garantissant la stabilité à long terme de votre installation Windows.
* **Traçabilité Totale :** Chaque intervention effectuée via le Rescue Kit est enregistrée localement dans `%LocalAppData%\DigitPilot\DigitPilot_ActionHistory.json`.
* **Restauration & Failsafe :** Les opérations de maintenance intègrent des points de contrôle d'échec pour rétablir les services dans leur état initial en cas d'interruption.

---

## ❓ FAQ

<details>
<summary><strong>Digit'Pilot ralentit-il le PC en arrière-plan ?</strong></summary>
<br>
Non. Digit'Pilot est conçu comme un outil à la demande. Il ne déploie aucun service persistant en arrière-plan et consomme zéro ressource processeur lorsqu'il est fermé.
</details>

<details>
<summary><strong>Mes données personnelles sont-elles transmises à des serveurs tiers ?</strong></summary>
<br>
Non. L'application est 100% hors-ligne. Aucune connexion distante, aucun serveur d'analyse ni aucune régie publicitaire ne sont sollicités.
</details>

<details>
<summary><strong>Quelle est la différence avec les nettoyeurs classiques ?</strong></summary>
<br>
Les nettoyeurs génériques suppriment souvent des fichiers indispensables ou endommagent les associations de fichiers. Digit'Pilot intègre un algorithme de protection inviolable et se concentre sur la santé matérielle, la résolution des pannes réelles et l'intégrité de Windows.
</details>

---

<p align="center">
  <sub>Développé avec précision par <strong>Digit'Pilot Technologies</strong> • 2026</sub>
</p>
