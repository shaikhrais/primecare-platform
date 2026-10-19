import 'package:primecare_models/primecare_models.dart';

class VolunteerCoordinatorComplianceModel extends BaseScreenState<VolunteerCoordinatorComplianceModel> {
  const VolunteerCoordinatorComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  VolunteerCoordinatorComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => VolunteerCoordinatorComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
