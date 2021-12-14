$apiKey = Read-Host -Prompt "Enter your API key" -AsSecureString

Test-ModuleManifest -Path .\PsGitScript.psd1
Invoke-ScriptAnalyzer -Path .\PsGitScript.psm1
Publish-Module -Path . -NuGetApiKey $apiKey -Verbose
Update-Module PsGitScript -Force