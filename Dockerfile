FROM maven:3.6.3-openjdk-16
MAINTAINER priotix

WORKDIR /home/app

COPY pom.xml /home/app/

RUN mvn -f /home/app/pom.xml install

COPY src /home/app/src

CMD mvn test -Dtest=Runner -Dmaven.surefire.debug="-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=*:5005" -f /home/app/pom.xml