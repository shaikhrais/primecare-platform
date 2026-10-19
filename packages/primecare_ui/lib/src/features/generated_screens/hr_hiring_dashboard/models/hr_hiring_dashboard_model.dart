import 'package:primecare_models/primecare_models.dart';

class HrHiringDashboardModel extends BaseScreenState<HrHiringDashboardModel> {
  const HrHiringDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrHiringDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrHiringDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
