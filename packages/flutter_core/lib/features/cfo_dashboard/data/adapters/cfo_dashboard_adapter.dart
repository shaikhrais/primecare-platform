import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/data_source_mode.dart';
import '../../../../config/api_config.dart';
import '../../../../api_providers.dart';
import '../../domain/models/cfo_dashboard_view_model.dart';
import '../dtos/cfo_dashboard_dto.dart';
import '../mappers/cfo_dashboard_mapper.dart';

final cfoDashboardAdapterProvider = FutureProvider<CfoDashboardViewModel>((ref) async {
  if (DataSourceConfig.currentMode == DataSourceType.mock) {
    return _fetchMock();
  }

  try {
    final apiClient = ref.read(apiClientProvider);
    final endpoint = ApiConfig.endpoints['providerMetrics'] ?? '/api/v1/metrics';
    final response = await apiClient.get('$endpoint?route=CorporateRoutes.cfoDashboard');
    
    if (response.statusCode == 200) {
      final dto = CfoDashboardDto.fromJson(response.data as Map<String, dynamic>);
      return CfoDashboardMapper.fromApi(dto);
    } else {
      throw Exception('API error loading CFO dashboard: ${response.statusCode}');
    }
  } catch (e) {
    if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
      return _fetchMock();
    }
    rethrow;
  }
});

CfoDashboardViewModel _fetchMock() {
  return CfoDashboardMapper.fromMock({
    'kpis': [
      {'title': 'EBITDA (QTD)', 'value': '\$1.4M', 'trend': '+5%', 'status': 'positive'},
      {'title': 'Cash Flow', 'value': '\$2.1M', 'trend': '+2%', 'status': 'positive'},
      {'title': 'Operating Margin', 'value': '18.4%', 'trend': '-0.3%', 'status': 'warning'},
      {'title': 'Accounts Receivable', 'value': '\$0.8M', 'trend': '-1.5%', 'status': 'positive'},
    ]
  });
}
