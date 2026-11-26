import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CareUpdatesScreenState extends DashboardState<CareUpdatesScreenState> {
  CareUpdatesScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CareUpdatesScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CareUpdatesScreenState(isLoading: isLoading, error: error, data: data);
}

class CareUpdatesScreenController
    extends BaseDashboardController<CareUpdatesScreenState> {
  CareUpdatesScreenController(Ref ref)
    : super(
        ref,
        initialState: CareUpdatesScreenState(isLoading: true, data: {}),
        endpoint: '/common/care-updates',
      );
}

final care_updatesControllerProvider =
    StateNotifierProvider<CareUpdatesScreenController, CareUpdatesScreenState>((
      ref,
    ) {
      return CareUpdatesScreenController(ref);
    });
