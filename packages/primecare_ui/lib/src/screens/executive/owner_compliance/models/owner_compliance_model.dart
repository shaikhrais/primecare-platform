import 'package:primecare_models/primecare_models.dart';

class OwnerComplianceModel extends BaseScreenState<OwnerComplianceModel> {
  const OwnerComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  OwnerComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => OwnerComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
