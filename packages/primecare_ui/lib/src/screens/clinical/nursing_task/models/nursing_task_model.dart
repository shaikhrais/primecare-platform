import 'package:primecare_models/primecare_models.dart';

class NursingTaskModel extends BaseScreenState<NursingTaskModel> {
  const NursingTaskModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  NursingTaskModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => NursingTaskModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
