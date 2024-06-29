param (
    [string]$mod_version,
    [string]$spt_version
)

# Define the release directory
$releaseDir = ".\release"

# Create release directory if it doesn't exist
if (-Not (Test-Path -Path $releaseDir)) {
    New-Item -ItemType Directory -Path $releaseDir -Force
}

# Create directory names within the release directory
$baseDir = "$releaseDir\yamwp-realism-compatibility_v${mod_version}_SPT-v${spt_version}"

# Define the inner directory structure
$innerDir = "user\mods\SPT-Realism\db\put_new_stuff_here\Guns_YetAnotherPort_Miralyn"

# Create the directories
New-Item -ItemType Directory -Path "$baseDir\$innerDir" -Force

# Define the list of files to move
$filesToMove = @(
    'Guns_YetAnotherPort_Miralyn\AKX.json',
    'Guns_YetAnotherPort_Miralyn\AWM.json',
    'Guns_YetAnotherPort_Miralyn\HK416.json',
    'Guns_YetAnotherPort_Miralyn\M16AX.json',
    'Guns_YetAnotherPort_Miralyn\MP5K.json',
    'Guns_YetAnotherPort_Miralyn\SVD.json'
)

# Move files to both directories
foreach ($file in $filesToMove) {
    Copy-Item -Path $file -Destination "$baseDir\$innerDir"
}

# Create zip files
Compress-Archive -Path "$baseDir\*" -DestinationPath "$releaseDir\yamwp-realism-compatibility_v${mod_version}_SPT-v${spt_version}.zip" -Force

# Clean up the created directories
Remove-Item -Recurse -Force "$baseDir"
