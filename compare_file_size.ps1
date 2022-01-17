#Get my optimised video
$OptimisedFiles = Get-ChildItem E:\more_Optimiser -recurse | Select-Object Name, Length,FullName, @{Name="MegaBytes";Expression={"{0:F2}" -f ($_.length/1MB)}}
#Get my non optimised video
$NonOptimisedFiles = Get-ChildItem E:\more -recurse | Select-Object Name, Length,FullName, @{Name="MegaBytes";Expression={"{0:F2}" -f ($_.length/1MB)}}
# initialize my index var
$n = 0

$OptimisedFiles | ForEach-Object {

    
    Write-Host $n is the index
    # Check if the optimised file is really smaller than the original
    if ($NonOptimisedFiles[$n].Length -gt $_.Length) {
        # Log a few infos
        Write-Host non opti is bigger $NonOptimisedFiles[$n].MegaBytes vs $_.MegaBytes
        Write-Host $NonOptimisedFiles[$n].Name vs $_.Name
        Write-Host $NonOptimisedFiles[$n].Length vs $_.Length

        # Move the old video to save folder (in case of problems)
        Move-Item -Path $NonOptimisedFiles[$n].FullName -Destination E:\save\more

        # Move the optimised video to the good folder
        Copy-Item -Path $_.FullName -Destination E:\more
    }
    $n++

}
