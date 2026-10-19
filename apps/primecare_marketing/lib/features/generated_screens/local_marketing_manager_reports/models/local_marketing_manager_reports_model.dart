import 'package:primecare_models/primecare_models.dart';

class LocalMarketingManagerReportsModel extends BaseScreenState<LocalMarketingManagerReportsModel> {
  const LocalMarketingManagerReportsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LocalMarketingManagerReportsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LocalMarketingManagerReportsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
