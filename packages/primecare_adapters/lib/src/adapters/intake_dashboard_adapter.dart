import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../config/data_source_mode.dart';
import '../config/api_config.dart';
import '../api_providers.dart';
import 'package:flutter_core/features/intake_dashboard/data/dtos/intake_dashboard_dto.dart';
import 'package:flutter_core/features/intake_dashboard/data/mappers/intake_dashboard_mapper.dart';
import 'package:flutter_core/features/intake_dashboard/domain/models/intake_dashboard_view_model.dart';

final intakeDashboardAdapterProvider =
    FutureProvider.autoDispose<IntakeDashboardViewModel>((ref) async {
      if (DataSourceConfig.currentMode == DataSourceType.mock) {
        return IntakeDashboardMapper.toViewModel(
          const IntakeDashboardDto(rawKpis: []),
        );
      }

      try {
        final apiClient = ref.read(apiClientProvider);
        final endpoint =
            ApiConfig.endpoints['providerMetrics'] ?? '/api/v1/metrics';
        final response = await apiClient.get(
          '$endpoint?route=CorporateRoutes.intakeDashboard',
        );

        if (response.statusCode == 200) {
          final dto = IntakeDashboardDto.fromJson(
            response.data as Map<String, dynamic>,
          );
          return IntakeDashboardMapper.toViewModel(dto);
        } else {
          throw Exception(
            'Failed to load Intake metrics: ${response.statusCode}',
          );
        }
      } catch (e) {
        if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
          return IntakeDashboardMapper.toViewModel(
            const IntakeDashboardDto(rawKpis: []),
          );
        }
        rethrow;
      }
    });
