import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/data_source_mode.dart';
import '../../../../config/api_config.dart';
import '../../../../api_providers.dart';
import '../../domain/models/coo_dashboard_view_model.dart';
import '../dtos/coo_dashboard_dto.dart';
import '../mappers/coo_dashboard_mapper.dart';

final cooDashboardAdapterProvider = FutureProvider<CooDashboardViewModel>((ref) async {
  if (DataSourceConfig.currentMode == DataSourceType.mock) {
    return _fetchMock();
  }

  try {
    final apiClient = ref.read(apiClientProvider);
    final endpoint = ApiConfig.endpoints['providerMetrics'] ?? '/api/v1/metrics';
    final response = await apiClient.get('$endpoint?route=CorporateRoutes.cooDashboard');
    
    if (response.statusCode == 200) {
      final dto = CooDashboardDto.fromJson(response.data as Map<String, dynamic>);
      return CooDashboardMapper.fromApi(dto);
    } else {
      throw Exception('API error loading COO dashboard: ${response.statusCode}');
    }
  } catch (e) {
    if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
      return _fetchMock();
    }
    rethrow;
  }
});

CooDashboardViewModel _fetchMock() {
  return CooDashboardMapper.fromMock({
    'kpis': [
      {'title': 'Active Shifts', 'value': '1,240', 'trend': '+24', 'status': 'positive'},
      {'title': 'Fulfillment Rate', 'value': '98.5%', 'trend': '+1.2%', 'status': 'positive'},
      {'title': 'Compliance Score', 'value': '99.1%', 'trend': '+0.5%', 'status': 'operational'},
      {'title': 'Critical Incidents', 'value': '2', 'trend': '-2', 'status': 'critical'},
    ]
  });
}
