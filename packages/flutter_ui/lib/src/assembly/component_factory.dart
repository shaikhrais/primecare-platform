import 'package:flutter/material.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_ui/src/components/primecare_stat_card.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ComponentFactory {
  /// Dynamically assembles an empty PrimeCare UI component based on the Blueprint type
  /// and injects the required data payload.
  static Widget assemble(UIComponentBlueprint blueprint) {
    switch (blueprint.componentType) {
      case 'stat_card_grid':
        final kpis = blueprint.dataPayload as List<dynamic>; // Expected a list of KPI objects
        
        return GridView.count(
          crossAxisCount: 4,
          crossAxisSpacing: 24,
          mainAxisSpacing: 24,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.5,
          children: kpis.map((kpi) {
            // Note: In a true factory, we would map the dynamic payload to a UI model.
            // Assuming dynamic objects have title, value, status, trend.
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

      case 'activity_feed':
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(12),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withAlpha(25)),
          ),
          child: const Center(child: Text("Activity Feed - Assembled", style: TextStyle(color: Colors.white))),
        );
        
      case 'data_table':
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(12),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white.withAlpha(25)),
          ),
          child: const Center(child: Text("Data Table - Assembled", style: TextStyle(color: Colors.white))),
        );

      default:
        return Center(
          child: Text('Unknown component type: ${blueprint.componentType}'),
        );
    }
  }

  // Helpers to assign generic UI aesthetics based on text
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
