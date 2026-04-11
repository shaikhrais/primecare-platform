import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/data_source_mode.dart';
import '../config/api_config.dart';
import '../api_providers.dart';
import 'package:flutter_core/features/scrum_master_dashboard/data/dtos/scrum_master_dashboard_dto.dart';
import 'package:flutter_core/features/scrum_master_dashboard/data/mappers/scrum_master_dashboard_mapper.dart';
import 'package:flutter_core/features/scrum_master_dashboard/domain/models/scrum_master_dashboard_view_model.dart';

final scrumMasterDashboardAdapterProvider =
    FutureProvider.autoDispose<ScrumMasterDashboardViewModel>((ref) async {
      if (DataSourceConfig.currentMode == DataSourceType.mock) {
        return ScrumMasterDashboardMapper.toViewModel(
          const ScrumMasterDashboardDto(rawKpis: []),
        );
      }

      try {
        final apiClient = ref.read(apiClientProvider);
        final endpoint =
            ApiConfig.endpoints['providerMetrics'] ?? '/api/v1/metrics';
        final response = await apiClient.get(
          '$endpoint?route=CorporateRoutes.scrumMasterDashboard',
        );

        if (response.statusCode == 200) {
          final dto = ScrumMasterDashboardDto.fromJson(
            response.data as Map<String, dynamic>,
          );
          return ScrumMasterDashboardMapper.toViewModel(dto);
        } else {
          throw Exception(
            'Failed to load scrum_master metrics: ${response.statusCode}',
          );
        }
      } catch (e) {
        if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
          return ScrumMasterDashboardMapper.toViewModel(
            const ScrumMasterDashboardDto(rawKpis: []),
          );
        }
        rethrow;
      }
    });
