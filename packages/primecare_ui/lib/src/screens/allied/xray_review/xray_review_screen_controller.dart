import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class XrayReviewScreenState extends DashboardState<XrayReviewScreenState> {
  XrayReviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  XrayReviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => XrayReviewScreenState(isLoading: isLoading, error: error, data: data);
}

class XrayReviewScreenController
    extends BaseDashboardController<XrayReviewScreenState> {
  XrayReviewScreenController(Ref ref)
    : super(
        ref,
        initialState: XrayReviewScreenState(isLoading: true, data: {}),
        endpoint: '/offices/clinical/roles/chiropractor/xray-review',
      );
}

final xray_reviewControllerProvider =
    StateNotifierProvider<XrayReviewScreenController, XrayReviewScreenState>((
      ref,
    ) {
      return XrayReviewScreenController(ref);
    });
