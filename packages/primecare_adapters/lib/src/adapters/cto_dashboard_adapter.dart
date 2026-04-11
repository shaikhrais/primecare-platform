import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/data_source_mode.dart';
import '../config/api_config.dart';
import '../api_providers.dart';
import 'package:flutter_core/features/cto_dashboard/domain/models/cto_dashboard_view_model.dart';
import 'package:flutter_core/features/cto_dashboard/data/dtos/cto_dashboard_dto.dart';
import 'package:flutter_core/features/cto_dashboard/data/mappers/cto_dashboard_mapper.dart';

final ctoDashboardAdapterProvider = FutureProvider<CtoDashboardViewModel>((
  ref,
) async {
  if (DataSourceConfig.currentMode == DataSourceType.mock) {
    return _fetchMock();
  }

  try {
    final apiClient = ref.read(apiClientProvider);
    final endpoint =
        ApiConfig.endpoints['providerMetrics'] ?? '/api/v1/metrics';
    final response = await apiClient.get(
      '$endpoint?route=CorporateRoutes.ctoDashboard',
    );

    if (response.statusCode == 200) {
      final dto = CtoDashboardDto.fromJson(
        response.data as Map<String, dynamic>,
      );
      return CtoDashboardMapper.fromApi(dto);
    } else {
      throw Exception(
        'API error loading CTO dashboard: ${response.statusCode}',
      );
    }
  } catch (e) {
    if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
      return _fetchMock();
    }
    rethrow;
  }
});

CtoDashboardViewModel _fetchMock() {
  return CtoDashboardMapper.fromMock({
    'kpis': [
      {
        'title': 'System Uptime',
        'value': '99.99%',
        'trend': '+0.01%',
        'status': 'positive',
      },
      {
        'title': 'Active Connections',
        'value': '14,203',
        'trend': '+12%',
        'status': 'operational',
      },
      {
        'title': 'Error Rate',
        'value': '0.01%',
        'trend': '-0.1%',
        'status': 'positive',
      },
      {
        'title': 'Avg Latency',
        'value': '124ms',
        'trend': '-12ms',
        'status': 'positive',
      },
    ],
  });
}
