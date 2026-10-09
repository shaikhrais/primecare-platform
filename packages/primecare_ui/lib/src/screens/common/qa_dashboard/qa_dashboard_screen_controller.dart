import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QaDashboardScreenState extends DashboardState<QaDashboardScreenState> {
  QaDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  QaDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => QaDashboardScreenState(isLoading: isLoading, error: error, data: data);
}

class QaDashboardScreenController
    extends BaseDashboardController<QaDashboardScreenState> {
  QaDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: QaDashboardScreenState(isLoading: true, data: {}),
        endpoint: '/offices/support/roles/quality_assurance/dashboard',
      );
}

final qa_dashboardControllerProvider =
    StateNotifierProvider<QaDashboardScreenController, QaDashboardScreenState>((
      ref,
    ) {
      return QaDashboardScreenController(ref);
    });
