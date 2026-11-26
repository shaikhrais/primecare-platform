import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PrimeCareScreenState extends DashboardState<PrimeCareScreenState> {
  PrimeCareScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  PrimeCareScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => PrimeCareScreenState(isLoading: isLoading, error: error, data: data);
}

class PrimeCareScreenController
    extends BaseDashboardController<PrimeCareScreenState> {
  PrimeCareScreenController(Ref ref)
    : super(
        ref,
        initialState: PrimeCareScreenState(isLoading: true, data: {}),
        endpoint: '/generated/prime-care',
      );
}

final prime_careControllerProvider =
    StateNotifierProvider<PrimeCareScreenController, PrimeCareScreenState>((
      ref,
    ) {
      return PrimeCareScreenController(ref);
    });
