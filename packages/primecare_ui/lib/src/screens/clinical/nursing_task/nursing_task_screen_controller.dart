import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NursingTaskScreenState extends DashboardState<NursingTaskScreenState> {
  NursingTaskScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  NursingTaskScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => NursingTaskScreenState(isLoading: isLoading, error: error, data: data);
}

class NursingTaskScreenController
    extends BaseDashboardController<NursingTaskScreenState> {
  NursingTaskScreenController(Ref ref)
    : super(
        ref,
        initialState: NursingTaskScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/rpn/nursing-task',
      );
}

final nursing_taskControllerProvider =
    StateNotifierProvider<NursingTaskScreenController, NursingTaskScreenState>((
      ref,
    ) {
      return NursingTaskScreenController(ref);
    });
