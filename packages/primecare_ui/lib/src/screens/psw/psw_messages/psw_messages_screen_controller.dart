import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MessagesState extends DashboardState<MessagesState> {
  MessagesState({required super.isLoading, super.error, required super.data});

  @override
  MessagesState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => MessagesState(isLoading: isLoading, error: error, data: data);
}

class MessagesController extends BaseDashboardController<MessagesState> {
  MessagesController(Ref ref)
    : super(
        ref,
        initialState: MessagesState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/psw/messages',
      );
}

final psw_messagesControllerProvider =
    StateNotifierProvider<MessagesController, MessagesState>((ref) {
      return MessagesController(ref);
    });
