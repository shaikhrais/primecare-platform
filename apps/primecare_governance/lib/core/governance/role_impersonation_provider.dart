import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'role_impersonation_provider.g.dart';

@riverpod
class RoleImpersonation extends _$RoleImpersonation {
  @override
  String? build() {
    return null;
  }

  void impersonate(String? role) {
    state = role;
  }
}
