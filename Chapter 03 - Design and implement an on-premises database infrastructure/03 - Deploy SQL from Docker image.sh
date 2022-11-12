##############################################################################
#
#   SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
#
#   © MICROSOFT PRESS
#
##############################################################################

sudo docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=<YourStrong!Passw0rd>' \
   -p 1433:1433 --name sql2022	 \
   -v /users/randolph/mssql:/mssql \
   -d mcr.microsoft.com/mssql/server:2022-latest
