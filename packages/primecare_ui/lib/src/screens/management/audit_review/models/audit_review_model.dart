import 'package:primecare_models/primecare_models.dart';

class AuditReviewModel extends BaseScreenState<AuditReviewModel> {
  const AuditReviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AuditReviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AuditReviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
