const fs = require('fs');
const path = require('path');

const ROOT_DIR = path.join(__dirname, '..');
const SERVICES_DIR = path.join(ROOT_DIR, 'services');

const services = fs.readdirSync(SERVICES_DIR).filter(file => fs.statSync(path.join(SERVICES_DIR, file)).isDirectory());

let composeServices = '';
let portCounter = 3001;

const dockerfileTemplate = `
# Official Dart image
FROM dart:stable AS build

# Resolve app dependencies
WORKDIR /app
COPY pubspec.* ./
RUN dart pub get

# Copy app source code
COPY . .

# Ensure packages are still up-to-date if anything has changed
RUN dart pub get --offline
RUN dart compile exe bin/server.dart -o bin/server

# Build minimal serving image from AOT-compiled /server and required system
# libraries and configuration files stored in /runtime/ from the build stage.
FROM scratch
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/bin/

# Start server.
EXPOSE 8080
CMD ["/app/bin/server"]
`;

let generatedCount = 0;

services.forEach(service => {
    // Write the Dockerfile
    const dockerfilePath = path.join(SERVICES_DIR, service, 'Dockerfile');
    fs.writeFileSync(dockerfilePath, dockerfileTemplate.trim(), 'utf8');
    
    // Append to docker-compose.yml services block
    composeServices += `
  ${service}:
    build:
      context: ./services/${service}
      dockerfile: Dockerfile
    ports:
      - "${portCounter}:8080"
    environment:
      - PORT=8080
      - DATABASE_URL=postgresql://admin:password123@db:5432/primecare?schema=public
    depends_on:
      - db
`;
    portCounter++;
    generatedCount++;
});

const composeTemplate = `
version: '3.8'

services:
  db:
    image: postgres:15-alpine
    restart: always
    environment:
      POSTGRES_USER: admin
      POSTGRES_PASSWORD: password123
      POSTGRES_DB: primecare
    ports:
      - "5432:5432"
    volumes:
      - pgdata:/var/lib/postgresql/data

${composeServices}

volumes:
  pgdata:
`;

fs.writeFileSync(path.join(ROOT_DIR, 'docker-compose.yml'), composeTemplate.trim(), 'utf8');

console.log(`Successfully generated Dockerfiles for ${generatedCount} microservices and created master docker-compose.yml.`);
