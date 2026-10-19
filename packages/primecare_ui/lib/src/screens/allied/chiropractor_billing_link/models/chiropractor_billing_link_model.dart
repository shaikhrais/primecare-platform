import 'package:primecare_models/primecare_models.dart';

class ChiropractorBillingLinkModel extends BaseScreenState<ChiropractorBillingLinkModel> {
  const ChiropractorBillingLinkModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ChiropractorBillingLinkModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ChiropractorBillingLinkModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
