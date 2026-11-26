import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CaregiverClientProfileScreenState
    extends DashboardState<CaregiverClientProfileScreenState> {
  CaregiverClientProfileScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CaregiverClientProfileScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CaregiverClientProfileScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CaregiverClientProfileScreenController
    extends BaseDashboardController<CaregiverClientProfileScreenState> {
  CaregiverClientProfileScreenController(Ref ref)
    : super(
        ref,
        initialState: CaregiverClientProfileScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/caregiver/client-profile',
      );
}

final caregiver_client_profileControllerProvider =
    StateNotifierProvider<
      CaregiverClientProfileScreenController,
      CaregiverClientProfileScreenState
    >((ref) {
      return CaregiverClientProfileScreenController(ref);
    });
