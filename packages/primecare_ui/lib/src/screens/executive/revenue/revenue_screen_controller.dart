import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RevenueScreenState extends DashboardState<RevenueScreenState> {
  RevenueScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  RevenueScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => RevenueScreenState(isLoading: isLoading, error: error, data: data);
}

class RevenueScreenController
    extends BaseDashboardController<RevenueScreenState> {
  RevenueScreenController(Ref ref)
    : super(
        ref,
        initialState: RevenueScreenState(isLoading: true, data: {}),
        endpoint: '/executive/revenue',
      );
}

final revenueControllerProvider =
    StateNotifierProvider<RevenueScreenController, RevenueScreenState>((ref) {
      return RevenueScreenController(ref);
    });
