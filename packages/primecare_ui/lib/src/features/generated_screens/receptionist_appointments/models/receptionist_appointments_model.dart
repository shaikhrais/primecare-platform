class ReceptionistAppointmentsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ReceptionistAppointmentsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ReceptionistAppointmentsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ReceptionistAppointmentsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
