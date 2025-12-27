# =========================
# STAGE 1 : BUILD (Gradle)
# =========================
FROM eclipse-temurin:17-jdk-alpine AS builder

WORKDIR /app

# Copier les fichiers nécessaires à Gradle
COPY gradle gradle
COPY gradlew .
COPY gradlew.bat .
COPY build.gradle .
COPY settings.gradle .

RUN chmod +x gradlew

# Télécharger les dépendances (cache Docker)
RUN ./gradlew dependencies

# Copier le code source
COPY src src

# Construire l'application (sans tests)
RUN ./gradlew build -x test




# =========================
# STAGE 2 : RUN
# =========================
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar app.jar

RUN addgroup -S spring && adduser -S spring -G spring
USER spring

EXPOSE 8080

CMD ["java", "-jar", "app.jar"]






































































































