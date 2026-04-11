import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/config/data_source_mode.dart';
import 'package:flutter_core/config/api_config.dart';
import 'package:flutter_core/api_providers.dart';
import 'package:flutter_core/features/ceo_dashboard/domain/models/ceo_dashboard_view_model.dart';
import 'package:flutter_core/features/ceo_dashboard/data/dtos/ceo_dashboard_dto.dart';
import 'package:flutter_core/features/ceo_dashboard/data/mappers/ceo_dashboard_mapper.dart';

final ceoDashboardAdapterProvider = FutureProvider<CeoDashboardViewModel>((
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
      '$endpoint?route=CorporateRoutes.ceoDashboard',
    );

    if (response.statusCode == 200) {
      final dto = CeoDashboardDto.fromJson(
        response.data as Map<String, dynamic>,
      );
      return CeoDashboardMapper.fromApi(dto);
    } else {
      throw Exception(
        'API error loading CEO dashboard: ${response.statusCode}',
      );
    }
  } catch (e) {
    if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
      return _fetchMock();
    }
    rethrow;
  }
});

CeoDashboardViewModel _fetchMock() {
  return CeoDashboardMapper.fromMock({
    'kpis': [
      {
        'title': 'YTD Revenue',
        'value': '\$4.2M',
        'trend': '+8%',
        'status': 'positive',
      },
      {
        'title': 'Total Facilities',
        'value': '14',
        'trend': '+1',
        'status': 'operational',
      },
      {
        'title': 'Active Staff',
        'value': '241',
        'trend': '+12',
        'status': 'operational',
      },
      {
        'title': 'Critical Alerts',
        'value': '0',
        'trend': '0',
        'status': 'positive',
      },
    ],
    'recentActivity': [
      {
        'title': 'Q2 Report finalized',
        'subtitle': 'Financial data complete',
        'timestamp': '10 mins ago',
      },
      {
        'title': 'Critical Alert resolved',
        'subtitle': 'Server downtime fixed',
        'timestamp': '1 hr ago',
      },
    ],
  });
}
