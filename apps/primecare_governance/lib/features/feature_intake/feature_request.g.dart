// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feature_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeatureRequest _$FeatureRequestFromJson(
  Map<String, dynamic> json,
) => FeatureRequest(
  requestId: json['requestId'] as String,
  requestedBy: json['requestedBy'] as String,
  appId: json['appId'] as String,
  module: json['module'] as String,
  featureName: json['featureName'] as String,
  description: json['description'] as String,
  screens: (json['screens'] as List<dynamic>).map((e) => e as String).toList(),
  apiEndpoints: (json['apiEndpoints'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
  priority: json['priority'] as String,
  status: json['status'] as String,
  storyPoints: (json['storyPoints'] as num?)?.toInt() ?? 0,
  securityLevel: json['securityLevel'] as String? ?? 'medium',
  sprintName: json['sprintName'] as String? ?? 'Backlog',
  assignedDeveloper: json['assignedDeveloper'] as String? ?? 'Unassigned',
  subTasks:
      (json['subTasks'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$FeatureRequestToJson(FeatureRequest instance) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'requestedBy': instance.requestedBy,
      'appId': instance.appId,
      'module': instance.module,
      'featureName': instance.featureName,
      'description': instance.description,
      'screens': instance.screens,
      'apiEndpoints': instance.apiEndpoints,
      'priority': instance.priority,
      'status': instance.status,
      'storyPoints': instance.storyPoints,
      'securityLevel': instance.securityLevel,
      'sprintName': instance.sprintName,
      'assignedDeveloper': instance.assignedDeveloper,
      'subTasks': instance.subTasks,
    };
