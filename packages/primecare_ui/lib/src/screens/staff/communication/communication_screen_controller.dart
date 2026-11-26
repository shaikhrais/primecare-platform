import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CommunicationScreenState
    extends DashboardState<CommunicationScreenState> {
  CommunicationScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  CommunicationScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) =>
      CommunicationScreenState(isLoading: isLoading, error: error, data: data);
}

class CommunicationScreenController
    extends BaseDashboardController<CommunicationScreenState> {
  CommunicationScreenController(Ref ref)
    : super(
        ref,
        initialState: CommunicationScreenState(isLoading: true, data: {}),
        endpoint: '/staff/communication',
      );
}

final communicationControllerProvider =
    StateNotifierProvider<
      CommunicationScreenController,
      CommunicationScreenState
    >((ref) {
      return CommunicationScreenController(ref);
    });
