import 'package:primecare_models/primecare_models.dart';

class AdminClaimsModel extends BaseScreenState<AdminClaimsModel> {
  const AdminClaimsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  AdminClaimsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => AdminClaimsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
