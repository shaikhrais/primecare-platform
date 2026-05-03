// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intake_module_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(IntakeModule)
final intakeModuleProvider = IntakeModuleProvider._();

final class IntakeModuleProvider
    extends $NotifierProvider<IntakeModule, IntakeState> {
  IntakeModuleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'intakeModuleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$intakeModuleHash();

  @$internal
  @override
  IntakeModule create() => IntakeModule();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(IntakeState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<IntakeState>(value),
    );
  }
}

String _$intakeModuleHash() => r'b76563375bcb059a2b478f58ec01e9c0552401c7';

abstract class _$IntakeModule extends $Notifier<IntakeState> {
  IntakeState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<IntakeState, IntakeState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<IntakeState, IntakeState>,
              IntakeState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
