# PsGitScript

Make git extensible like it is on any non-windows OS with your own (powershell) scripts.
You can achieve the same without this module but it can save you time and headaches.

## How does it work?

PsGitScript is a simple powershell module that scans your directories (from PATH env. variable) for potential git extensions `git-<alias>.ps1`. The extension scripts will be added to the `.gitconfig` file as an alias. After that you can invoke them like `git <alias>`.

PsGitScript will update aliases on every powershell launch, but never deletes anything from `.gitconfig` file.

## How to install

Installation using package manager (probably winget) will be supported and recommended in the future.

Right now you can download the script (with container folder) and put it in your PATH.

### Prerequisites

- Powershell (tested on Powershell 7)

- Enable script execution. [Set-ExecutionPolicy](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.security/set-executionpolicy?view=powershell-7.2)

- Git for Windows (tested on git version 2.34.1.windows.1)

### Installation steps

Download the module, and put it in a folder:

`C:\PsGitScript\PsGitScript.psm1`

Edit the `Profile.ps1` file and add the following line:

```powershell
Import-Module "C:\PsGitScript"
```

## Creating your own git script

### Basic script

Create a script `git-test.ps1` in a folder that is included in `$Path` variable, with the following content:

```powershell
Write-Host "Hello, World!"
```

> You can check `$Path` variable in powershell with the following command: `$Env:Path -Split ';'`

You just created a new script what needs to be registered in .gitconfig as an alias.
You can restart your pwsh session or execute the `Invoke-PsGitScriptInit` command to update the aliases.

Now you can call your script:

```powershell
git hello
```

### Advanced scripting

Please note that every git script runs in a new `pwsh` session with no profile and `bypass` execution policy.

Creating an initializer script for your custom git scripts is strongly recommended.
