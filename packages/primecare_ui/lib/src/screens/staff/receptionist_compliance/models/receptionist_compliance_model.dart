import 'package:primecare_models/primecare_models.dart';

class ReceptionistComplianceModel extends BaseScreenState<ReceptionistComplianceModel> {
  const ReceptionistComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ReceptionistComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ReceptionistComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
