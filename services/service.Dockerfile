# Unified Dockerfile for PrimeCare Dart Microservices
FROM dart:stable AS build

# Receive the service name as a build argument
ARG SERVICE_PATH

# Copy shared packages first to leverage cache
WORKDIR /app
COPY packages/flutter_core /app/packages/flutter_core
COPY packages/database_client /app/packages/database_client

# Copy the specific service
COPY ${SERVICE_PATH} /app/service

# Fetch dependencies
WORKDIR /app/service
RUN dart pub get

# Compile the AOT binary
RUN dart compile exe bin/server.dart -o bin/server

# Use a minimal runtime image
FROM debian:stable-slim
# FROM scratch is possible but debian-slim is safer for dynamic library dependencies

# Install necessary libraries (like libpq if needed, though postgres package is pure dart)
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*

COPY --from=build /app/service/bin/server /app/server

# Expose the default Shelf port
EXPOSE 8080

# Run the binary
CMD ["/app/server"]
