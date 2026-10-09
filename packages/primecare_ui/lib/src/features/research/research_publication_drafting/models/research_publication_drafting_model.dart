import 'package:primecare_models/primecare_models.dart';

class ResearchPublicationDraftingModel extends BaseScreenState<ResearchPublicationDraftingModel> {
  const ResearchPublicationDraftingModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ResearchPublicationDraftingModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ResearchPublicationDraftingModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
