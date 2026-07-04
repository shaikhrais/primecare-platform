class ClientMyAppointmentsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const ClientMyAppointmentsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  ClientMyAppointmentsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return ClientMyAppointmentsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
