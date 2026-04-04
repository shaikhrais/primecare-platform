enum DataSourceType {
  mock,
  api,
  hybrid
}

class DataSourceConfig {
  static DataSourceType currentMode = DataSourceType.api;
}
