import 'package:primecare_models/primecare_models.dart';

class CeoApprovalsModel extends BaseScreenState<CeoApprovalsModel> {
  const CeoApprovalsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  CeoApprovalsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => CeoApprovalsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
