﻿<#
.SYNOPSIS
	Opens Google Translate
.DESCRIPTION
	This PowerShell script launches the Web browser with the Google Translate website.
.EXAMPLE
	PS> ./open-google-translate
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

& "$PSScriptRoot/open-default-browser.ps1" "https://translate.google.com"
exit 0 # success
