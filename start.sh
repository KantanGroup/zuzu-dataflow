#!/bin/bash

root_folder=$(pwd)

if [ ! -d "$root_folder/kafka_2.11-0.10.1.0" ]; then
  wget http://ftp.jaist.ac.jp/pub/apache/kafka/0.10.1.0/kafka_2.11-0.10.1.0.tgz
  tar zxvf kafka_2.11-0.10.1.0.tgz
fi

if [ ! -f "$root_folder/spring-cloud-dataflow-server-local-1.1.0.RELEASE.jar" ]; then
  wget http://repo.spring.io/release/org/springframework/cloud/spring-cloud-dataflow-server-local/1.1.0.RELEASE/spring-cloud-dataflow-server-local-1.1.0.RELEASE.jar
fi

if [ ! -f "$root_folder/spring-cloud-dataflow-server-local-1.1.0.RELEASE.jar" ]; then
  wget http://repo.spring.io/release/org/springframework/cloud/spring-cloud-dataflow-shell/1.1.0.RELEASE/spring-cloud-dataflow-shell-1.1.0.RELEASE.jar
fi

options=""

cmds[1]="$root_folder/kafka_2.11-0.10.1.0/bin/zookeeper-server-start.sh $root_folder/kafka_2.11-0.10.1.0/config/zookeeper.properties"
titles[1]="Zookeeper"

cmds[2]="$root_folder/kafka_2.11-0.10.1.0/bin/kafka-server-start.sh $root_folder/kafka_2.11-0.10.1.0/config/server.properties"
titles[2]="Kafka"

platform=$(uname)
if [ "$platform" = "Darwin" ]; then
  for i in 1 2; do
    ttab ${cmds[i]}
  done
  sleep 3
  ttab java -jar $root_folder/spring-cloud-dataflow-server-local-1.1.0.RELEASE.jar --maven.proxy.protocol=https --maven.proxy.host=<host> --maven.proxy.port=<8080> --spring.datasource.url="jdbc:mysql://localhost:3306/dataflows?useUnicode=true&characterEncoding=UTF-8&useSSL=false" --spring.datasource.username=root --spring.datasource.password=rootroot --spring.datasource.driver-class-name=org.mariadb.jdbc.Driver
  sleep 20
  ttab java -jar $root_folder/spring-cloud-dataflow-shell-1.1.0.RELEASE.jar
else
  cmds[3]="java -jar $root_folder/spring-cloud-dataflow-server-local-1.1.0.RELEASE.jar --spring.datasource.url='jdbc:mysql://localhost:3306/dataflows?useUnicode=true&characterEncoding=UTF-8&useSSL=false' --spring.datasource.username=root --spring.datasource.password=toor --spring.datasource.driver-class-name=org.mariadb.jdbc.Driver"
  titles[3]="Server"
  cmds[4]="sleep 15;java -jar $root_folder/spring-cloud-dataflow-shell-1.1.0.RELEASE.jar"
  titles[4]="Client"
  for i in 1 2 3 4; do
    options+=( --tab-with-profile="Unnamed" -e "bash -c \"${cmds[i]} ; bash\"" )
  done

  gnome-terminal "${options[@]}"
fi

exit 0
