$api_key = "ITG.xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
$path = Read-Host "Enter the CSV file path"
$CSVData = Import-Csv -Path $path
$asset_id_list = $CSVData | Select-Object -ExpandProperty id
<#Update MAC and Serial_Number for configuration#>

foreach($id in $asset_id_list)
{

	$PatchUrl = "https://api.itglue.com/configurations/"+$id
	$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/vnd.api+json")
$headers.Add("x-api-key", $api_key)

$body = @"
{
    `"data`":
         {          
             `"type`": `"configurations`",
             `"attributes`": {
                `"configuration-status-id`":`"74297`"
             }
         }
 }

"@

$response = Invoke-RestMethod $PatchUrl -Method 'PUT' -Headers $headers -Body $body
$response | ConvertTo-Json
}
