import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagingScreenState extends DashboardState<MessagingScreenState> {
  MessagingScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  MessagingScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => MessagingScreenState(isLoading: isLoading, error: error, data: data);
}

class MessagingScreenController
    extends BaseDashboardController<MessagingScreenState> {
  MessagingScreenController(Ref ref)
    : super(
        ref,
        initialState: MessagingScreenState(isLoading: true, data: {}),
        endpoint: '/clinic/messaging',
      );
}

final messagingControllerProvider =
    StateNotifierProvider<MessagingScreenController, MessagingScreenState>((
      ref,
    ) {
      return MessagingScreenController(ref);
    });
