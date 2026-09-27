FROM dart:stable
WORKDIR /workspace
COPY packages/database_client packages/database_client
COPY services/api_gateway services/api_gateway
WORKDIR /workspace/services/api_gateway
RUN dart pub get
EXPOSE 8080
CMD ["dart", "run", "bin/server.dart"]
