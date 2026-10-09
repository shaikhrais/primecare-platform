import 'package:primecare_models/primecare_models.dart';

class RegionalBdmDashboardModel extends BaseScreenState<RegionalBdmDashboardModel> {
  const RegionalBdmDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RegionalBdmDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RegionalBdmDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
