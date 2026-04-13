import 'package:flutter/material.dart';
import 'package:primecare_core/flutter_core.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../components/primecare_stat_card.dart';
import '../components/layout/prime_responsive_grid.dart';

/// A function signature for building a specific component from a blueprint payload.
typedef ComponentBuilder = Widget Function(BuildContext context, dynamic dataPayload);

/// A centralized registry to securely map component string types to their respective Builders.
/// This replaces large switch statements and is O(1) time complexity.
class ComponentWarehouse {
  static final Map<String, ComponentBuilder> _registry = {
    'stat_card_grid': _buildStatCardGrid,
    'activity_feed': _buildActivityFeed,
    'data_table': _buildDataTable,
    'risk_monitor': _buildRiskMonitor,
    'financial_rail': _buildFinancialRail,
    'management_action': _buildManagementAction,
    'clinical_metric': _buildClinicalMetric,
    'compliance_gate': _buildComplianceGate,
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
    
    return PrimeResponsiveGrid(
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

  static Widget _buildRiskMonitor(BuildContext context, dynamic dataPayload) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1A1A2E), Color(0xFF16213E)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.redAccent.withAlpha(50), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withAlpha(20),
            blurRadius: 40,
            spreadRadius: 5,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.shieldAlert, color: Colors.redAccent, size: 28),
              const SizedBox(width: 16),
              Text(
                "Risk Surveillance Engine".toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  letterSpacing: 2,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              const Text("LIVE", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w900)),
            ],
          ),
          const SizedBox(height: 24),
          const Text(
            "Monitoring algorithmic health and care quality signals across all tenants.",
            style: TextStyle(color: Colors.white70, height: 1.5),
          ),
        ],
      ),
    );
  }

  static Widget _buildFinancialRail(BuildContext context, dynamic dataPayload) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        color: const Color(0xFF0F3460).withAlpha(150),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.blueAccent.withAlpha(50)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withAlpha(30),
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.banknote, color: Colors.blueAccent),
          ),
          const SizedBox(width: 24),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Financial Rails", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
              Text("Automated ledger reconciliation active", style: TextStyle(color: Colors.white54)),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildManagementAction(BuildContext context, dynamic dataPayload) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(10),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.orangeAccent.withAlpha(30)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Critical Controls", style: TextStyle(color: Colors.orangeAccent, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            children: [
              _buildActionButton("Quarantine Tenant", LucideIcons.lock, Colors.redAccent),
              _buildActionButton("System Audit", LucideIcons.fileSearch, Colors.blueAccent),
              _buildActionButton("Freeze Payouts", LucideIcons.pause, Colors.orangeAccent),
            ],
          ),
        ],
      ),
    );
  }

  static Widget _buildClinicalMetric(BuildContext context, dynamic dataPayload) {
     return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF1B262C),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.tealAccent.withAlpha(40)),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Clinical Care Score", style: TextStyle(color: Colors.white, fontSize: 16)),
          Text("98.4%", style: TextStyle(color: Colors.tealAccent, fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  static Widget _buildComplianceGate(BuildContext context, dynamic dataPayload) {
     return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.indigo.withAlpha(30),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.indigoAccent.withAlpha(50)),
      ),
      child: const Center(child: Text("Compliance Gate - Verified", style: TextStyle(color: Colors.indigoAccent))),
    );
  }

  static Widget _buildActionButton(String label, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withAlpha(40)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 18),
          const SizedBox(width: 8),
          Text(label, style: TextStyle(color: color, fontWeight: FontWeight.w600, fontSize: 13)),
        ],
      ),
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
