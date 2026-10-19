import 'package:primecare_models/primecare_models.dart';

class CooIssueEscalationsModel extends BaseScreenState<CooIssueEscalationsModel> {
  const CooIssueEscalationsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CooIssueEscalationsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CooIssueEscalationsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
