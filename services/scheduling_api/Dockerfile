FROM dart:3.11.3
WORKDIR /workspace
COPY packages/database_client packages/database_client
COPY packages/server_core packages/server_core
COPY services/scheduling_api services/scheduling_api
WORKDIR /workspace/services/scheduling_api
RUN dart pub get
EXPOSE 8080
CMD ["dart", "run", "bin/server.dart"]
