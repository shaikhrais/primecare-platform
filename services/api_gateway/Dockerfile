FROM dart:3.11.3
WORKDIR /workspace
COPY packages/database_client packages/database_client
COPY packages/server_core packages/server_core
COPY services/api_gateway services/api_gateway
WORKDIR /workspace/services/api_gateway
RUN dart pub get
EXPOSE 8700
CMD ["dart", "run", "bin/server.dart"]
