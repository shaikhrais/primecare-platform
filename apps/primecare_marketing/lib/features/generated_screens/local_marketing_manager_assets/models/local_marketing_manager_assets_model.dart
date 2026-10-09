import 'package:primecare_models/primecare_models.dart';

class LocalMarketingManagerAssetsModel extends BaseScreenState<LocalMarketingManagerAssetsModel> {
  const LocalMarketingManagerAssetsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LocalMarketingManagerAssetsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LocalMarketingManagerAssetsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
