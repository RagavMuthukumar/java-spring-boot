FROM amazonlinux AS file
RUN yum install git -y
WORKDIR /app
RUN git clone https://github.com/RagavMuthukumar/task.git /app

FROM maven AS build
WORKDIR /source
COPY --from=file /app /source
RUN mvn clean install

FROM openjdk:17-alpine
WORKDIR /test
COPY --from=build /source/target/app-0.0.1-SNAPSHOT.war /test
CMD ["java", "-jar", "app-0.0.1-SNAPSHOT.war"]
EXPOSE 8080