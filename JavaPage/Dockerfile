FROM tomcat:10.1-jdk21

# Copiar tu aplicación
COPY ./JavaPage /usr/local/tomcat/webapps/Javapage

# Copiar el conector MySQL al lib de Tomcat
COPY ./JavaPage/WEB-INF/lib/mysql-connector-j-9.2.0.jar /usr/local/tomcat/lib/

EXPOSE 8080

CMD ["catalina.sh", "run"]
