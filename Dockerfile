FROM amazonlinux AS file
RUN yum install git -y
WORKDIR /app
RUN git clone https://github.com/RagavMuthukumar/java-spring-boot.git /app

FROM maven AS build
WORKDIR /source
COPY --from=file /app /source
RUN mvn clean install

FROM openjdk:17-alpine
WORKDIR /test
COPY --from=build /source/target/demo-0.0.1-SNAPSHOT.jar /test
CMD ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]
EXPOSE 8080