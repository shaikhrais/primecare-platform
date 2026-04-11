import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/config/data_source_mode.dart';
import 'package:flutter_core/config/api_config.dart';
import 'package:flutter_core/api_providers.dart';
import 'package:flutter_core/features/qa_dashboard/data/dtos/qa_dashboard_dto.dart';
import 'package:flutter_core/features/qa_dashboard/data/mappers/qa_dashboard_mapper.dart';
import 'package:flutter_core/features/qa_dashboard/domain/models/qa_dashboard_view_model.dart';

final qaDashboardAdapterProvider =
    FutureProvider.autoDispose<QaDashboardViewModel>((ref) async {
      if (DataSourceConfig.currentMode == DataSourceType.mock) {
        return QaDashboardMapper.toViewModel(const QaDashboardDto(rawKpis: []));
      }

      try {
        final apiClient = ref.read(apiClientProvider);
        final endpoint =
            ApiConfig.endpoints['providerMetrics'] ?? '/api/v1/metrics';
        final response = await apiClient.get(
          '$endpoint?route=CorporateRoutes.qaDashboard',
        );

        if (response.statusCode == 200) {
          final dto = QaDashboardDto.fromJson(
            response.data as Map<String, dynamic>,
          );
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
