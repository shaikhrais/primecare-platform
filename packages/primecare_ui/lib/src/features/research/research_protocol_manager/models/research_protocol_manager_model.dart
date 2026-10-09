import 'package:primecare_models/primecare_models.dart';

class ResearchProtocolManagerModel extends BaseScreenState<ResearchProtocolManagerModel> {
  const ResearchProtocolManagerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ResearchProtocolManagerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ResearchProtocolManagerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
