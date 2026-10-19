import 'package:primecare_models/primecare_models.dart';

class ControlledSubstanceLogModel extends BaseScreenState<ControlledSubstanceLogModel> {
  const ControlledSubstanceLogModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  ControlledSubstanceLogModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => ControlledSubstanceLogModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
