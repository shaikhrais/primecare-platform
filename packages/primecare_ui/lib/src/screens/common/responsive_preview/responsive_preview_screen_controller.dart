import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResponsivePreviewScreenState
    extends DashboardState<ResponsivePreviewScreenState> {
  ResponsivePreviewScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  ResponsivePreviewScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => ResponsivePreviewScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class ResponsivePreviewScreenController
    extends BaseDashboardController<ResponsivePreviewScreenState> {
  ResponsivePreviewScreenController(Ref ref)
    : super(
        ref,
        initialState: ResponsivePreviewScreenState(isLoading: true, data: {}),
        endpoint: '/common/responsive-preview',
      );
}

final responsive_previewControllerProvider =
    StateNotifierProvider<
      ResponsivePreviewScreenController,
      ResponsivePreviewScreenState
    >((ref) {
      return ResponsivePreviewScreenController(ref);
    });
