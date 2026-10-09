import 'package:primecare_models/primecare_models.dart';

class FormularyComplianceManagerModel extends BaseScreenState<FormularyComplianceManagerModel> {
  const FormularyComplianceManagerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FormularyComplianceManagerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FormularyComplianceManagerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
