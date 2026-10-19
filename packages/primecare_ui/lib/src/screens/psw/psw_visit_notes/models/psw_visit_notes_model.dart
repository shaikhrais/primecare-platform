import 'package:primecare_models/primecare_models.dart';

class PswVisitNotesModel extends BaseScreenState<PswVisitNotesModel> {
  const PswVisitNotesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswVisitNotesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswVisitNotesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
