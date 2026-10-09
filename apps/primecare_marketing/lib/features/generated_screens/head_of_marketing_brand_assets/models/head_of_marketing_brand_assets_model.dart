import 'package:primecare_models/primecare_models.dart';

class HeadOfMarketingBrandAssetsModel extends BaseScreenState<HeadOfMarketingBrandAssetsModel> {
  const HeadOfMarketingBrandAssetsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HeadOfMarketingBrandAssetsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HeadOfMarketingBrandAssetsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
