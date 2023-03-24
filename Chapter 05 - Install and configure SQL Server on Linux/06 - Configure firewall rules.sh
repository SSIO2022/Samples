##############################################################################
#
#   SAMPLE SCRIPTS TO ACCOMPANY "SQL SERVER 2022 ADMINISTRATION INSIDE OUT"
#
#   © MICROSOFT PRESS
#
##############################################################################

# Note: the firewall configuration must be reloaded after it has been modified
#       to take effect.

sudo firewall-cmd --zone=public --add-port=1433/tcp --permanent
sudo firewall-cmd --zone=public --add-port=1434/tcp --permanent
sudo firewall-cmd --reload
