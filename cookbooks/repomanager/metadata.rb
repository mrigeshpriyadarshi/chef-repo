name             'repomanager'
maintainer       'Mrigesh Priyadarshi'
maintainer_email 'mrigeshpriyadarshi@gmail.com'
license          'Apache 2.0'
description      'Installs/Configures yum'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.3'

recipe "repomanager", "Includes the RedHat recipe or SUSE recipe on the basis of Operating System Platform."
recipe "repomanager::redhat", "Configures YUM Repo on Redhat and CentOS machines"
recipe "repomanager::suse", "Configures ZYPPER Repo on SUSE machines"

depends          "ip_region" 

%w{ redhat centos suse}.each { |os| supports os }