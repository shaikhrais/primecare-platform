import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/config/data_source_mode.dart';
import 'package:flutter_core/config/api_config.dart';
import 'package:flutter_core/api_providers.dart';
import 'package:flutter_core/features/cfo_dashboard/domain/models/cfo_dashboard_view_model.dart';
import 'package:flutter_core/features/cfo_dashboard/data/dtos/cfo_dashboard_dto.dart';
import 'package:flutter_core/features/cfo_dashboard/data/mappers/cfo_dashboard_mapper.dart';

final cfoDashboardAdapterProvider = FutureProvider<CfoDashboardViewModel>((
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
      '$endpoint?route=CorporateRoutes.cfoDashboard',
    );

    if (response.statusCode == 200) {
      final dto = CfoDashboardDto.fromJson(
        response.data as Map<String, dynamic>,
      );
      return CfoDashboardMapper.fromApi(dto);
    } else {
      throw Exception(
        'API error loading CFO dashboard: ${response.statusCode}',
      );
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
      {
        'title': 'EBITDA (QTD)',
        'value': '\$1.4M',
        'trend': '+5%',
        'status': 'positive',
      },
      {
        'title': 'Cash Flow',
        'value': '\$2.1M',
        'trend': '+2%',
        'status': 'positive',
      },
      {
        'title': 'Operating Margin',
        'value': '18.4%',
        'trend': '-0.3%',
        'status': 'warning',
      },
      {
        'title': 'Accounts Receivable',
        'value': '\$0.8M',
        'trend': '-1.5%',
        'status': 'positive',
      },
    ],
    'revenueData': [1.2, 1.3, 1.1, 1.4, 1.6, 1.8],
    'revenueLabels': ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
    'expenseData': [40.0, 25.0, 20.0, 15.0],
    'expenseLabels': ['Payroll', 'Facilities', 'Marketing', 'Admin'],
    'ebitdaTargetValue': 1.4,
    'ebitdaTargetMax': 2.0,
  });
}
