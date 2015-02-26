name             'alert_email'
maintainer       'Mrigesh Priyadarshi'
maintainer_email 'mrigeshpriyadarshi@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures alert_email'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.1'

depends	'chef_handler'

recipe "alert_email", "Includes the RedHat recipe or any other recipe on the basis of Operating System Platform."
recipe "alert_email::linux", "Configure Mail Handler for Chef client Run on RedHat and CentOs machines"


%w{ redhat centos }.each { |os| supports os }