function Invoke-Regex { 
    param
    (		
        [Parameter(Mandatory = $true, Position = 0)]
        [string]
        $Regex,
		
        [Parameter(Mandatory = $False, Position = 1)]
        [int]
        $GroupIndex = 0,

        [Parameter(Mandatory = $false, Position = 2, ValueFromPipeline = $true)]
        [string]
        $Text = ""
    )

    Process {
        if ($Text -match $Regex) {
            return $Matches[$GroupIndex]
        }
    }
}

function Invoke-PsGitScriptInit {
    try {
        Get-Command "git.exe" | Out-Null
    } 
    Catch { throw "git installation cannot be found." }

    $scripts = Get-Command "git-*.ps1"

    foreach ($item in $scripts) {
        $path = $item.Source
        $command = $path.Replace('\', '/')
        $alias = "! pwsh -NoProfile -ExecutionPolicy bypass -WorkingDirectory `$PWD -c $command"
        $name = Split-Path $path -Leaf | Invoke-Regex -Regex "^git-(.*).ps1$" -Group 1

        & git config --global "alias.$name" "$alias"
    }
}

Invoke-PsGitScriptInit

Export-ModuleMember -Function Invoke-PsGitScriptInit
