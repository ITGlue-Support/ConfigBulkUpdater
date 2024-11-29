$api_key = "ITG.a05cab5adc0a07cee7abc1bc1c0043f9.7ybDcJrEELabZRP9T3Q70iM1CohSB2Mwb09Pv10L3ZZMio1vAbhoCn1_x44aOuDd"
$count = 0
$Org_idcount = Read-Host "Enter the count of org you wish to update configurations.(For e.g.: 10)"
$headers = New-Object "System.Collections.Generic.Dictionary[[String],[String]]"
$headers.Add("Content-Type", "application/vnd.api+json")
$headers.Add("x-api-key", $api_key)

$PatchUrl = "https://api.itglue.com/configuration_statuses?page[size]=1000"

$responseconfigstatus = Invoke-RestMethod $PatchUrl -Method 'GET' -Headers $headers

foreach($configstatus in $responseconfigstatus.data){

if($configstatus.attributes.name -eq 'Inactive'){

$fetchconfigstatusid = $configstatus.id

}

}

for($i=0; $i -le $Org_idcount; $i++){

$org_id = Read-Host "Enter organization ID/IDs"
$PatchUrl = "https://api.itglue.com/organizations/"+$org_id+"/relationships/configurations?page[size]=1000"
$response = Invoke-RestMethod $PatchUrl -Method 'GET' -Headers $headers

$totalconfigpage = $response.meta.'total-pages'


for($i=1; $i -le $totalconfigpage; $i++){

$responseGet = Invoke-RestMethod $PatchUrl -Method 'GET' -Headers $headers

foreach($orphanedasset in $responseGet.data){

if($orphanedasset.attributes.'psa-integration' -eq "orphaned"){

$asset_id_list = $orphanedasset.id


foreach($id in $asset_id_list)
{



Write-Host "Configuration_id: "$id

$body = @"
{
    `"data`":
         {          
             `"type`": `"configurations`",
             `"attributes`": {
                "archived": true
             }
         }
 }

"@
$PatchUrlUpdate = "https://api.itglue.com/organizations/"+$org_id+"/relationships/configurations/"+$id
$responseupdate = Invoke-RestMethod $PatchUrlupdate -Method 'PATCH' -Headers $headers -Body $body

$count++
Write-Host "Count of item being updated: "$count
}
}
}
}
}
