import 'package:primecare_models/primecare_models.dart';

class HrDirectorDashboardModel extends BaseScreenState<HrDirectorDashboardModel> {
  const HrDirectorDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrDirectorDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrDirectorDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
