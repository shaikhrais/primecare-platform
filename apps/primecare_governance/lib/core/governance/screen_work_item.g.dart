// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'screen_work_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ScreenWorkItem _$ScreenWorkItemFromJson(Map<String, dynamic> json) =>
    ScreenWorkItem(
      serialNo: json['serialNo'] as String,
      screenCode: json['screenCode'] as String,
      title: json['title'] as String,
      office: json['office'] as String,
      module: json['module'] as String,
      action: json['action'] as String,
      status: json['status'] as String,
      priority: (json['priority'] as num).toInt(),
      assignedTo: json['assignedTo'] as String,
      notes: json['notes'] as String,
      routePath: json['routePath'] as String?,
      targetApp: json['targetApp'] as String,
      category: json['category'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      completedAt: json['completedAt'] == null
          ? null
          : DateTime.parse(json['completedAt'] as String),
    );

Map<String, dynamic> _$ScreenWorkItemToJson(ScreenWorkItem instance) =>
    <String, dynamic>{
      'serialNo': instance.serialNo,
      'screenCode': instance.screenCode,
      'title': instance.title,
      'office': instance.office,
      'module': instance.module,
      'action': instance.action,
      'status': instance.status,
      'priority': instance.priority,
      'assignedTo': instance.assignedTo,
      'notes': instance.notes,
      'routePath': instance.routePath,
      'targetApp': instance.targetApp,
      'category': instance.category,
      'createdAt': instance.createdAt.toIso8601String(),
      'completedAt': instance.completedAt?.toIso8601String(),
    };

ScreenChangeLog _$ScreenChangeLogFromJson(Map<String, dynamic> json) =>
    ScreenChangeLog(
      serialNo: json['serialNo'] as String,
      workItemSerial: json['workItemSerial'] as String,
      description: json['description'] as String,
      author: json['author'] as String,
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ScreenChangeLogToJson(ScreenChangeLog instance) =>
    <String, dynamic>{
      'serialNo': instance.serialNo,
      'workItemSerial': instance.workItemSerial,
      'description': instance.description,
      'author': instance.author,
      'timestamp': instance.timestamp.toIso8601String(),
      'metadata': instance.metadata,
    };
