// Layer: 02_MODELS_FOUNDATION
class ApproveMedicationRefillFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;
  final String requestRefillId;
  final String patientId;
  final String medicationName;
  final String dosage;
  final int quantity;
  final String requestingPhysician;
  final String status;

  ApproveMedicationRefillFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
    this.requestRefillId = '',
    this.patientId = '',
    this.medicationName = '',
    this.dosage = '',
    this.quantity = 0,
    this.requestingPhysician = '',
    this.status = 'Pending',
  });

  ApproveMedicationRefillFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
    String? requestRefillId,
    String? patientId,
    String? medicationName,
    String? dosage,
    int? quantity,
    String? requestingPhysician,
    String? status,
  }) {
    return ApproveMedicationRefillFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
      requestRefillId: requestRefillId ?? this.requestRefillId,
      patientId: patientId ?? this.patientId,
      medicationName: medicationName ?? this.medicationName,
      dosage: dosage ?? this.dosage,
      quantity: quantity ?? this.quantity,
      requestingPhysician: requestingPhysician ?? this.requestingPhysician,
      status: status ?? this.status,
    );
  }
}
