import 'package:primecare_models/primecare_models.dart';

class HrHiringOffersModel extends BaseScreenState<HrHiringOffersModel> {
  const HrHiringOffersModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  HrHiringOffersModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => HrHiringOffersModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
