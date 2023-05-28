FROM maven as build
WORKDIR /app
COPY . .
RUN mvn install

FROM openjdk:11.0
WORKDIR /app
COPY --from=build /app/src/main/Uber.jar /app/
EXPOSE 8080
CMD [ "java","-jar","Uber.jar"]