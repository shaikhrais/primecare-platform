import 'package:primecare_models/primecare_models.dart';

class AdjustmentNotesModel extends BaseScreenState<AdjustmentNotesModel> {
  const AdjustmentNotesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AdjustmentNotesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AdjustmentNotesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
