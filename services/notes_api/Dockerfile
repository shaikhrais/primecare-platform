FROM dart:3.11.3
WORKDIR /workspace
COPY packages/database_client packages/database_client
COPY packages/server_core packages/server_core
COPY services/notes_api services/notes_api
WORKDIR /workspace/services/notes_api
RUN dart pub get
EXPOSE 8080
CMD ["dart", "run", "bin/server.dart"]
