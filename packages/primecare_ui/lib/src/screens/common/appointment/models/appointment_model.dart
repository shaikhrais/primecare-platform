class AppointmentModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const AppointmentModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  AppointmentModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return AppointmentModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
