import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class IntakeCoordinatorDocumentsScreenState
    extends DashboardState<IntakeCoordinatorDocumentsScreenState> {
  IntakeCoordinatorDocumentsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  IntakeCoordinatorDocumentsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorDocumentsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class IntakeCoordinatorDocumentsScreenController
    extends BaseDashboardController<IntakeCoordinatorDocumentsScreenState> {
  IntakeCoordinatorDocumentsScreenController(Ref ref)
    : super(
        ref,
        initialState: IntakeCoordinatorDocumentsScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/intake-coordinator-documents',
      );
}

final intake_coordinator_documentsControllerProvider =
    StateNotifierProvider<
      IntakeCoordinatorDocumentsScreenController,
      IntakeCoordinatorDocumentsScreenState
    >((ref) {
      return IntakeCoordinatorDocumentsScreenController(ref);
    });
