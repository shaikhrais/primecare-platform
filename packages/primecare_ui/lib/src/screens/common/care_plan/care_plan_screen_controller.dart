import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CarePlanScreenState extends DashboardState<CarePlanScreenState> {
  CarePlanScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CarePlanScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CarePlanScreenState(isLoading: isLoading, error: error, data: data);
}

class CarePlanScreenController
    extends BaseDashboardController<CarePlanScreenState> {
  CarePlanScreenController(Ref ref)
    : super(
        ref,
        initialState: CarePlanScreenState(isLoading: true, data: {}),
        endpoint: '/clinic/care-plan',
      );
}

final care_planControllerProvider =
    StateNotifierProvider<CarePlanScreenController, CarePlanScreenState>((ref) {
      return CarePlanScreenController(ref);
    });
