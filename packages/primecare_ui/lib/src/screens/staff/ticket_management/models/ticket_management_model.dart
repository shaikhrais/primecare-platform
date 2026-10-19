import 'package:primecare_models/primecare_models.dart';

class TicketManagementModel extends BaseScreenState<TicketManagementModel> {
  const TicketManagementModel({
    super.isLoading = false,
    super.errorMessage,
    super.data = const {},
  });

  @override
  TicketManagementModel rebuild({
    required bool isLoading,
    required String? errorMessage,
    required Map<String, dynamic> data,
  }) => TicketManagementModel(
    isLoading: isLoading,
    errorMessage: errorMessage,
    data: data,
  );
}
