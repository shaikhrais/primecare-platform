import 'package:primecare_models/primecare_models.dart';

class PopulationHealthAnalyzerModel extends BaseScreenState<PopulationHealthAnalyzerModel> {
  const PopulationHealthAnalyzerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PopulationHealthAnalyzerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PopulationHealthAnalyzerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
