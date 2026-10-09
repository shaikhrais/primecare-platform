import 'package:primecare_models/primecare_models.dart';

class ComplianceCasesModel extends BaseScreenState<ComplianceCasesModel> {
  const ComplianceCasesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceCasesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceCasesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
