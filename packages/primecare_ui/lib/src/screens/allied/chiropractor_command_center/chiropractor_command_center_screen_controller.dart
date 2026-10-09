import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorCommandCenterScreenState
    extends DashboardState<ChiropractorCommandCenterScreenState> {
  ChiropractorCommandCenterScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ChiropractorCommandCenterScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ChiropractorCommandCenterScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ChiropractorCommandCenterScreenController
    extends BaseDashboardController<ChiropractorCommandCenterScreenState> {
  ChiropractorCommandCenterScreenController(Ref ref)
    : super(
        ref,
        initialState: ChiropractorCommandCenterScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/chiropractor/command-center',
      );
}

final chiropractor_command_centerControllerProvider =
    StateNotifierProvider<
      ChiropractorCommandCenterScreenController,
      ChiropractorCommandCenterScreenState
    >((ref) {
      return ChiropractorCommandCenterScreenController(ref);
    });
