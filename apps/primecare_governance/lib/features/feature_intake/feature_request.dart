import 'package:json_annotation/json_annotation.dart';

part 'feature_request.g.dart';

@JsonSerializable()
class FeatureRequest {
  final String requestId;
  final String requestedBy;
  final String appId;
  final String module;
  final String featureName;
  final String description;
  final List<String> screens;
  final List<String> apiEndpoints;
  final String priority;
  final String status;

  FeatureRequest({
    required this.requestId,
    required this.requestedBy,
    required this.appId,
    required this.module,
    required this.featureName,
    required this.description,
    required this.screens,
    required this.apiEndpoints,
    required this.priority,
    required this.status,
  });

  factory FeatureRequest.fromJson(Map<String, dynamic> json) => _$FeatureRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FeatureRequestToJson(this);
}
