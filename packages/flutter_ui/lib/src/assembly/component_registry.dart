import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../components/primecare_stat_card.dart';

/// A function signature for building a specific component from a blueprint payload.
typedef ComponentBuilder = Widget Function(BuildContext context, dynamic dataPayload);

/// A centralized registry to securely map component string types to their respective Builders.
/// This replaces large switch statements and is O(1) time complexity.
class ComponentRegistry {
  static final Map<String, ComponentBuilder> _registry = {
    'stat_card_grid': _buildStatCardGrid,
    'activity_feed': _buildActivityFeed,
    'data_table': _buildDataTable,
  };

  /// Register a new component dynamically (could be used for lazy-loaded plugins).
  static void registerComponent(String type, ComponentBuilder builder) {
    _registry[type] = builder;
  }

  /// Retrieve the builder for a component type. Returns a fallback builder if not found.
  static ComponentBuilder getBuilder(String componentType) {
    return _registry[componentType] ?? _buildUnknownComponent(componentType);
  }

  /// Extracts the required Builder and creates the widget safely.
  static Widget build(BuildContext context, UIComponentBlueprint blueprint) {
    final builder = getBuilder(blueprint.componentType);
    return builder(context, blueprint.dataPayload);
  }


  // --- Builders for default widgets ---

  static Widget _buildStatCardGrid(BuildContext context, dynamic dataPayload) {
    // Expected a list of KPI objects
    final kpis = dataPayload as List<dynamic>; 
    
    return GridView.count(
      crossAxisCount: 4,
      crossAxisSpacing: 24,
      mainAxisSpacing: 24,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.5,
      children: kpis.map((kpi) {
        final title = kpi.title as String;
        final value = kpi.value as String;
        final status = kpi.status as String;
        final trend = kpi.trend as String?;
        
        return PrimeCareStatCard(
          title: title,
          value: value,
          deltaSuffix: trend,
          icon: _inferIcon(title),
          iconColor: _inferColor(status),
        );
      }).toList(),
    );
  }

  static Widget _buildActivityFeed(BuildContext context, dynamic dataPayload) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(12),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withAlpha(25)),
      ),
      child: const Center(child: Text("Activity Feed - Assembled", style: TextStyle(color: Colors.white))),
    );
  }

  static Widget _buildDataTable(BuildContext context, dynamic dataPayload) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(12),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withAlpha(25)),
      ),
      child: const Center(child: Text("Data Table - Assembled", style: TextStyle(color: Colors.white))),
    );
  }

  static ComponentBuilder _buildUnknownComponent(String type) {
    return (BuildContext context, dynamic payload) {
       return Center(
         child: Text('Unknown component type: $type'),
       );
    };
  }

  // --- Utility Methods ---
  static IconData _inferIcon(String title) {
    final t = title.toLowerCase();
    if (t.contains('patient') || t.contains('client')) return LucideIcons.users;
    if (t.contains('revenue') || t.contains('payment') || t.contains('invoice')) return LucideIcons.dollarSign;
    if (t.contains('appointment') || t.contains('schedule')) return LucideIcons.calendar;
    if (t.contains('alert') || t.contains('critical')) return LucideIcons.alertCircle;
    if (t.contains('staff') || t.contains('provider') || t.contains('rpn')) return LucideIcons.stethoscope;
    if (t.contains('task') || t.contains('pipeline')) return LucideIcons.checkSquare;
    return LucideIcons.activity;
  }

  static Color _inferColor(String status) {
    final s = status.toLowerCase();
    if (s == 'operational' || s == 'positive' || s == 'up' || s == 'active') return Colors.greenAccent;
    if (s == 'warning' || s == 'attention') return Colors.orangeAccent;
    if (s == 'critical' || s == 'down' || s == 'negative') return Colors.redAccent;
    return Colors.tealAccent;
  }
}
