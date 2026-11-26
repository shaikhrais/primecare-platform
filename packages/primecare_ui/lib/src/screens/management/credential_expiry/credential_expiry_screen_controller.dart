import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CredentialExpiryScreenState
    extends DashboardState<CredentialExpiryScreenState> {
  CredentialExpiryScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CredentialExpiryScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CredentialExpiryScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CredentialExpiryScreenController
    extends BaseDashboardController<CredentialExpiryScreenState> {
  CredentialExpiryScreenController(Ref ref)
    : super(
        ref,
        initialState: CredentialExpiryScreenState(isLoading: true, data: {}),
        endpoint: '/management/credential-expiry',
      );
}

final credential_expiryControllerProvider =
    StateNotifierProvider<
      CredentialExpiryScreenController,
      CredentialExpiryScreenState
    >((ref) {
      return CredentialExpiryScreenController(ref);
    });
