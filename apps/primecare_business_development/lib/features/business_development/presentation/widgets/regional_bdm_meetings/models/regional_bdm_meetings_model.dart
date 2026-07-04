class RegionalBdmMeetingsModel {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic> data;

  const RegionalBdmMeetingsModel({
    this.isLoading = false,
    this.errorMessage,
    this.data = const {},
  });

  RegionalBdmMeetingsModel copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? data,
  }) {
    return RegionalBdmMeetingsModel(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      data: data ?? this.data,
    );
  }
}
