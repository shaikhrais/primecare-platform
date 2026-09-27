FROM dart:stable
WORKDIR /workspace
COPY packages/database_client packages/database_client
COPY services/auth_api services/auth_api
WORKDIR /workspace/services/auth_api
RUN dart pub get
EXPOSE 8080
CMD ["dart", "run", "bin/server.dart"]
