
# Quick Start

`Step 1` - Download the Spring Cloud Data Flow Server and Shell apps
  ```
  # wget http://repo.spring.io/release/org/springframework/cloud/spring-cloud-dataflow-server-local/1.1.0.RELEASE/spring-cloud-dataflow-server-local-1.1.0.RELEASE.jar

  # wget http://repo.spring.io/release/org/springframework/cloud/spring-cloud-dataflow-shell/1.1.0.RELEASE/spring-cloud-dataflow-shell-1.1.0.RELEASE.jar
  ```

`Step 2` - Start Kafka [used as: messaging middleware]

1. Download Kafka

  ```
  # wget http://ftp.jaist.ac.jp/pub/apache/kafka/0.10.1.0/kafka_2.11-0.10.1.0.tgz
  # tar zxvf kafka_2.11-0.10.1.0.tgz
  # cd kafka_2.11-0.10.1.0
  ```
2. Start server

  ```
  # bin/zookeeper-server-start.sh config/zookeeper.properties
  # bin/kafka-server-start.sh config/server.properties
  ```

`Step 4` - Launch ‘Local’ Server 

  ```
  # java -jar spring-cloud-dataflow-server-local-1.1.0.RELEASE.jar
  ```
  Running with Custom Maven Settings and/or Behind a Proxy and database MySQL
  
  ```
  # java -jar spring-cloud-dataflow-server-local-1.1.0.RELEASE.jar --maven.proxy.protocol=https --maven.proxy.host=<host> --maven.proxy.port=<port> --spring.datasource.url="jdbc:mysql://localhost:3306/dataflows?useUnicode=true&characterEncoding=UTF-8&useSSL=false" --spring.datasource.username=<username> --spring.datasource.password=<password> --spring.datasource.driver-class-name=org.mariadb.jdbc.Driver



  ```

`Step 5` - Launch Shell 
  
  ```
  # java -jar spring-cloud-dataflow-shell-1.1.0.RELEASE.jar
  ```

`Step 6` - Import all the out-of-the-box application coordinates in bulk 
  
  ```
  # dataflow:>app import --uri http://bit.ly/1-0-4-GA-stream-applications-kafka-maven
  ```
  
`Step 7` - Create ‘ticktock’ Stream 

  ```
  # dataflow:>stream create ticktock --definition "time | log" --deploy
  ```

You'll notice the following in ‘Local’ Server console.

`Step 8` - Open dashboard

  ```
  http://localhost:9393/dashboard
  ```
