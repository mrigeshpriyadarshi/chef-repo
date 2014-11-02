alert_email Cookbook
======================
Cookbook configures Mail Handler which send mails on names specified in the Data Bag.

1.   The cookbook, as of now supports, redhat family Operating Systems.
2.   The cookbook installs as root user and group on system level.
3.   The cookbook installs and configures Mail Handler on the system.
4.    It send mails on names specified in the Attribute File in case of Chef run completeion with Updated resources and Exceptions.
5.    This cookbook works as an base cookbook for the called app cookbooks to configure Mail Handler.

Requirements
------------
1.  It needs chef-mail-handler gem installed on the system.

License and Authors
-------------------
Authors: Mrigesh Priyadarshi (mrigeshpriyadarshi@gmail.com)