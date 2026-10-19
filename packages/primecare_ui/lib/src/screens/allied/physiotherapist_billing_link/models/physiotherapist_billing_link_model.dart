import 'package:primecare_models/primecare_models.dart';

class PhysiotherapistBillingLinkModel extends BaseScreenState<PhysiotherapistBillingLinkModel> {
  const PhysiotherapistBillingLinkModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PhysiotherapistBillingLinkModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PhysiotherapistBillingLinkModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
