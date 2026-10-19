import 'package:primecare_models/primecare_models.dart';

class FinanceDirectorComplianceModel extends BaseScreenState<FinanceDirectorComplianceModel> {
  const FinanceDirectorComplianceModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FinanceDirectorComplianceModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FinanceDirectorComplianceModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
