import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FileVerificationDashboardScreenState
    extends DashboardState<FileVerificationDashboardScreenState> {
  FileVerificationDashboardScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  FileVerificationDashboardScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => FileVerificationDashboardScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class FileVerificationDashboardScreenController
    extends BaseDashboardController<FileVerificationDashboardScreenState> {
  FileVerificationDashboardScreenController(Ref ref)
    : super(
        ref,
        initialState: FileVerificationDashboardScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/common/file-verification-dashboard',
      );
}

final file_verification_dashboardControllerProvider =
    StateNotifierProvider<
      FileVerificationDashboardScreenController,
      FileVerificationDashboardScreenState
    >((ref) {
      return FileVerificationDashboardScreenController(ref);
    });
