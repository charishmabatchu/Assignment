<#
    Author: Charishma Batchu
    Release Date: 10/27/2021
 
    Name: Get-GitRepo.ps1
    The purpose of this script is get Gitgub repos under an organization
    
    Parameters: 
    Org : This parameter is needed to provide the name of the organization to retrieve the information
    PAT : This parameter is used to authorize the GitHub
    
    Example: Run Get-GitRepo.ps1 -Org X060-CTXDT85 "charishmabatchu" -PAT "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"
#>

[CmdletBinding()]
PARAM(
    [Parameter(Mandatory=$false)][String] $Org = "charishmabatchu",
    [Parameter(Mandatory=$false)][String] $PAT = "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"
)


try
{
    #check if either of parmaters are null or empty
    if([string]::IsNullOrEmpty($PAT) -or ([string]::IsNullOrEmpty($Org)))
    {
        Write-Host "Make sure PAT and Organization Name are provided"
    }
    else
    {
        #build authorization header based on PAT
        $gitHeader = @{Authorization=("Basic{0}" -f [Convert]::ToBase64String([Text.Encoding]::ASCII.GetBytes(("{0}:{1}" -f "",$PAT))))}
        $gitRepoUri = "https://api.github.com/users/$Org/repos"

        #check if header is null or empty
        if($gitHeader -ne '' -or $gitHeader -ne 'null')
        {
            #GitHub API call to retrieve repos
            $Repos = Invoke-RestMethod -Uri $gitRepoUri -ContentType "application/vnd.github.v3+json" -Headers $gitHeader -Method GET
            Write-Host "Total Repos in $Org gitHub " $Repos.Count 
            if($Repos.Count -gt 0)
            {
                $filePath = "$PSScriptRoot\GitRepos.json"
                $Repos | ConvertTo-json | Out-File $filePath
                foreach($repo in $Repos)
                {
                    if($repo.name -eq 'Assignment')
                    {
                        Write-Host "Code Assignment Repo: "$repo.html_url
                    }
                }
            }
        }
        else
        {
            Write-Host "Invalid PAT Token"
        }
    }
}
catch{
    Write-Warning "Failed to retrieve information from GitHub"
    Write-Warning "Error Message $_"
}