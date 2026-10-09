import 'package:primecare_models/primecare_models.dart';

class PswScheduleModel extends BaseScreenState<PswScheduleModel> {
  const PswScheduleModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswScheduleModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswScheduleModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
