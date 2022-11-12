REM ##############################################################################
REM
REM SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
REM
REM © MICROSOFT PRESS
REM
REM ##############################################################################

REM Use command line to perform a silent install of SSMS without installing ADS
REM Navigate to the location of the SSMS Installer and then execute the code below

SSMS-Setup-ENU.exe /Passive DoNotInstallAzureDataStudio=1 
