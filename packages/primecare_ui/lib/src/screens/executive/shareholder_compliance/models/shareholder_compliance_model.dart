import 'package:primecare_models/primecare_models.dart';

class ShareholderComplianceModel extends BaseScreenState<ShareholderComplianceModel> {
  const ShareholderComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ShareholderComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ShareholderComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
