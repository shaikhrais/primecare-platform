import 'package:primecare_models/primecare_models.dart';

class PartnershipManagerReportsModel extends BaseScreenState<PartnershipManagerReportsModel> {
  const PartnershipManagerReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PartnershipManagerReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PartnershipManagerReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
