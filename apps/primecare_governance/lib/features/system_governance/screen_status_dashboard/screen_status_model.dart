class ScreenStatusState {
  final Map<String, dynamic>? statusData;
  final bool isLoading;
  final String? error;

  const ScreenStatusState({this.statusData, this.isLoading = true, this.error});

  ScreenStatusState copyWith({
    Map<String, dynamic>? statusData,
    bool? isLoading,
    String? error,
  }) {
    return ScreenStatusState(
      statusData: statusData ?? this.statusData,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
