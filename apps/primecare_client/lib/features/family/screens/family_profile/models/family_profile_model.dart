import 'package:primecare_models/primecare_models.dart';

class FamilyProfileModel extends BaseScreenState<FamilyProfileModel> {
  const FamilyProfileModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FamilyProfileModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FamilyProfileModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
