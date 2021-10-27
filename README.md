Installation Prerequisites
============================

Here are the most important prerequisites:
1) Enable execution of PowerShell scripts (read more article About Execution Policies in PowerShell documentation)

Testing the Script
============================
1. Download the repo to local folder
2. Open "Windows PowerShell"
3. Navigate to the repo folder from Step#1
4. To Get computer information of any machine run Get-ComputerInfo.ps1 by providing computername parameter
	E.g., Get-ComputerInfo.ps1 -ComputerName "X060-CTXDT85"
	This will create a json file in Step#1 folder with the computer information (file name will be computername.json)
5. To Call GitHub Rest API to list all Repos along with current repo execute Get-GitRepos.ps1.
	Here paramaters are optional and you can make them mandatory if required
	E.g., Get-GitRepos.ps1 -Org "OrgName" -PAT "PAT Token"
	This will create a json file in Step#1 folder with the Repo's information (file name will be GitRepos.json)
