import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PswCarePlanScreenState extends DashboardState<PswCarePlanScreenState> {
  PswCarePlanScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PswCarePlanScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PswCarePlanScreenState(isLoading: isLoading, error: error, data: data);
}

class PswCarePlanScreenController
    extends BaseDashboardController<PswCarePlanScreenState> {
  PswCarePlanScreenController(Ref ref)
    : super(
        ref,
        initialState: PswCarePlanScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/care-plan',
      );
}

final psw_care_planControllerProvider =
    StateNotifierProvider<PswCarePlanScreenController, PswCarePlanScreenState>((
      ref,
    ) {
      return PswCarePlanScreenController(ref);
    });
