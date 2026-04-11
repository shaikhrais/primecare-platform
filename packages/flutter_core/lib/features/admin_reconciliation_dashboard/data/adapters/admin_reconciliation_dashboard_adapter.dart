import '../../domain/models/admin_reconciliation_dashboard_view_model.dart';
import '../../../../network/api_client.dart';
import '../../../../config/api_config.dart';
import '../../../../config/data_source_mode.dart';

class AdminReconciliationDashboardAdapter {
  final ApiClient _apiClient;

  AdminReconciliationDashboardAdapter(this._apiClient);

  Future<AdminReconciliationDashboardViewModel> getData(String endpointKey) async {
    try {
      final path = ApiConfig.endpoints[endpointKey] ?? '/v1/primecare/office/$endpointKey';
      final response = await _apiClient.get(path);
      if (response.statusCode == 200) {
        return const AdminReconciliationDashboardViewModel(blueprints: []);
      }
      throw Exception('Failed to load: ${response.statusCode}');
    } catch (e) {
      if (DataSourceConfig.currentMode == DataSourceType.hybrid ||
          DataSourceConfig.currentMode == DataSourceType.mock) {
        return const AdminReconciliationDashboardViewModel(isOfflineFallback: true, blueprints: []);
      }
      rethrow;
    }
  }
}
