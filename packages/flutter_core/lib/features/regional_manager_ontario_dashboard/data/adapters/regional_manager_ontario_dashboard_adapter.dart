import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/data_source_mode.dart';
import '../../../../config/api_config.dart';
import '../../../../api_providers.dart';
import '../dtos/regional_manager_ontario_dashboard_dto.dart';
import '../mappers/regional_manager_ontario_dashboard_mapper.dart';
import '../../domain/models/regional_manager_ontario_dashboard_view_model.dart';

final regionalManagerOntarioDashboardAdapterProvider =
    FutureProvider.autoDispose<RegionalManagerOntarioDashboardViewModel>((
      ref,
    ) async {
      if (DataSourceConfig.currentMode == DataSourceType.mock) {
        return RegionalManagerOntarioDashboardMapper.toViewModel(
          const RegionalManagerOntarioDashboardDto(rawKpis: []),
        );
      }

      try {
        final apiClient = ref.read(apiClientProvider);
        final endpoint =
            ApiConfig.endpoints['providerMetrics'] ?? '/api/v1/metrics';
        final response = await apiClient.get(
          '$endpoint?route=CorporateRoutes.regionalManagerOntarioDashboard',
        );

        if (response.statusCode == 200) {
          final dto = RegionalManagerOntarioDashboardDto.fromJson(
            response.data as Map<String, dynamic>,
          );
          return RegionalManagerOntarioDashboardMapper.toViewModel(dto);
        } else {
          throw Exception(
            'Failed to load Ontario regional manager metrics: ${response.statusCode}',
          );
        }
      } catch (e) {
        if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
          return RegionalManagerOntarioDashboardMapper.toViewModel(
            const RegionalManagerOntarioDashboardDto(rawKpis: []),
          );
        }
        rethrow;
      }
    });
