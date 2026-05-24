// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket_center_screen_controller_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TicketCenterScreenControllerController)
final ticketCenterScreenControllerControllerProvider =
    TicketCenterScreenControllerControllerProvider._();

final class TicketCenterScreenControllerControllerProvider
    extends
        $AsyncNotifierProvider<
          TicketCenterScreenControllerController,
          Map<String, dynamic>
        > {
  TicketCenterScreenControllerControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ticketCenterScreenControllerControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() =>
      _$ticketCenterScreenControllerControllerHash();

  @$internal
  @override
  TicketCenterScreenControllerController create() =>
      TicketCenterScreenControllerController();
}

String _$ticketCenterScreenControllerControllerHash() =>
    r'82e9f73bc218f69bbecfc82c408769cae5ac63ab';

abstract class _$TicketCenterScreenControllerController
    extends $AsyncNotifier<Map<String, dynamic>> {
  FutureOr<Map<String, dynamic>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<Map<String, dynamic>>, Map<String, dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<Map<String, dynamic>>,
                Map<String, dynamic>
              >,
              AsyncValue<Map<String, dynamic>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
