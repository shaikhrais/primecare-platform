import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CfoRevenueScreenState extends DashboardState<CfoRevenueScreenState> {
  CfoRevenueScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CfoRevenueScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CfoRevenueScreenState(isLoading: isLoading, error: error, data: data);
}

class CfoRevenueScreenController
    extends BaseDashboardController<CfoRevenueScreenState> {
  CfoRevenueScreenController(Ref ref)
    : super(
        ref,
        initialState: CfoRevenueScreenState(isLoading: true, data: {}),
        endpoint: '/offices/corporate/roles/cfo/revenue',
      );
}

final cfo_revenueControllerProvider =
    StateNotifierProvider<CfoRevenueScreenController, CfoRevenueScreenState>((
      ref,
    ) {
      return CfoRevenueScreenController(ref);
    });
