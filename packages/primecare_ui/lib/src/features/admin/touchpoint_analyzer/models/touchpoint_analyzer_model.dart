import 'package:primecare_models/primecare_models.dart';

class TouchpointAnalyzerModel extends BaseScreenState<TouchpointAnalyzerModel> {
  const TouchpointAnalyzerModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TouchpointAnalyzerModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TouchpointAnalyzerModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
