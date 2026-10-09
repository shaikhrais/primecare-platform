import 'package:primecare_models/primecare_models.dart';

class HeadOfMarketingLeadsModel extends BaseScreenState<HeadOfMarketingLeadsModel> {
  const HeadOfMarketingLeadsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HeadOfMarketingLeadsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HeadOfMarketingLeadsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
