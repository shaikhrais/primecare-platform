import 'package:primecare_models/primecare_models.dart';

class ClinicalDirectorDashboardModel extends BaseScreenState<ClinicalDirectorDashboardModel> {
  const ClinicalDirectorDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalDirectorDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalDirectorDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
