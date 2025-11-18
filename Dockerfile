#Build stage
FROM maven:3.8.7-openjdk-18 AS build
WORKDIR /build
COPY pom.xml .
RUN mvn dependency:go-offline
COPY src ./src
RUN mvn clean package -DskipTests

#Runtime stage
FROM amazoncorretto:17
WORKDIR /app
COPY --from=build /build/target/devsecops-demo-*.jar /app/
EXPOSE 8181

ARG VERSION=1.0.0
ARG PROFILE=default

ENV ACTIVE_PROFILE=${PROFILE}
ENV APP_VERSION=${VERSION}

CMD java -jar -Dspring.profiles.active=${ACTIVE_PROFILE} devsecops-demo-${APP_VERSION}.jar

# docker build -t rupesh1997/devsecops-demo:1.0.0 -f Dockerfile .
# docker run -d -p 8181:8181 --name devsecops-demo rupesh1997/devsecops-demo:1.0.0