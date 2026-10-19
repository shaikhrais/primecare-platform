import 'package:primecare_models/primecare_models.dart';

class IntakeCoordinatorReferralsModel extends BaseScreenState<IntakeCoordinatorReferralsModel> {
  const IntakeCoordinatorReferralsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  IntakeCoordinatorReferralsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => IntakeCoordinatorReferralsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
