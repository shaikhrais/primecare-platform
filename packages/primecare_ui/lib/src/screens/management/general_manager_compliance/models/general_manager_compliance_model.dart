import 'package:primecare_models/primecare_models.dart';

class GeneralManagerComplianceModel extends BaseScreenState<GeneralManagerComplianceModel> {
  const GeneralManagerComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  GeneralManagerComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => GeneralManagerComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
