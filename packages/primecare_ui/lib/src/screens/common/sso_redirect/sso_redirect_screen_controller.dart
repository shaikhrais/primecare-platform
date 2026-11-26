import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SsoRedirectScreenState extends DashboardState<SsoRedirectScreenState> {
  SsoRedirectScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  SsoRedirectScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => SsoRedirectScreenState(isLoading: isLoading, error: error, data: data);
}

class SsoRedirectScreenController
    extends BaseDashboardController<SsoRedirectScreenState> {
  SsoRedirectScreenController(Ref ref)
    : super(
        ref,
        initialState: SsoRedirectScreenState(isLoading: true, data: {}),
        endpoint: '/generated/sso-redirect',
      );
}

final sso_redirectControllerProvider =
    StateNotifierProvider<SsoRedirectScreenController, SsoRedirectScreenState>((
      ref,
    ) {
      return SsoRedirectScreenController(ref);
    });
