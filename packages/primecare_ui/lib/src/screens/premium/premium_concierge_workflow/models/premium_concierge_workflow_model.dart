import 'package:primecare_models/primecare_models.dart';

class PremiumConciergeWorkflowModel extends BaseScreenState<PremiumConciergeWorkflowModel> {
  const PremiumConciergeWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PremiumConciergeWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PremiumConciergeWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
