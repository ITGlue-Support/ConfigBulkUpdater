README
Author: Binara Silva

The PowerShell script has been created to update configurations in bulk from the backend. Using this script, partners can update the following in the backend via their API:

    Configuration Interfaces
    Configuration Statuses
    Configuration Types
    Configurations

Refer to the article at https://api.itglue.com/developer/ for all attributes that are supported and that you need to specify in the scrip

- The base URL for all endpoints and methods is:
https://api.itglue.com

- Partners with an account in the EU data center will use:
https://api.eu.itglue.com

- Partners with an account in the Australia data center will use:
https://api.au.itglue.com

1) Prepare the script:

Download the file updatebulkfromCSV.ps1 and make the changes as explained below

$api_key = "API key generated from your account"

In the script, the PATCH HTTP method is used to modify the values of the resource properties.

In the data file, specify the changes you would like to have in the configuration list provided in the CSV file 'asset_id_list'.

    `"data`":
         {          
             `"type`": `"configurations`",
             `"attributes`": {
                `"configuration-status-id`":`"xxxxxxx`"
             }
         }

In this example, the requirement is to change the configuration status of the list of configurations, so the configuration-status-id is used here as the attribute

2) Prepare to Execute the Script

Move the prepared updatebulkfromCSV.ps1 file and the asset_id_list (where the configuration IDs are listed) to a separate folder. Ensure the configuration IDs are listed under the column 'ID' in the CSV file.
Open PowerShell (running as an administrator is preferred) and navigate to the folder path. For example:
cd "C:\Users\BSILVA\Desktop\Ben_PShell"

Now execute the script:
.\updatebulkfromCSV.ps1

The prompt will ask you to specify Enter the CSV file path:. This is where you stored your configuration list. For example:
C:\Users\BSILVA\Desktop\Ben_PShell\asset_id_list.csv


Exception Cases:
- Wrong api_key
- Wrong base_url
- Restrictions on the execution policy: (Partners can use powershell.exe -noprofile -executionpolicy bypass -file .\updatebulkfromCSV.ps1 to bypass restrictions and run scripts without any limitations. This is useful for executing scripts that might be blocked by the current execution policy).

Note: In some cases, partners may require support to generate the configuration list with IDs from the backend, which may help this process. Please use the database or seek assistance from a senior engineer to obtain the required data from the backend.

-----------------------------------------------------------
Disclaimer:

The information provided here by IT Glue is for general informational purposes only. All information is provided in good faith, however, we make no representations or warranties of any kind, express or implied, regarding the accuracy, adequacy, validity, reliability, availability, or completeness of any information provided.

Under no circumstances shall we have any liability to you for any loss or damage of any kind incurred as a result of the use of the information provided here. Your use of this information is solely at your own risk.
