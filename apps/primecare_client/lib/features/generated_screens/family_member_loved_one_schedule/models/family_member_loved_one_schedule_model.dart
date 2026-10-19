import 'package:primecare_models/primecare_models.dart';

class FamilyMemberLovedOneScheduleModel extends BaseScreenState<FamilyMemberLovedOneScheduleModel> {
  const FamilyMemberLovedOneScheduleModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  FamilyMemberLovedOneScheduleModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => FamilyMemberLovedOneScheduleModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
