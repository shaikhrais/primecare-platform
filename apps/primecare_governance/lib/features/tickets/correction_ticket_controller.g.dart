// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'correction_ticket_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CorrectionTicketController)
final correctionTicketControllerProvider =
    CorrectionTicketControllerProvider._();

final class CorrectionTicketControllerProvider
    extends
        $NotifierProvider<CorrectionTicketController, List<CorrectionTicket>> {
  CorrectionTicketControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'correctionTicketControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$correctionTicketControllerHash();

  @$internal
  @override
  CorrectionTicketController create() => CorrectionTicketController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<CorrectionTicket> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<CorrectionTicket>>(value),
    );
  }
}

String _$correctionTicketControllerHash() =>
    r'3d43ba6beaa2294109f13fc26fcf7c4be78ed2a4';

abstract class _$CorrectionTicketController
    extends $Notifier<List<CorrectionTicket>> {
  List<CorrectionTicket> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<List<CorrectionTicket>, List<CorrectionTicket>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<CorrectionTicket>, List<CorrectionTicket>>,
              List<CorrectionTicket>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
