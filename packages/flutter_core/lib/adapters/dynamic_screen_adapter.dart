import 'package:primecare_core/config/data_source_mode.dart';
import 'package:primecare_core/network/api_client.dart';
import 'package:primecare_core/src/factory_floor/data_logistics_hub.dart';

class DynamicScreenAdapter {
  final String screenId;
  final ApiClient apiClient;

  DynamicScreenAdapter({required this.screenId, required this.apiClient});

  Future<Map<String, dynamic>> getData() async {
    if (DataSourceConfig.currentMode == DataSourceType.hybrid ||
        DataSourceConfig.currentMode == DataSourceType.mock) {
      return DataLogisticsHub.safeLookup<Map<String, dynamic>>(
        'institutional_nodes.screenDefinition.$screenId',
        {
          'title': 'Dynamic Screen: $screenId (Cache)',
          'status': 'ACTIVE',
          'screenId': screenId,
          'uiComponentType': 'CardLayout',
          'layoutType': 'Standard',
        },
      );
    }

    try {
      final response = await apiClient.get('/screens/$screenId');
      if (response.statusCode == 200) {
        return response.data as Map<String, dynamic>;
      } else {
        return {
          'title': 'Dynamic Screen: $screenId (Degraded)',
          'status': 'DEGRADED',
          'screenId': screenId,
          'isOffline': true,
        };
      }
    } catch (e) {
        return {
          'title': 'Dynamic Screen: $screenId (Offline)',
          'status': 'OFFLINE',
          'screenId': screenId,
          'isOffline': true,
          'error': e.toString(),
        };
    }
  }
}
