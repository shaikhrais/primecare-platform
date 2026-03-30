import 'package:flutter/material.dart';

class KpiMetric {
  final String label;
  final String value;
  final String? trend;
  final bool isPositive;
  final IconData? icon;

  const KpiMetric({
    required this.label,
    required this.value,
    this.trend,
    this.isPositive = true,
    this.icon,
  });
}

class ActivityLog {
  final String title;
  final String timestamp;
  final String description;

  const ActivityLog({
    required this.title,
    required this.timestamp,
    required this.description,
  });
}

class RoleDataModel {
  final String roleId;
  final String greetingTitle;
  final List<KpiMetric> kpis;
  final List<ActivityLog> recentActivity;

  const RoleDataModel({
    required this.roleId,
    required this.greetingTitle,
    this.kpis = const [],
    this.recentActivity = const [],
  });
}
