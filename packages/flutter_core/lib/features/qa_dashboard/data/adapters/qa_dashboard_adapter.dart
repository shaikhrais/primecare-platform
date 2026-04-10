import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/data_source_mode.dart';
import '../../../../config/api_config.dart';
import '../../../../api_providers.dart';
import '../dtos/qa_dashboard_dto.dart';
import '../mappers/qa_dashboard_mapper.dart';
import '../../domain/models/qa_dashboard_view_model.dart';

final qaDashboardAdapterProvider = FutureProvider.autoDispose<QaDashboardViewModel>((ref) async {
  if (DataSourceConfig.currentMode == DataSourceType.mock) {
    return QaDashboardMapper.toViewModel(
      const QaDashboardDto(rawKpis: []),
    );
  }

  try {
    final apiClient = ref.read(apiClientProvider);
    final endpoint = ApiConfig.endpoints['providerMetrics'] ?? '/api/v1/metrics';
    final response = await apiClient.get('$endpoint?route=CorporateRoutes.qaDashboard');
    
    if (response.statusCode == 200) {
      final dto = QaDashboardDto.fromJson(response.data as Map<String, dynamic>);
      return QaDashboardMapper.toViewModel(dto);
    } else {
      throw Exception('Failed to load Qa metrics: ${response.statusCode}');
    }
  } catch (e) {
    if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
      return QaDashboardMapper.toViewModel(
        const QaDashboardDto(rawKpis: []),
      );
    }
    rethrow;
  }
});
