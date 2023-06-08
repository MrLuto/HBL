$location = "West Europe"
$rgName = "AVD-BooneIT"
$region = "West Europe"

$galdef = "AVD_image_gallery"
$imdef = "W10-22H2"
$imver = "2023.02.06"

Connect-AzAccount

$imgver = Get-AzGalleryImageVersion -ResourceGroupName $rgName -GalleryName $galdef -GalleryImageDefinitionName $imdef -Name $imver
$galleryImageVersionID = $imgver.Id

$diskName = "TempImageDisk"
$imageOSDisk = @{Id = $galleryImageVersionID}
$OSDiskConfig = New-AzDiskConfig -Location $location -CreateOption "FromImage" -GalleryImageReference $imageOSDisk
$osd = New-AzDisk -ResourceGroupName $rgName -DiskName $diskName -Disk $OSDiskConfig

$sas = Grant-AzDiskAccess -ResourceGroupName $rgName -DiskName $osd.Name -Access "Read" -DurationInSecond 3600
$wc = New-Object System.Net.WebClient

#########################
#Let op: Disk is 128 GB!#
#########################

$wc.DownloadFile($sas.AccessSAS, "c:\targetdir\myImg.vhd")

######################################
#Vergeet niet de disk te verwijderen!#
######################################

Revoke-AzDiskAccess -ResourceGroupName $rgName -DiskName $diskName
Remove-AzDisk -ResourceGroupName $rgName -DiskName $diskName -Force