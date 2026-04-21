// Layer: 04_ADAPTERS
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../infrastructure/01_I_dashboard_providers.dart';
import '../../../infrastructure/01_I_telemetry_service.dart';
import '../../../infrastructure/01_I_result.dart';
import '../../../models/roles/03_V_training_hub_view_model.dart';
import '../../../models/corporate/02_M_training_models.dart';
import '../../../models/02_M_dashboard_view_model.dart';
import '../../../models/core/02_M_dashboard_models.dart';

final trainingHubAdapterProvider =
    FutureProvider<Result<PrimeCareDashboardViewModel>>((ref) async {
      final telemetry = ref.read(executionGateProvider);

      final curriculaResult = await ref.watch(trainingCurriculaProvider.future);
      final certsResult = await ref.watch(
        trainingCertificationsProvider.future,
      );

      return curriculaResult.fold(
        (curriculaList) {
          return certsResult.fold(
            (certsList) {
              final viewModel = TrainingHubViewModel(
                curricula: curriculaList
                    .map((e) => CurriculumModel.fromJson(e))
                    .toList(),
                certifications: certsList
                    .map((e) => CertificationModel.fromJson(e))
                    .toList(),
                metrics: DashboardMetrics.empty(),
                insights: const [],
              );

              telemetry.passGate(
                ExecutionGateCategory.compliance,
                'Training Hub Hydrated',
                metadata: {
                  'curricula_count': viewModel.curricula.length,
                  'certs_count': viewModel.certifications.length,
                },
              );

              return Result.success(viewModel);
            },
            (error) {
              telemetry.failGate(
                ExecutionGateCategory.compliance,
                'Training Hub Certification Load Failed',
                error: error,
              );
              return Result.failure(error);
            },
          );
        },
        (error) {
          telemetry.failGate(
            ExecutionGateCategory.compliance,
            'Training Hub Curricula Load Failed',
            error: error,
          );
          return Result.failure(error);
        },
      );
    });
