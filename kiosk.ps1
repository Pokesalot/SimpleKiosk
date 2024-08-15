cd $PSScriptRoot #This is a built-in variable that makes the working directory the same as where the script is.

#Get the date in a concise format
$TodaysDate = Get-Date -Format "MM-dd-yyyy"

#Check if a file exists to collect today's signins. If it doesn't, create one
if(!(Test-Path .\Signins\$TodaysDate.txt)){
    $null >> .\Signins\$TodaysDate.txt
}

#Create local lists for employees, everyone we've ever seen, and a blank one for
$employees = @(gc .\employees.txt)
$signins = @(gc .\Signins\$TodaysDate.txt)
$allSeen = @{}

$tempObj = gc .\everyone.json | ConvertFrom-Json
$tempObj.psobject.Properties | %{$allSeen[[string]($_.Name)] = $_.Value}

while($true){
    Write-Host -BackgroundColor Cyan -ForegroundColor White "Welcome to the Dr. Welch Makerspace! A makerspace at the Pennsylvania College of Technology, a special mission affiliate of the Pennsylvania State University!`n`n`n`n`n"
    $id = [string](Read-Host "Please scan your ID")


    if($id -in $employees){
        $allSeen | ConvertTo-Json > .\everyone.json
        Write-Host "Saved complete list of seen ID numbers to everyone.json!`n`nTotal signins so far today: $($signins.Count)"
    }else{

        if($id -in $signins){
            #Not only have we seen this person, we saw them at some point today. Take no action
            Write-Host -BackgroundColor DarkGreen -ForegroundColor Yellow "Hey wait a second, you look familiar. Welcome back!"
        }else{
            #This person has not signed in today, so we need to check if they've ever signed in before
            if($id -in $allSeen.Keys){
                #We have seen them before, welcome them to the space
                Write-Host -BackgroundColor DarkGreen -ForegroundColor Yellow "Welcome to the makerspace! You have been signed in!"
            }else{
                #We have not seen them before, have them stop and sign the waiver
                Write-Host -BackgroundColor DarkRed -ForegroundColor Red "STOP! You must sign paperwork to be here!"

                <#


                THIS IS WHERE CODE MAY NEED TO BE ADDED TO OPEN A WORD DOC, PDF, OR CALL OVER SOMEONE TO WATCH THEM SIGN A PAPER FORM


                #>
            }
            
            $allSeen["$id"] = $TodaysDate
            $signins += $id
            $id >> .\Signins\$TodaysDate.txt
        }

    }

    Start-Sleep -Seconds 5
    cls #clears the screen, ready for the next person
}