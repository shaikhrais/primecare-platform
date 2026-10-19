import 'package:primecare_models/primecare_models.dart';

class FamilyCareUpdatesModel extends BaseScreenState<FamilyCareUpdatesModel> {
  const FamilyCareUpdatesModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FamilyCareUpdatesModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FamilyCareUpdatesModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
