import 'package:primecare_models/primecare_models.dart';

class PswDailyNotesModel extends BaseScreenState<PswDailyNotesModel> {
  const PswDailyNotesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswDailyNotesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswDailyNotesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
