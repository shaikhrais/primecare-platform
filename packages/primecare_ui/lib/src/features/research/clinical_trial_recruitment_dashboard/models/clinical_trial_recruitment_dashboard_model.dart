import 'package:primecare_models/primecare_models.dart';

class ClinicalTrialRecruitmentDashboardModel extends BaseScreenState<ClinicalTrialRecruitmentDashboardModel> {
  const ClinicalTrialRecruitmentDashboardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalTrialRecruitmentDashboardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalTrialRecruitmentDashboardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
