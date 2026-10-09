import 'package:primecare_models/primecare_models.dart';

class CfoRevenueModel extends BaseScreenState<CfoRevenueModel> {
  const CfoRevenueModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CfoRevenueModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CfoRevenueModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
