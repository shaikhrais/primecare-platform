import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ClientIssueScreenState extends DashboardState<ClientIssueScreenState> {
  ClientIssueScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ClientIssueScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ClientIssueScreenState(isLoading: isLoading, error: error, data: data);
}

class ClientIssueScreenController
    extends BaseDashboardController<ClientIssueScreenState> {
  ClientIssueScreenController(Ref ref)
    : super(
        ref,
        initialState: ClientIssueScreenState(isLoading: true, data: {}),
        endpoint: '/staff/client-issue',
      );
}

final client_issueControllerProvider =
    StateNotifierProvider<ClientIssueScreenController, ClientIssueScreenState>((
      ref,
    ) {
      return ClientIssueScreenController(ref);
    });
