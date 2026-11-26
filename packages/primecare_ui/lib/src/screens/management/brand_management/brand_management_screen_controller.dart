import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BrandManagementScreenState
    extends DashboardState<BrandManagementScreenState> {
  BrandManagementScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  BrandManagementScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => BrandManagementScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class BrandManagementScreenController
    extends BaseDashboardController<BrandManagementScreenState> {
  BrandManagementScreenController(Ref ref)
    : super(
        ref,
        initialState: BrandManagementScreenState(isLoading: true, data: {}),
        endpoint: '/management/brand-management',
      );
}

final brand_managementControllerProvider =
    StateNotifierProvider<
      BrandManagementScreenController,
      BrandManagementScreenState
    >((ref) {
      return BrandManagementScreenController(ref);
    });
