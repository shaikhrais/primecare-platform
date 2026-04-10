import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../config/data_source_mode.dart';
import '../../../../config/api_config.dart';
import '../../../../api_providers.dart';
import '../dtos/training_coordinator_dashboard_dto.dart';
import '../mappers/training_coordinator_dashboard_mapper.dart';
import '../../domain/models/training_coordinator_dashboard_view_model.dart';

final trainingCoordinatorDashboardAdapterProvider = FutureProvider.autoDispose<TrainingCoordinatorDashboardViewModel>((ref) async {
  if (DataSourceConfig.currentMode == DataSourceType.mock) {
    return TrainingCoordinatorDashboardMapper.toViewModel(
      const TrainingCoordinatorDashboardDto(rawKpis: []),
    );
  }

  try {
    final apiClient = ref.read(apiClientProvider);
    final endpoint = ApiConfig.endpoints['providerMetrics'] ?? '/api/v1/metrics';
    final response = await apiClient.get('$endpoint?route=CorporateRoutes.trainingCoordinatorDashboard');
    
    if (response.statusCode == 200) {
      final dto = TrainingCoordinatorDashboardDto.fromJson(response.data as Map<String, dynamic>);
      return TrainingCoordinatorDashboardMapper.toViewModel(dto);
    } else {
      throw Exception('Failed to load Training Coordinator metrics: ${response.statusCode}');
    }
  } catch (e) {
    if (DataSourceConfig.currentMode == DataSourceType.hybrid) {
      return TrainingCoordinatorDashboardMapper.toViewModel(
        const TrainingCoordinatorDashboardDto(rawKpis: []),
      );
    }
    rethrow;
  }
});
