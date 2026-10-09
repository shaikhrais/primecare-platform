import 'package:primecare_models/primecare_models.dart';

class LocalMarketingManagerLeadsModel extends BaseScreenState<LocalMarketingManagerLeadsModel> {
  const LocalMarketingManagerLeadsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  LocalMarketingManagerLeadsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => LocalMarketingManagerLeadsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
