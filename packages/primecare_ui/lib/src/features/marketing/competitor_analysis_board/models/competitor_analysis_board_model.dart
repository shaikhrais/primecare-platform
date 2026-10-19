import 'package:primecare_models/primecare_models.dart';

class CompetitorAnalysisBoardModel extends BaseScreenState<CompetitorAnalysisBoardModel> {
  const CompetitorAnalysisBoardModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CompetitorAnalysisBoardModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CompetitorAnalysisBoardModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
