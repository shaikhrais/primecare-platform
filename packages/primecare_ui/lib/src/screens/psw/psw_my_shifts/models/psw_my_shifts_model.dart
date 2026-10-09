import 'package:primecare_models/primecare_models.dart';

class PswMyShiftsModel extends BaseScreenState<PswMyShiftsModel> {
  const PswMyShiftsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswMyShiftsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswMyShiftsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
