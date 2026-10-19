import 'package:primecare_models/primecare_models.dart';

class PartnershipManagerWorkflowModel extends BaseScreenState<PartnershipManagerWorkflowModel> {
  const PartnershipManagerWorkflowModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PartnershipManagerWorkflowModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PartnershipManagerWorkflowModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
