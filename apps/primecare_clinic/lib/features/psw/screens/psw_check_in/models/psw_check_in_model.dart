import 'package:primecare_models/primecare_models.dart';

class PswCheckInModel extends BaseScreenState<PswCheckInModel> {
  const PswCheckInModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswCheckInModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswCheckInModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
