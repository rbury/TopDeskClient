﻿function Get-BlankAsset {
  <#
    .Synopsis

      Short description

    .DESCRIPTION

      Long description

    .PARAMETER <Parameter-Name>

      The description of a parameter.

    .EXAMPLE

      Example of how to use this cmdlet

    .INPUTS

      The Microsoft .NET Framework types of objects that can be piped to the function or script.
      You can also include a description of the input objects.

    .OUTPUTS

      The .NET Framework type of the objects that the cmdlet returns.
      You can also include a description of the returned objects.

    .NOTES

      Additional information about the function or script.

    .LINK

        https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-Asset.md

  #>
  [CmdletBinding(DefaultParameterSetName = 'Default',
    PositionalBinding = $false,
    HelpUri = 'https://github.com/rbury/TopDeskClient/blob/master/Docs/Get-BlankAsset.md',
    ConfirmImpact = 'Medium')]

  Param (

    # Asset template id
    [Parameter(Mandatory = $true,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'ByID')]
    [Alias('ID')]
    [string]
    $TemplateID,

    # Asset template name (case sensitive)
    [Parameter(Mandatory = $true,
      ValueFromPipelineByPropertyName = $true,
      ParameterSetName = 'Default')]
    [Alias('Name')]
    [string]
    $TemplateName

  )

  begin {

    if (!($script:tdConnected)) {

      $PSCmdlet.ThrowTerminatingError([System.Management.Automation.ErrorRecord]::new("Cannot use TopDesk Client when disconnected.", $null, [System.Management.Automation.ErrorCategory]::InvalidOperation, $null))

    }
  }

  process {

    if ($PSCmdlet.ParameterSetName -eq 'ByID') {

      $_uri = $script:tdURI + '/tas/api/assetmgmt/assets/blank?templateId=' + $TemplateID

    }
    else {

      $_uri = $script:tdURI + '/tas/api/assetmgmt/assets/blank?templateName=' + $TemplateName

    }

    Get-APIResponse -Method 'GET' -APIUrl $_uri -Headers @{'Content-Type' = 'application/json' } -tdCredential $script:tdCredential

  }

  end { }
}