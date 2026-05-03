import 'package:json_annotation/json_annotation.dart';

part 'screen_work_item.g.dart';

@JsonSerializable()
class ScreenWorkItem {
  final String serialNo; // PC-SCR-XXXX, PC-PEN-XXXX, etc.
  final String screenCode; // e.g., PSW-101
  final String title;
  final String office;
  final String module;
  final String action; // create, update, delete
  final String status; // pending, implemented, verified
  final int priority; // 1 high, 2 medium, 3 low
  final String assignedTo;
  final String notes;
  final String? stitchProject;
  final String? stitchScreenId;
  final String? routePath;
  final DateTime createdAt;
  final DateTime? completedAt;

  ScreenWorkItem({
    required this.serialNo,
    required this.screenCode,
    required this.title,
    required this.office,
    required this.module,
    required this.action,
    required this.status,
    required this.priority,
    required this.assignedTo,
    required this.notes,
    this.stitchProject,
    this.stitchScreenId,
    this.routePath,
    DateTime? createdAt,
    this.completedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory ScreenWorkItem.fromJson(Map<String, dynamic> json) => _$ScreenWorkItemFromJson(json);
  Map<String, dynamic> toJson() => _$ScreenWorkItemToJson(this);
}

@JsonSerializable()
class ScreenChangeLog {
  final String serialNo; // PC-CHG-XXXX
  final String workItemSerial;
  final String description;
  final String author;
  final DateTime timestamp;
  final Map<String, dynamic>? metadata;

  ScreenChangeLog({
    required this.serialNo,
    required this.workItemSerial,
    required this.description,
    required this.author,
    DateTime? timestamp,
    this.metadata,
  }) : timestamp = timestamp ?? DateTime.now();

  factory ScreenChangeLog.fromJson(Map<String, dynamic> json) => _$ScreenChangeLogFromJson(json);
  Map<String, dynamic> toJson() => _$ScreenChangeLogToJson(this);
}
