import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CxDirectorComplianceScreenState
    extends DashboardState<CxDirectorComplianceScreenState> {
  CxDirectorComplianceScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CxDirectorComplianceScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => CxDirectorComplianceScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class CxDirectorComplianceScreenController
    extends BaseDashboardController<CxDirectorComplianceScreenState> {
  CxDirectorComplianceScreenController(Ref ref)
    : super(
        ref,
        initialState: CxDirectorComplianceScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/cx-director-compliance',
      );
}

final cx_director_complianceControllerProvider =
    StateNotifierProvider<
      CxDirectorComplianceScreenController,
      CxDirectorComplianceScreenState
    >((ref) {
      return CxDirectorComplianceScreenController(ref);
    });
