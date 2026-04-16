class DailyVitalsCardFormViewModel {
  final bool isLoading;
  final bool isSuccess;
  final Map<String, dynamic> data;
  final String? error;
  final String recordId;
  final String patientId;
  final double temperature;
  final int heartRate;
  final int bloodPressureSystolic;
  final int bloodPressureDiastolic;
  final int oxygenSaturation;
  final DateTime? recordedAt;

  DailyVitalsCardFormViewModel({
    this.isLoading = false,
    this.isSuccess = false,
    this.data = const {},
    this.error,
    this.recordId = '',
    this.patientId = '',
    this.temperature = 37.0,
    this.heartRate = 0,
    this.bloodPressureSystolic = 120,
    this.bloodPressureDiastolic = 80,
    this.oxygenSaturation = 98,
    this.recordedAt,
  });

  DailyVitalsCardFormViewModel copyWith({
    bool? isLoading,
    bool? isSuccess,
    Map<String, dynamic>? data,
    String? error,
    String? recordId,
    String? patientId,
    double? temperature,
    int? heartRate,
    int? bloodPressureSystolic,
    int? bloodPressureDiastolic,
    int? oxygenSaturation,
    DateTime? recordedAt,
  }) {
    return DailyVitalsCardFormViewModel(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      data: data ?? this.data,
      error: error ?? this.error,
      recordId: recordId ?? this.recordId,
      patientId: patientId ?? this.patientId,
      temperature: temperature ?? this.temperature,
      heartRate: heartRate ?? this.heartRate,
      bloodPressureSystolic:
          bloodPressureSystolic ?? this.bloodPressureSystolic,
      bloodPressureDiastolic:
          bloodPressureDiastolic ?? this.bloodPressureDiastolic,
      oxygenSaturation: oxygenSaturation ?? this.oxygenSaturation,
      recordedAt: recordedAt ?? this.recordedAt,
    );
  }
}
