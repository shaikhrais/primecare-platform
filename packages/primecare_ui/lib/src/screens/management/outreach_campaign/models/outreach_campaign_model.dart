import 'package:primecare_models/primecare_models.dart';

class OutreachCampaignModel extends BaseScreenState<OutreachCampaignModel> {
  const OutreachCampaignModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OutreachCampaignModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OutreachCampaignModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
