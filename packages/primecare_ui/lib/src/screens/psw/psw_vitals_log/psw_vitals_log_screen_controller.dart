import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VitalsEntryScreenState extends DashboardState<VitalsEntryScreenState> {
  VitalsEntryScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  VitalsEntryScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => VitalsEntryScreenState(isLoading: isLoading, error: error, data: data);
}

class VitalsEntryScreenController
    extends BaseDashboardController<VitalsEntryScreenState> {
  VitalsEntryScreenController(Ref ref)
    : super(
        ref,
        initialState: VitalsEntryScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/observation-vitals-log',
      );
}

final psw_vitals_logControllerProvider =
    StateNotifierProvider<VitalsEntryScreenController, VitalsEntryScreenState>((
      ref,
    ) {
      return VitalsEntryScreenController(ref);
    });
