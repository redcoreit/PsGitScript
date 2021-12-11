function Invoke-PsGitScriptInit {
    try {
        Get-Command "git.exe" | Out-Null
    } 
    Catch { throw "git installation cannot be found." }

    $scripts = Get-Command "git-*.ps1"

    foreach ($item in $scripts) {
        $path = $item.Source
        $command = "\`"$path\`""
        $alias = "! pwsh -NoProfile -ExecutionPolicy bypass -WorkingDirectory `$PWD -c $command"
        $name = Split-Path $path -Leaf | Invoke-Regex "^git-(.*).ps1$" -Group 1

        # debug
        # Write-Host $alias
        # Write-Host $alias

        & git config --global "alias.$name" "$alias"
    }
}

Invoke-PsGitScriptInit

Export-ModuleMember -Function Invoke-PsGitScriptInit