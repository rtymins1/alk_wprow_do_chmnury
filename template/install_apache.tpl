#!/bin/bash

echo "*****    Installing Apache    *****"

      apt-get update
      apt-get install apache2 -y
      service apache2 restart
      echo "
<h3>Wprowadzenie do Chmury zaliczone?</h3>" | tee /var/www/html/index.html


echo "*****   Startup script completes!!    *****"