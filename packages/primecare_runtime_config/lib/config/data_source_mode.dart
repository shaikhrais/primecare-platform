// Governance - Category: service | Purpose: Layer: 01_INFRASTRUCTURE
// Layer: 01_INFRASTRUCTURE
enum DataSourceType { mock, api, hybrid }

class DataSourceConfig {
  static DataSourceType currentMode = DataSourceType.api;
}
