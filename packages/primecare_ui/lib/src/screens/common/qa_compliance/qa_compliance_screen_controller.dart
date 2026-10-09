import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QaComplianceScreenState extends DashboardState<QaComplianceScreenState> {
  QaComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  QaComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => QaComplianceScreenState(isLoading: isLoading, error: error, data: data);
}

class QaComplianceScreenController
    extends BaseDashboardController<QaComplianceScreenState> {
  QaComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: QaComplianceScreenState(isLoading: true, data: {}),
        endpoint: '/common/qa-compliance',
      );
}

final qa_complianceControllerProvider =
    StateNotifierProvider<
      QaComplianceScreenController,
      QaComplianceScreenState
    >((ref) {
      return QaComplianceScreenController(ref);
    });
