  # Creating an Azure SQL database on an existing server and resource group
  # Then retriving information about the newly created database
  # Prerequisites: 
  #   Resource group and Azure SQL server exist
  #   Azure CLI installed
  # Change the values on lines 9 - 17 to fit your environment 
  
  az sql db create \
   --resource-group SSIO2022 \
   --server ssio2022 \
   --name Contoso \
   --collation Latin1_General_CI_AS \
   --edition GeneralPurpose \
   --capacity 2 \
   --family Gen5 \
   --compute-model Provisioned 
az sql db show --resource-groupSIO2022 --server ssio2022 --name Contoso
