# =====================================================================
# Assistant de Configuration des Exclusions Antivirus - Digit'Pilot
# Compatible Windows 10 & 11 (Windows Defender, Avast, AVG, Bitdefender...)
# =====================================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$Host.UI.RawUI.WindowTitle = "Configuration des Exclusions Antivirus - Digit'Pilot"

Clear-Host
Write-Host "====================================================================" -ForegroundColor Cyan
Write-Host "       ASSISTANT DE CONFIGURATION DES EXCLUSIONS ANTIVIRUS          " -ForegroundColor Cyan
Write-Host "                         Digit'Pilot                                " -ForegroundColor Cyan
Write-Host "====================================================================" -ForegroundColor Cyan
Write-Host ""

$targetDir = $PSScriptRoot
if ([string]::IsNullOrWhiteSpace($targetDir)) {
    $targetDir = (Get-Location).Path
}

# Si le script est execute depuis un sous-dossier (ex: Utilitaires), cibler le dossier racine parent
if (-not (Test-Path (Join-Path $targetDir "DigitPilot.exe"))) {
    $parentDir = Split-Path $targetDir -Parent
    if (Test-Path (Join-Path $parentDir "DigitPilot.exe")) {
        $targetDir = $parentDir
    }
}

# Copie automatique du chemin dans le presse-papier
try {
    Set-Clipboard -Value $targetDir
    $clipboardCopied = $true
} catch {
    $clipboardCopied = $false
}

Write-Host "Dossier cible du logiciel :" -ForegroundColor White
Write-Host "  >> $targetDir" -ForegroundColor Yellow
if ($clipboardCopied) {
    Write-Host "  [OK] Le chemin a ete copie dans votre presse-papier (Ctrl+V disponible) !" -ForegroundColor Green
}
Write-Host ""

# ---------------------------------------------------------------------
# 1. Détection des antivirus installés
# ---------------------------------------------------------------------
Write-Host "--- [1/3] Analyse des solutions de securite installees ---" -ForegroundColor White

$avList = @()
try {
    $rawProducts = Get-CimInstance -Namespace "root/SecurityCenter2" -ClassName "AntiVirusProduct" -ErrorAction SilentlyContinue
    foreach ($p in $rawProducts) {
        $state = [int]$p.productState
        # Bitwise check: bit 4 du 2ème octet indique si la protection temps réel est active
        $isActive = (($state -shr 8) -band 0x10) -ne 0
        $avList += [PSCustomObject]@{
            Name     = $p.displayName
            IsActive = $isActive
            State    = $state
        }
    }
} catch {
    Write-Host "  (Impossible d'interroger SecurityCenter2 : $($_.Exception.Message))" -ForegroundColor Gray
}

if ($avList.Count -gt 0) {
    foreach ($av in $avList) {
        $statusStr = if ($av.IsActive) { "[ACTIF]" } else { "[INACTIF / PASSIF]" }
        $color = if ($av.IsActive) { "Green" } else { "DarkGray" }
        Write-Host "  * $($av.Name) : $statusStr" -ForegroundColor $color
    }
} else {
    Write-Host "  * Windows Defender (par defaut)" -ForegroundColor Gray
}
Write-Host ""

# ---------------------------------------------------------------------
# 2. Configuration de Windows Defender
# ---------------------------------------------------------------------
Write-Host "--- [2/3] Configuration des exclusions Windows Defender ---" -ForegroundColor White

$defenderSuccess = $false
$tamperProtected = $false
$runningMode = "Inconnu"

try {
    $status = Get-MpComputerStatus -ErrorAction SilentlyContinue
    if ($status) {
        $tamperProtected = [bool]$status.IsTamperProtected
        $runningMode = $status.AMRunningMode
    }
} catch {}

Write-Host "  Mode Windows Defender    : $runningMode" -ForegroundColor Gray
Write-Host "  Protection falsifications : $(if ($tamperProtected) { 'ACTIVEE (Tamper Protection)' } else { 'Desactivee' })" -ForegroundColor Gray

# Tentative d'ajout direct via PowerShell
$processesToExclude = @("DigitPilot.exe", "apli info pc.exe", "Lancer.bat", "Lancer_DigitPilot.bat")
$addError = $null

try {
    Add-MpPreference -ExclusionPath $targetDir -ErrorAction Stop
    foreach ($procName in $processesToExclude) {
        Add-MpPreference -ExclusionProcess $procName -ErrorAction SilentlyContinue
    }
    $defenderSuccess = $true
} catch {
    $addError = $_.Exception.Message
}

if ($defenderSuccess) {
    Write-Host ""
    Write-Host "  [SUCCES] Le dossier et les executables ont ete ajoutes aux exclusions de Windows Defender !" -ForegroundColor Green
} else {
    Write-Host ""
    Write-Host "  [AVERTISSEMENT] L'ajout automatique via script a ete refuse par Windows Defender." -ForegroundColor Yellow
    if ($tamperProtected) {
        Write-Host "  Cause : La 'Protection contre les falsifications' (Tamper Protection) de Windows Defender est active." -ForegroundColor Yellow
        Write-Host "          Par securite, Windows bloque toute modification automatique des exclusions par des scripts." -ForegroundColor Yellow
    } else {
        Write-Host "  Cause : $addError" -ForegroundColor Yellow
    }
    Write-Host ""
    Write-Host "  Pour l'ajouter manuellement dans Windows Defender en 3 clics :" -ForegroundColor Cyan
    Write-Host "    1. Ouvrez 'Securite Windows' -> 'Protection contre les virus et menaces'" -ForegroundColor White
    Write-Host "    2. Sous 'Parametres de protection...', cliquez sur 'Gerer les parametres'" -ForegroundColor White
    Write-Host "    3. Descendez a 'Exclusions' -> 'Ajouter ou supprimer des exclusions'" -ForegroundColor White
    Write-Host "    4. Cliquez sur 'Ajouter une exclusion' -> 'Dossier' et collez (Ctrl+V) :" -ForegroundColor White
    Write-Host "       $targetDir" -ForegroundColor Green
    Write-Host ""
    $openDef = Read-Host "  Souhaitez-vous ouvrir directement la Securite Windows maintenant ? [O/N] (Defaut: O)"
    if ($openDef -eq "" -or $openDef -match "^[oOyY]") {
        try {
            Start-Process "ms-settings:windowsdefender"
        } catch {
            Start-Process "windowsdefender://"
        }
    }
}
Write-Host ""

# ---------------------------------------------------------------------
# 3. Traitement des antivirus tiers (ex: Avast, AVG, Bitdefender...)
# ---------------------------------------------------------------------
$activeThirdParty = @($avList | Where-Object { $_.Name -notlike "*Defender*" -and $_.IsActive })

if ($activeThirdParty.Count -gt 0) {
    Write-Host "--- [3/3] ANTIVIRUS TIERS ACTIF DETECTE ---" -ForegroundColor Yellow
    foreach ($av in $activeThirdParty) {
        Write-Host ""
        Write-Host "  [IMPORTANT] Votre PC est protege par : $($av.Name)" -ForegroundColor Cyan
        Write-Host "  Windows Defender est en mode passif. C'est $($av.Name) qui analyse vos fichiers !" -ForegroundColor Yellow
        Write-Host ""
        if ($av.Name -like "*Avast*") {
            Write-Host "  Marche a suivre pour ajouter une exception dans AVAST :" -ForegroundColor White
            Write-Host "    1. Ouvrez l'application Avast Antivirus." -ForegroundColor Gray
            Write-Host "    2. Cliquez sur 'Menu' (en haut a droite) -> 'Parametres'." -ForegroundColor Gray
            Write-Host "    3. Allez dans l'onglet 'General' -> 'Exceptions'." -ForegroundColor Gray
            Write-Host "    4. Cliquez sur 'Ajouter une exception'." -ForegroundColor Gray
            Write-Host "    5. Collez le chemin du dossier (deja copie dans votre presse-papier) :" -ForegroundColor Gray
            Write-Host "       $targetDir" -ForegroundColor Green
            Write-Host "    6. Cliquez sur 'Ajouter une exception' pour valider." -ForegroundColor Gray
        } elseif ($av.Name -like "*AVG*") {
            Write-Host "  Marche a suivre pour ajouter une exception dans AVG :" -ForegroundColor White
            Write-Host "    1. Ouvrez l'application AVG Antivirus." -ForegroundColor Gray
            Write-Host "    2. Cliquez sur 'Menu' -> 'Parametres' -> 'General' -> 'Exceptions'." -ForegroundColor Gray
            Write-Host "    3. Collez : $targetDir" -ForegroundColor Green
        } else {
            Write-Host "  Marche a suivre dans $($av.Name) :" -ForegroundColor White
            Write-Host "    1. Ouvrez les Parametres de $($av.Name)." -ForegroundColor Gray
            Write-Host "    2. Cherchez la rubrique 'Exceptions' ou 'Exclusions'." -ForegroundColor Gray
            Write-Host "    3. Ajoutez le chemin : $targetDir" -ForegroundColor Green
        }
    }
} else {
    Write-Host "--- [3/3] Aucun antivirus tiers actif detecte ---" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "====================================================================" -ForegroundColor Cyan
Write-Host "Configuration terminee." -ForegroundColor Cyan
Write-Host "====================================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Appuyez sur Entree pour fermer cette fenetre..." -ForegroundColor DarkGray
$null = Read-Host
