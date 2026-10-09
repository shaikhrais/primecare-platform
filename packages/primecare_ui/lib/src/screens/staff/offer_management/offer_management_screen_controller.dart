import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfferManagementScreenState
    extends DashboardState<OfferManagementScreenState> {
  OfferManagementScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  OfferManagementScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => OfferManagementScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class OfferManagementScreenController
    extends BaseDashboardController<OfferManagementScreenState> {
  OfferManagementScreenController(Ref ref)
    : super(
        ref,
        initialState: OfferManagementScreenState(isLoading: true, data: {}),
        endpoint: '/staff/offer-management',
      );
}

final offer_managementControllerProvider =
    StateNotifierProvider<
      OfferManagementScreenController,
      OfferManagementScreenState
    >((ref) {
      return OfferManagementScreenController(ref);
    });
