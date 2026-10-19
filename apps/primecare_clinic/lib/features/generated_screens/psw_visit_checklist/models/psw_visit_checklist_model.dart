import 'package:primecare_models/primecare_models.dart';

class PswVisitChecklistModel extends BaseScreenState<PswVisitChecklistModel> {
  const PswVisitChecklistModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswVisitChecklistModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswVisitChecklistModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
