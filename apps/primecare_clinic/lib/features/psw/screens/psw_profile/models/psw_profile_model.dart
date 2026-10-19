import 'package:primecare_models/primecare_models.dart';

class PswProfileModel extends BaseScreenState<PswProfileModel> {
  const PswProfileModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  PswProfileModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => PswProfileModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
