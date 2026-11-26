import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmergencyContactsScreenState
    extends DashboardState<EmergencyContactsScreenState> {
  EmergencyContactsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  EmergencyContactsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => EmergencyContactsScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class EmergencyContactsScreenController
    extends BaseDashboardController<EmergencyContactsScreenState> {
  EmergencyContactsScreenController(Ref ref)
    : super(
        ref,
        initialState: EmergencyContactsScreenState(isLoading: true, data: {}),
        endpoint: '/common/emergency-contacts',
      );
}

final emergency_contactsControllerProvider =
    StateNotifierProvider<
      EmergencyContactsScreenController,
      EmergencyContactsScreenState
    >((ref) {
      return EmergencyContactsScreenController(ref);
    });
