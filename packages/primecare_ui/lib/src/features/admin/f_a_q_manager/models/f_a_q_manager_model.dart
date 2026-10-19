import 'package:primecare_models/primecare_models.dart';

class FAQManagerModel extends BaseScreenState<FAQManagerModel> {
  const FAQManagerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FAQManagerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FAQManagerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
