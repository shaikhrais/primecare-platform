import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HeadOfBusDevComplianceScreenState
    extends DashboardState<HeadOfBusDevComplianceScreenState> {
  HeadOfBusDevComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HeadOfBusDevComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HeadOfBusDevComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HeadOfBusDevComplianceScreenController
    extends BaseDashboardController<HeadOfBusDevComplianceScreenState> {
  HeadOfBusDevComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: HeadOfBusDevComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/management/head-of-bus-dev-compliance',
      );
}

final head_of_bus_dev_complianceControllerProvider =
    StateNotifierProvider<
      HeadOfBusDevComplianceScreenController,
      HeadOfBusDevComplianceScreenState
    >((ref) {
      return HeadOfBusDevComplianceScreenController(ref);
    });
