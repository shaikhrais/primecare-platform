import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChiropractorClientIntakeScreenState
    extends DashboardState<ChiropractorClientIntakeScreenState> {
  ChiropractorClientIntakeScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ChiropractorClientIntakeScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ChiropractorClientIntakeScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ChiropractorClientIntakeScreenController
    extends BaseDashboardController<ChiropractorClientIntakeScreenState> {
  ChiropractorClientIntakeScreenController(Ref ref)
    : super(
        ref,
        initialState: ChiropractorClientIntakeScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/offices/clinical/roles/chiropractor/client-intake',
      );
}

final chiropractor_client_intakeControllerProvider =
    StateNotifierProvider<
      ChiropractorClientIntakeScreenController,
      ChiropractorClientIntakeScreenState
    >((ref) {
      return ChiropractorClientIntakeScreenController(ref);
    });
