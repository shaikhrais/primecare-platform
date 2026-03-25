class PswDashboardData {
  final String userName;
  final String? urgentAlert;
  final double dailyProgress;
  final NextShiftInfo? nextShift;

  // Existing stats mappings
  final double hoursLogged;
  final int currentStreak;

  PswDashboardData({
    required this.userName,
    this.urgentAlert,
    required this.dailyProgress,
    this.nextShift,
    required this.hoursLogged,
    required this.currentStreak,
  });

  factory PswDashboardData.fromJson(Map<String, dynamic> json) {
    return PswDashboardData(
      userName: json['userName'] as String? ?? 'Caregiver',
      urgentAlert: json['urgentAlert'] as String?,
      dailyProgress: (json['dailyProgress'] as num?)?.toDouble() ?? 0.0,
      nextShift: json['nextShift'] != null
          ? NextShiftInfo.fromJson(json['nextShift'])
          : null,
      hoursLogged: (json['hoursLogged'] as num?)?.toDouble() ?? 0.0,
      currentStreak: json['currentStreak'] as int? ?? 0,
    );
  }
}

class NextShiftInfo {
  final String id;
  final String patientName;
  final DateTime startTime;
  final String address;

  NextShiftInfo({
    required this.id,
    required this.patientName,
    required this.startTime,
    required this.address,
  });

  factory NextShiftInfo.fromJson(Map<String, dynamic> json) {
    return NextShiftInfo(
      id: json['id'] as String? ?? '',
      patientName: json['patientName'] as String? ?? 'Unknown Patient',
      startTime: json['startTime'] != null
          ? DateTime.parse(json['startTime'])
          : DateTime.now(),
      address: json['address'] as String? ?? 'Address Pending',
    );
  }
}
