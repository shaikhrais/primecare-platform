import 'package:primecare_models/primecare_models.dart';

class GuestComplianceModel extends BaseScreenState<GuestComplianceModel> {
  const GuestComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GuestComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GuestComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
