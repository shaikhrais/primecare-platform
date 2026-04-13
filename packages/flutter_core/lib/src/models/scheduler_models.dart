import 'package:flutter/material.dart';

enum AppointmentStatus { pending, confirmed, ongoing, completed, cancelled }

enum ResourceType { room, equipment, suite }

enum SchedulePressure { optimal, high, critical }

class StaffMember {
  final String id;
  final String name;
  final String role;
  final String specialization;
  final String avatarUrl;
  final Color themeColor;

  const StaffMember({
    required this.id,
    required this.name,
    required this.role,
    required this.specialization,
    required this.avatarUrl,
    required this.themeColor,
  });

  factory StaffMember.fromJson(Map<String, dynamic> json) {
    return StaffMember(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String,
      specialization: json['specialization'] as String,
      avatarUrl: json['avatarUrl'] as String,
      themeColor: Color(int.parse(json['themeColor'] as String)),
    );
  }
}

enum ResourceStatus { available, busy, maintenance, offline }

class InstitutionalResource {
  final String id;
  final String name;
  final ResourceType type;
  final String? description;
  final ResourceStatus status;
  final DateTime? lastMaintenanceDate;

  const InstitutionalResource({
    required this.id,
    required this.name,
    required this.type,
    this.description,
    this.status = ResourceStatus.available,
    this.lastMaintenanceDate,
  });

  factory InstitutionalResource.fromJson(Map<String, dynamic> json) {
    return InstitutionalResource(
      id: json['id'] as String,
      name: json['name'] as String,
      type: ResourceType.values.firstWhere(
        (e) => e.name == json['type'],
        orElse: () => ResourceType.equipment,
      ),
      description: json['description'] as String?,
      status: ResourceStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => ResourceStatus.available,
      ),
      lastMaintenanceDate: json['lastMaintenanceDate'] != null
          ? DateTime.parse(json['lastMaintenanceDate'] as String)
          : null,
    );
  }

  InstitutionalResource copyWith({
    ResourceStatus? status,
    DateTime? lastMaintenanceDate,
  }) {
    return InstitutionalResource(
      id: id,
      name: name,
      type: type,
      description: description,
      status: status ?? this.status,
      lastMaintenanceDate: lastMaintenanceDate ?? this.lastMaintenanceDate,
    );
  }
}

class Appointment {
  final String id;
  final String patientName;
  final DateTime startTime;
  final Duration duration;
  final String staffId;
  final String? resourceId;
  final AppointmentStatus status;
  final String? note;

  const Appointment({
    required this.id,
    required this.patientName,
    required this.startTime,
    required this.duration,
    required this.staffId,
    this.resourceId,
    required this.status,
    this.note,
  });

  DateTime get endTime => startTime.add(duration);

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] as String,
      patientName: json['patientName'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      duration: Duration(minutes: json['durationMinutes'] as int),
      staffId: json['staffId'] as String,
      resourceId: json['resourceId'] as String?,
      status: AppointmentStatus.values.firstWhere(
        (e) => e.name == json['status'],
        orElse: () => AppointmentStatus.pending,
      ),
      note: json['note'] as String?,
    );
  }

  Appointment copyWith({
    String? id,
    String? patientName,
    DateTime? startTime,
    Duration? duration,
    String? staffId,
    String? resourceId,
    AppointmentStatus? status,
    String? note,
  }) {
    return Appointment(
      id: id ?? this.id,
      patientName: patientName ?? this.patientName,
      startTime: startTime ?? this.startTime,
      duration: duration ?? this.duration,
      staffId: staffId ?? this.staffId,
      resourceId: resourceId ?? this.resourceId,
      status: status ?? this.status,
      note: note ?? this.note,
    );
  }

  /// Returns true if this appointment's time range overlaps with another.
  bool overlaps(Appointment other) {
    if (staffId != other.staffId && resourceId != other.resourceId) {
      return false;
    }
    return startTime.isBefore(other.endTime) &&
        other.startTime.isBefore(endTime);
  }
}

class HorizonSchedule {
  final List<StaffMember> staff;
  final List<InstitutionalResource> resources;
  final List<Appointment> appointments;

  const HorizonSchedule({
    required this.staff,
    required this.resources,
    required this.appointments,
  });

  HorizonSchedule copyWith({
    List<StaffMember>? staff,
    List<InstitutionalResource>? resources,
    List<Appointment>? appointments,
  }) {
    return HorizonSchedule(
      staff: staff ?? this.staff,
      resources: resources ?? this.resources,
      appointments: appointments ?? this.appointments,
    );
  }
}
