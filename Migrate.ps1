#Replace below folder location with your azcopy.exe folder location
cd C:\AzCopy

#log file
$env:AZCOPY_LOG_LOCATION="C:\AzCopy\logs"

#$SOURCE_LOC="https://dmpdatalakedev.blob.core.windows.net/dmpdatalake/raw/adage";
$SOURCE_SA=Read-Host "Enter Source Storage Account"
Write-Output "";
$SOURCE_Container=Read-Host "Enter Source Container"
Write-Output "";
$SOURCE_Layer=Read-Host "Enter Source Data layer"
Write-Output "";
$SOURCE_LOC=Read-Host "Enter Source Folder(s) path sepaarated by ','"
$SOURCE_Array =$SOURCE_LOC.Split(",")
Write-Output "";
$SOURCE_SAS="?sp=racwdlme&st=2022-02-03T17:58:42Z&se=2022-02-04T01:58:42Z&spr=https&sv=2020-08-04&sr=d&sig=ffF8aQHSaf6MkT1f8bsljDvuJmPA97nqDY5%2FqWzTaFY%3D&sdd=1"

#$TARGET_LOC ='https://dmpdatalakeadagedev.blob.core.windows.net/raw/';
$TARGET_SA=Read-Host "Enter Target Storage Account"
Write-Output "";
$TARGET_LOC=Read-Host "Enter Target Container"
Write-Output "";
$TARGET_SAS="?sp=rwle&st=2022-02-03T14:38:13Z&se=2022-02-03T22:38:13Z&spr=https&sv=2020-08-04&sr=c&sig=BeqlNR9v9HHXLrb9VoYFZMc6tv72ATuSrl8jlRPkJnE%3D"

for($i = 0; $i -lt $SOURCE_Array.length; $i++){

$SOURCE = -join('https://',$SOURCE_SA,'.blob.core.windows.net/',$SOURCE_Container,'/',$SOURCE_Layer,'/',$SOURCE_Array[$i],$SOURCE_SAS)
$TARGET = -join('https://',$TARGET_SA,'.blob.core.windows.net/',$TARGET_LOC,$TARGET_SAS)

Write-Output "DMP SOURCE FOLDER w/ SAS TOKEN..";
Write-Output $SOURCE;
Write-Output "";
Write-Output "DMP TARGET FOLDER w/ SAS TOKEN..."
Write-Output $TARGET
Write-Output "";
#uncomment below command once the $TARGET location found validated
.\azcopy cp $SOURCE $TARGET --log-level=INFO --recursive=TRUE --overwrite=TRUE --check-length=TRUE;

}
#cd C:\AzCopy\