import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoTaxScreenState extends DashboardState<CfoTaxScreenState> {
  CfoTaxScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CfoTaxScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CfoTaxScreenState(isLoading: isLoading, error: error, data: data);
}

class CfoTaxScreenController
    extends BaseDashboardController<CfoTaxScreenState> {
  CfoTaxScreenController(Ref ref)
    : super(
        ref,
        initialState: CfoTaxScreenState(isLoading: true, data: {}),
        endpoint: '/executive/cfo-tax',
      );
}

final cfo_taxControllerProvider =
    StateNotifierProvider<CfoTaxScreenController, CfoTaxScreenState>((ref) {
      return CfoTaxScreenController(ref);
    });
