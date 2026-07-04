class VirtualConsultModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const VirtualConsultModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  VirtualConsultModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return VirtualConsultModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
