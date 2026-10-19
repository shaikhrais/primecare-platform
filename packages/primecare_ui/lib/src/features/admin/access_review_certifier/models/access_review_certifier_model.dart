import 'package:primecare_models/primecare_models.dart';

class AccessReviewCertifierModel extends BaseScreenState<AccessReviewCertifierModel> {
  const AccessReviewCertifierModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AccessReviewCertifierModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AccessReviewCertifierModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
