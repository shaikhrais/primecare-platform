import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/config/data_source_mode.dart';
import 'package:flutter_core/config/api_config.dart';
import 'package:flutter_core/api_providers.dart';
import 'package:flutter_core/features/support_dashboard/data/dtos/support_dashboard_dto.dart';
import 'package:flutter_core/features/support_dashboard/data/mappers/support_dashboard_mapper.dart';
import 'package:flutter_core/features/support_dashboard/domain/models/support_dashboard_view_model.dart';

final supportDashboardAdapterProvider =
    FutureProvider.autoDispose<SupportDashboardViewModel>((ref) async {
      if (DataSourceConfig.currentMode == DataSourceType.mock) {
        return SupportDashboardMapper.toViewModel(
          const SupportDashboardDto(rawKpis: []),
        );
      }

      try {
        final apiClient = ref.read(apiClientProvider);
        final endpoint =
            ApiConfig.endpoints['providerMetrics'] ?? '/api/v1/metrics';
        final response = await apiClient.get(
          '$endpoint?route=CorporateRoutes.supportDashboard',
        );

        if (response.statusCode == 200) {
          final dto = SupportDashboardDto.fromJson(
            response.data as Map<String, dynamic>,
          );
          return SupportDashboardMapper.toViewModel(dto);
        } else {
          throw Exception(
            'Failed to load Support metrics: ${response.statusCode}',
          );
        }
      } catch (e) {
        if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
          return SupportDashboardMapper.toViewModel(
            const SupportDashboardDto(rawKpis: []),
          );
        }
        rethrow;
      }
    });
