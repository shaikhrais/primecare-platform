import 'package:primecare_models/primecare_models.dart';

class VaccinationCampaignManagerModel extends BaseScreenState<VaccinationCampaignManagerModel> {
  const VaccinationCampaignManagerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  VaccinationCampaignManagerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => VaccinationCampaignManagerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
