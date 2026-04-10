import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/data_source_mode.dart';
import '../../../../config/api_config.dart';
import '../../../../api_providers.dart';
import '../dtos/regional_manager_usa_dashboard_dto.dart';
import '../mappers/regional_manager_usa_dashboard_mapper.dart';
import '../../domain/models/regional_manager_usa_dashboard_view_model.dart';

final regionalManagerUsaDashboardAdapterProvider = FutureProvider.autoDispose<RegionalManagerUsaDashboardViewModel>((ref) async {
  if (DataSourceConfig.currentMode == DataSourceType.mock) {
    return RegionalManagerUsaDashboardMapper.toViewModel(
      const RegionalManagerUsaDashboardDto(rawKpis: []),
    );
  }

  try {
    final apiClient = ref.read(apiClientProvider);
    final endpoint = ApiConfig.endpoints['providerMetrics'] ?? '/api/v1/metrics';
    final response = await apiClient.get('$endpoint?route=CorporateRoutes.regionalManagerUsaDashboard');
    
    if (response.statusCode == 200) {
      final dto = RegionalManagerUsaDashboardDto.fromJson(response.data as Map<String, dynamic>);
      return RegionalManagerUsaDashboardMapper.toViewModel(dto);
    } else {
      throw Exception('Failed to load USA regional manager metrics: ${response.statusCode}');
    }
  } catch (e) {
    if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
      return RegionalManagerUsaDashboardMapper.toViewModel(
        const RegionalManagerUsaDashboardDto(rawKpis: []),
      );
    }
    rethrow;
  }
});
