import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AdjustmentNotesScreenState
    extends DashboardState<AdjustmentNotesScreenState> {
  AdjustmentNotesScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  AdjustmentNotesScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => AdjustmentNotesScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class AdjustmentNotesScreenController
    extends BaseDashboardController<AdjustmentNotesScreenState> {
  AdjustmentNotesScreenController(Ref ref)
    : super(
        ref,
        initialState: AdjustmentNotesScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/chiropractor/adjustment-notes',
      );
}

final adjustment_notesControllerProvider =
    StateNotifierProvider<
      AdjustmentNotesScreenController,
      AdjustmentNotesScreenState
    >((ref) {
      return AdjustmentNotesScreenController(ref);
    });
