import 'package:primecare_models/primecare_models.dart';

class XrayReviewModel extends BaseScreenState<XrayReviewModel> {
  const XrayReviewModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  XrayReviewModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => XrayReviewModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
