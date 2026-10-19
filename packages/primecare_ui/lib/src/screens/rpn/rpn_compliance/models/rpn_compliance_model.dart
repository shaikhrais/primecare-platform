import 'package:primecare_models/primecare_models.dart';

class RpnComplianceModel extends BaseScreenState<RpnComplianceModel> {
  const RpnComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  RpnComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => RpnComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
