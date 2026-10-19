import 'package:primecare_models/primecare_models.dart';

class ComplianceManagerDocumentExpiryModel extends BaseScreenState<ComplianceManagerDocumentExpiryModel> {
  const ComplianceManagerDocumentExpiryModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ComplianceManagerDocumentExpiryModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ComplianceManagerDocumentExpiryModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
