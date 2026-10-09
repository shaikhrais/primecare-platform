import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QaAnalyticsScreenState extends DashboardState<QaAnalyticsScreenState> {
  QaAnalyticsScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  QaAnalyticsScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => QaAnalyticsScreenState(isLoading: isLoading, error: error, data: data);
}

class QaAnalyticsScreenController
    extends BaseDashboardController<QaAnalyticsScreenState> {
  QaAnalyticsScreenController(Ref ref)
    : super(
        ref,
        initialState: QaAnalyticsScreenState(isLoading: true, data: {}),
        endpoint: '/common/qa-analytics',
      );
}

final qa_analyticsControllerProvider =
    StateNotifierProvider<QaAnalyticsScreenController, QaAnalyticsScreenState>((
      ref,
    ) {
      return QaAnalyticsScreenController(ref);
    });
