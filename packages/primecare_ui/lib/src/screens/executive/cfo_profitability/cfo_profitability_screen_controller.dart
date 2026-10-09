import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoProfitabilityScreenState
    extends DashboardState<CfoProfitabilityScreenState> {
  CfoProfitabilityScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CfoProfitabilityScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CfoProfitabilityScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CfoProfitabilityScreenController
    extends BaseDashboardController<CfoProfitabilityScreenState> {
  CfoProfitabilityScreenController(Ref ref)
    : super(
        ref,
        initialState: CfoProfitabilityScreenState(isLoading: true, data: {}),
        endpoint: '/offices/corporate/roles/cfo/profitability',
      );
}

final cfo_profitabilityControllerProvider =
    StateNotifierProvider<
      CfoProfitabilityScreenController,
      CfoProfitabilityScreenState
    >((ref) {
      return CfoProfitabilityScreenController(ref);
    });
