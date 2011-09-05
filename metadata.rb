maintainer       "Alastair Brunton"
maintainer_email "info@simplyexcited.co.uk"
license          "MIT"
description      "Installs/Configures apache2_custom"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.textile'))
version          "0.0.1"
supports          "ubuntu"
recipe            "apache2_custom", "Add /var/www/apps and setup group permissions"
recipe            "apache2_custom::github", "Setup github deployment."