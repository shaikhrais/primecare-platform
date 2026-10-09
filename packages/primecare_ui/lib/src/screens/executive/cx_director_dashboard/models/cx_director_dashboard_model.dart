import 'package:primecare_models/primecare_models.dart';

class CxDirectorDashboardModel extends BaseScreenState<CxDirectorDashboardModel> {
  const CxDirectorDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CxDirectorDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CxDirectorDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
