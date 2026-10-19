import 'package:primecare_models/primecare_models.dart';

class PartnershipManagerOutreachModel extends BaseScreenState<PartnershipManagerOutreachModel> {
  const PartnershipManagerOutreachModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PartnershipManagerOutreachModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PartnershipManagerOutreachModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
