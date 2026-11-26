import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorCredentialExpiryScreenState
    extends DashboardState<HrDirectorCredentialExpiryScreenState> {
  HrDirectorCredentialExpiryScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrDirectorCredentialExpiryScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrDirectorCredentialExpiryScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrDirectorCredentialExpiryScreenController
    extends BaseDashboardController<HrDirectorCredentialExpiryScreenState> {
  HrDirectorCredentialExpiryScreenController(Ref ref)
    : super(
        ref,
        initialState: HrDirectorCredentialExpiryScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/hr-director-credential-expiry',
      );
}

final hr_director_credential_expiryControllerProvider =
    StateNotifierProvider<
      HrDirectorCredentialExpiryScreenController,
      HrDirectorCredentialExpiryScreenState
    >((ref) {
      return HrDirectorCredentialExpiryScreenController(ref);
    });
