import 'package:primecare_models/primecare_models.dart';

class BoardOfDirectorsSummaryModel extends BaseScreenState<BoardOfDirectorsSummaryModel> {
  const BoardOfDirectorsSummaryModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  BoardOfDirectorsSummaryModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => BoardOfDirectorsSummaryModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
