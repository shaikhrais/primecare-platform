import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ServiceQualityScreenState
    extends DashboardState<ServiceQualityScreenState> {
  ServiceQualityScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ServiceQualityScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      ServiceQualityScreenState(isLoading: isLoading, error: error, data: data);
}

class ServiceQualityScreenController
    extends BaseDashboardController<ServiceQualityScreenState> {
  ServiceQualityScreenController(Ref ref)
    : super(
        ref,
        initialState: ServiceQualityScreenState(isLoading: true, data: {}),
        endpoint: '/executive/service-quality',
      );
}

final service_qualityControllerProvider =
    StateNotifierProvider<
      ServiceQualityScreenController,
      ServiceQualityScreenState
    >((ref) {
      return ServiceQualityScreenController(ref);
    });
