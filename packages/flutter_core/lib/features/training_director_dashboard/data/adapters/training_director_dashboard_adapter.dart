import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/data_source_mode.dart';
import '../../../../config/api_config.dart';
import '../../../../api_providers.dart';
import '../dtos/training_director_dashboard_dto.dart';
import '../mappers/training_director_dashboard_mapper.dart';
import '../../domain/models/training_director_dashboard_view_model.dart';

final trainingDirectorDashboardAdapterProvider =
    FutureProvider.autoDispose<TrainingDirectorDashboardViewModel>((ref) async {
      if (DataSourceConfig.currentMode == DataSourceType.mock) {
        return TrainingDirectorDashboardMapper.toViewModel(
          const TrainingDirectorDashboardDto(rawKpis: []),
        );
      }

      try {
        final apiClient = ref.read(apiClientProvider);
        final endpoint =
            ApiConfig.endpoints['providerMetrics'] ?? '/api/v1/metrics';
        final response = await apiClient.get(
          '$endpoint?route=CorporateRoutes.trainingDirectorDashboard',
        );

        if (response.statusCode == 200) {
          final dto = TrainingDirectorDashboardDto.fromJson(
            response.data as Map<String, dynamic>,
          );
          return TrainingDirectorDashboardMapper.toViewModel(dto);
        } else {
          throw Exception(
            'Failed to load training director metrics: ${response.statusCode}',
          );
        }
      } catch (e) {
        if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
          return TrainingDirectorDashboardMapper.toViewModel(
            const TrainingDirectorDashboardDto(rawKpis: []),
          );
        }
        rethrow;
      }
    });
