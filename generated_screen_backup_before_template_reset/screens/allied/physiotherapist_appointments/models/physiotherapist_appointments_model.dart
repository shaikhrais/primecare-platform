class PhysiotherapistAppointmentsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const PhysiotherapistAppointmentsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  PhysiotherapistAppointmentsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return PhysiotherapistAppointmentsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
