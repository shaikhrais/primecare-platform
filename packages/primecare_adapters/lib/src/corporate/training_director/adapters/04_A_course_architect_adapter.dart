// Layer: 04_ADAPTERS
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/01_I_dashboard_providers.dart';
import '../../../infrastructure/01_I_telemetry_service.dart';
import '../../../infrastructure/01_I_result.dart';
import '../../../models/roles/03_V_course_architect_view_model.dart';
import '../../../models/corporate/02_M_training_models.dart';
import '../../../models/02_M_dashboard_view_model.dart';
import '../../../models/core/02_M_dashboard_models.dart';

final courseArchitectAdapterProvider =
    FutureProvider<Result<PrimeCareDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);
      final modulesResult = await ref.watch(trainingModulesProvider.future);

      return modulesResult.fold(
        (modulesList) {
          final viewModel = CourseArchitectViewModel(
            availableModules: modulesList
                .map((e) => TrainingModuleModel.fromJson(e))
                .toList(),
            metrics: DashboardMetrics.empty(),
            insights: const [],
          );

          telemetry.passGate(
            ExecutionGateCategory.compliance,
            'Course Architect Hydrated',
            metadata: {'module_count': viewModel.availableModules.length},
          );

          return Result.success(viewModel);
        },
        (error) {
          telemetry.failGate(
            ExecutionGateCategory.compliance,
            'Course Architect Module Load Failed',
            error: error,
          );
          return Result.failure(error);
        },
      );
    });
