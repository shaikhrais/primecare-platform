import 'package:primecare_models/primecare_models.dart';

class FamilyLovedOneScheduleModel extends BaseScreenState<FamilyLovedOneScheduleModel> {
  const FamilyLovedOneScheduleModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FamilyLovedOneScheduleModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FamilyLovedOneScheduleModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
