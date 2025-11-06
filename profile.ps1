
# powershell -NoExit -NoLogo -ExecutionPolicy Bypass -File C:\path\to\profile.ps1

function TodaysDate {
    "Hello! Today is $(Get-Date -Format "dddd MMMM dd" )`n"
}

function Prompt {
    "$(Get-Location) ~> " 
}

function lockworkstation {
    rundll32.exe user32.dll,LockWorkStation
}

function sleepworkstation {
    if (!(Get-Command psshutdown64 -ErrorAction SilentlyContinue)) {
        Write-Host "psshutdown64 was not found. Install pstools or check PATH."
        return
    }
    psshutdown64 -d -t 0 /accepteula
}

function LocateExecutable {
    param (
        [string] $ExecutableName
    )

    $results = Get-Command $ExecutableName -All
    
    if ($results.CommandType -eq "Alias") {
        "$($results.Name)->$($results.Definition)"
    }
    else {
        $results.Source
    }
}

function what-functions {
    # see defined functions
    # filter out drive letters from the list
    (Get-ChildItem function:\ | Where-Object -Property Name -notlike "[A-Z]:").Name
}

function env {
    Get-ChildItem env:
}

function Python-Run {
    $argList = $args

    $Script = $argList[0]

    $Paths = $env:PATH -Split ";"
    foreach ($dir in $Paths) {
        if (Test-Path "$dir/$Script") {
            Write-Host "script found in $dir"
            $argList[0] = "$dir/$Script"
  
            $argList = $argList | ForEach-Object { "`"${_}`"" } # add quotes
            Write-Host $argList
            Start-Process "python" -NoNewWindow -Wait -ArgumentList $argList
        }
    }
}

function RandDir {
    $Dir = (Get-ChildItem | Where-Object { Test-Path -Path $_ -PathType Container } | Get-Random).Name
    Write-Host $Dir
    Set-Location $Dir
}

function Toggle-Monitor { 
    param (
        [int] $Mode
    )
    if ($Mode -eq 1) {
        displayswitch /external
    }
    elseif ($Mode -eq 2) {
        displayswitch /extend
    } 
    else {
        Write-Host "1 for single monitor. 2 for both monitors."
    }
}


TodaysDate
$host.UI.RawUI.WindowTitle = "PS"
cd $HOME

Set-Alias -Name ll -Value ls
Set-Alias -Name lock -Value lockworkstation
Set-Alias -Name which -Value LocateExecutable
Set-Alias -Name pyrun -Value Python-Run
Set-Alias -Name vi -Value "C:\Program Files\Git\usr\bin\vim.exe"
Set-Alias -Name tm -Value Toggle-Monitor

Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

#Set-PSReadlineOption -Colors @{ Parameter = 'Gray' }
Set-PSReadlineOption -Colors @{ 
    Parameter = '#b5b5b5' 
    Command = '#b5b5b5' }
Set-PSReadlineOption -BellStyle None