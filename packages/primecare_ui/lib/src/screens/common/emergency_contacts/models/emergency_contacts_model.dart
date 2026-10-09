import 'package:primecare_models/primecare_models.dart';

class EmergencyContactsModel extends BaseScreenState<EmergencyContactsModel> {
  const EmergencyContactsModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  EmergencyContactsModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => EmergencyContactsModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
