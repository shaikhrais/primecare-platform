import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_core/controllers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HrDirectorStaffFilesScreenState
    extends DashboardState<HrDirectorStaffFilesScreenState> {
  HrDirectorStaffFilesScreenState({
    required super.isLoading,
    super.error,
    required super.data,
  });

  @override
  HrDirectorStaffFilesScreenState create({
    required bool isLoading,
    String? error,
    required Map<String, dynamic> data,
  }) => HrDirectorStaffFilesScreenState(
    isLoading: isLoading,
    error: error,
    data: data,
  );
}

class HrDirectorStaffFilesScreenController
    extends BaseDashboardController<HrDirectorStaffFilesScreenState> {
  HrDirectorStaffFilesScreenController(Ref ref)
    : super(
        ref,
        initialState: HrDirectorStaffFilesScreenState(
          isLoading: true,
          data: {},
        ),
        endpoint: '/executive/hr-director-staff-files',
      );
}

final hr_director_staff_filesControllerProvider =
    StateNotifierProvider<
      HrDirectorStaffFilesScreenController,
      HrDirectorStaffFilesScreenState
    >((ref) {
      return HrDirectorStaffFilesScreenController(ref);
    });
