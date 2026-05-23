// Governance - Category: controller | Purpose: GENERATED CODE - DO NOT MODIFY BY HAND ************************************************************************** Riv...
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'role_impersonation_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RoleImpersonation)
final roleImpersonationProvider = RoleImpersonationProvider._();

final class RoleImpersonationProvider
    extends $NotifierProvider<RoleImpersonation, String?> {
  RoleImpersonationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'roleImpersonationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$roleImpersonationHash();

  @$internal
  @override
  RoleImpersonation create() => RoleImpersonation();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$roleImpersonationHash() => r'd7c0d7118d7fc5a5b5013f89b1812e63cb667b0a';

abstract class _$RoleImpersonation extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
