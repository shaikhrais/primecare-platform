import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/config/data_source_mode.dart';
import 'package:flutter_core/config/api_config.dart';
import 'package:flutter_core/api_providers.dart';
import 'package:flutter_core/features/guest_dashboard/data/dtos/guest_dashboard_dto.dart';
import 'package:flutter_core/features/guest_dashboard/data/mappers/guest_dashboard_mapper.dart';
import 'package:flutter_core/features/guest_dashboard/domain/models/guest_dashboard_view_model.dart';

final guestDashboardAdapterProvider =
    FutureProvider.autoDispose<GuestDashboardViewModel>((ref) async {
      if (DataSourceConfig.currentMode == DataSourceType.mock) {
        return GuestDashboardMapper.toViewModel(
          const GuestDashboardDto(rawKpis: []),
        );
      }

      try {
        final apiClient = ref.read(apiClientProvider);
        final endpoint =
            ApiConfig.endpoints['providerMetrics'] ?? '/api/v1/metrics';
        final response = await apiClient.get(
          '$endpoint?route=CorporateRoutes.guestDashboard',
        );

        if (response.statusCode == 200) {
          final dto = GuestDashboardDto.fromJson(
            response.data as Map<String, dynamic>,
          );
          return GuestDashboardMapper.toViewModel(dto);
        } else {
          throw Exception(
            'Failed to load guest metrics: ${response.statusCode}',
          );
        }
      } catch (e) {
        if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
          return GuestDashboardMapper.toViewModel(
            const GuestDashboardDto(rawKpis: []),
          );
        }
        rethrow;
      }
    });
