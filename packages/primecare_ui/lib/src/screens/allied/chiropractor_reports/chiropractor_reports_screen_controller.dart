import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorReportsScreenState
    extends DashboardState<ChiropractorReportsScreenState> {
  ChiropractorReportsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ChiropractorReportsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ChiropractorReportsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ChiropractorReportsScreenController
    extends BaseDashboardController<ChiropractorReportsScreenState> {
  ChiropractorReportsScreenController(Ref ref)
    : super(
        ref,
        initialState: ChiropractorReportsScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/chiropractor/reports',
      );
}

final chiropractor_reportsControllerProvider =
    StateNotifierProvider<
      ChiropractorReportsScreenController,
      ChiropractorReportsScreenState
    >((ref) {
      return ChiropractorReportsScreenController(ref);
    });
