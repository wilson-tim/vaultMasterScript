#!/bin/sh

# 21/03/2017  TW  New script to generate Liquibase changelog files for MySQL Prod environment

cd /root/bisystem/buildalake/liquibase/vault/db/changelog

rm -f generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-raw.xml
rm -f generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-bus.xml
rm -f generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-ctrl.xml
rm -f generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-logs.xml
rm -f generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-martKPI.xml
rm -f generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-martLegacy.xml
rm -f generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-vault.xml
rm -f generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-metrics.xml

echo raw
java -jar liquibase/liquibase.jar --driver=com.mysql.jdbc.Driver --changeLogFile=generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-raw.xml --classpath=mysql-connector-java-5.1.38-bin.jar --url=jdbc:mysql://mi-lkvault-prod.c2fi4unjxcxr.eu-west-1.rds.amazonaws.com/raw --username=vault --password=NasagjajbyikDeHoshIs generateChangeLog

echo bus
java -jar liquibase/liquibase.jar --driver=com.mysql.jdbc.Driver --changeLogFile=generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-bus.xml --classpath=mysql-connector-java-5.1.38-bin.jar --url=jdbc:mysql://mi-lkvault-prod.c2fi4unjxcxr.eu-west-1.rds.amazonaws.com/bus --username=vault --password=NasagjajbyikDeHoshIs generateChangeLog

echo ctrl
java -jar liquibase/liquibase.jar --driver=com.mysql.jdbc.Driver --changeLogFile=generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-ctrl.xml --classpath=mysql-connector-java-5.1.38-bin.jar --url=jdbc:mysql://mi-lkvault-prod.c2fi4unjxcxr.eu-west-1.rds.amazonaws.com/ctrl --username=vault --password=NasagjajbyikDeHoshIs generateChangeLog

echo logs
java -jar liquibase/liquibase.jar --driver=com.mysql.jdbc.Driver --changeLogFile=generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-logs.xml --classpath=mysql-connector-java-5.1.38-bin.jar --url=jdbc:mysql://mi-lkvault-prod.c2fi4unjxcxr.eu-west-1.rds.amazonaws.com/logs --username=vault --password=NasagjajbyikDeHoshIs generateChangeLog

echo martKPI
java -jar liquibase/liquibase.jar --driver=com.mysql.jdbc.Driver --changeLogFile=generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-martKPI.xml --classpath=mysql-connector-java-5.1.38-bin.jar --url=jdbc:mysql://mi-lkvault-prod.c2fi4unjxcxr.eu-west-1.rds.amazonaws.com/martKPI --username=vault --password=NasagjajbyikDeHoshIs generateChangeLog

echo martLegacy
java -jar liquibase/liquibase.jar --driver=com.mysql.jdbc.Driver --changeLogFile=generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-martLegacy.xml --classpath=mysql-connector-java-5.1.38-bin.jar --url=jdbc:mysql://mi-lkvault-prod.c2fi4unjxcxr.eu-west-1.rds.amazonaws.com/martLegacy --username=vault --password=NasagjajbyikDeHoshIs generateChangeLog

echo vault
java -jar liquibase/liquibase.jar --driver=com.mysql.jdbc.Driver --changeLogFile=generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-vault.xml --classpath=mysql-connector-java-5.1.38-bin.jar --url=jdbc:mysql://mi-lkvault-prod.c2fi4unjxcxr.eu-west-1.rds.amazonaws.com/vault --username=vault --password=NasagjajbyikDeHoshIs generateChangeLog

echo metrics
java -jar liquibase/liquibase.jar --driver=com.mysql.jdbc.Driver --changeLogFile=generateChangeLog/$(date +\%Y\%m\%d)-generateChangeLog-metrics.xml --classpath=mysql-connector-java-5.1.38-bin.jar --url=jdbc:mysql://mi-lkvault-prod.c2fi4unjxcxr.eu-west-1.rds.amazonaws.com/metrics --username=vault --password=NasagjajbyikDeHoshIs generateChangeLog
