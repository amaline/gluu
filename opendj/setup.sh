#!/bin/bash

cd /opt/opendj

/opt/opendj/setup \
          --cli \
          --baseDN dc=dev,dc=fdic,dc=gov \
          --addBaseEntry \
          --ldapPort 1389 \
          --adminConnectorPort 4444 \
          --rootUserDN cn=Directory\ Manager \
          --rootUserPassword fdicpw1 \
          --doNotStart \
          --no-prompt \
          --noPropertiesFile
