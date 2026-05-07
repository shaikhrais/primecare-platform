// Layer: 00_MODELS

enum ResourceStatus { available, maintenance, offline }

enum SchedulePressure { optimal, high, critical }

class InstitutionalResource {
  final String id;
  final String name;
  final ResourceStatus status;

  const InstitutionalResource({
    required this.id,
    required this.name,
    required this.status,
  });

  factory InstitutionalResource.fromJson(Map<String, dynamic> json) {
    return InstitutionalResource(
      id: json['id'] as String,
      name: json['name'] as String,
      status: ResourceStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ResourceStatus.available,
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'status': status.name,
  };
}

class StaffMember {
  final String id;
  final String name;

  const StaffMember({required this.id, required this.name});

  factory StaffMember.fromJson(Map<String, dynamic> json) {
    return StaffMember(id: json['id'] as String, name: json['name'] as String);
  }

  Map<String, dynamic> toJson() => {'id': id, 'name': name};
}

class Appointment {
  final String id;
  final String patientName;
  final String staffId;
  final String? resourceId;
  final DateTime startTime;
  final DateTime endTime;

  const Appointment({
    required this.id,
    required this.patientName,
    required this.staffId,
    this.resourceId,
    required this.startTime,
    required this.endTime,
  });

  Duration get duration => endTime.difference(startTime);

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as String,
      patientName: json['patientName'] as String,
      staffId: json['staffId'] as String,
      resourceId: json['resourceId'] as String?,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'patientName': patientName,
    'staffId': staffId,
    'resourceId': resourceId,
    'startTime': startTime.toIso8601String(),
    'endTime': endTime.toIso8601String(),
  };

  Appointment copyWith({
    String? id,
    String? patientName,
    String? staffId,
    String? resourceId,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return Appointment(
      id: id ?? this.id,
      patientName: patientName ?? this.patientName,
      staffId: staffId ?? this.staffId,
      resourceId: resourceId ?? this.resourceId,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}

class HorizonSchedule {
  final List<Appointment> appointments;
  final List<InstitutionalResource> resources;
  final List<StaffMember> staff;

  const HorizonSchedule({
    required this.appointments,
    required this.resources,
    required this.staff,
  });

  factory HorizonSchedule.fromJson(Map<String, dynamic> json) {
    return HorizonSchedule(
      appointments: (json['appointments'] as List? ?? [])
          .map((e) => Appointment.fromJson(e as Map<String, dynamic>))
          .toList(),
      resources: (json['resources'] as List? ?? [])
          .map((e) => InstitutionalResource.fromJson(e as Map<String, dynamic>))
          .toList(),
      staff: (json['staff'] as List? ?? [])
          .map((e) => StaffMember.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'appointments': appointments.map((e) => e.toJson()).toList(),
    'resources': resources.map((e) => e.toJson()).toList(),
    'staff': staff.map((e) => e.toJson()).toList(),
  };

  HorizonSchedule copyWith({
    List<Appointment>? appointments,
    List<InstitutionalResource>? resources,
    List<StaffMember>? staff,
  }) {
    return HorizonSchedule(
      appointments: appointments ?? this.appointments,
      resources: resources ?? this.resources,
      staff: staff ?? this.staff,
    );
  }
}
