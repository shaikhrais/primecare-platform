import 'package:primecare_models/primecare_models.dart';

class ClinicalDirectorApprovalsModel extends BaseScreenState<ClinicalDirectorApprovalsModel> {
  const ClinicalDirectorApprovalsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ClinicalDirectorApprovalsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ClinicalDirectorApprovalsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
