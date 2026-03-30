import 'package:flutter/material.dart';
import 'role_data_model.dart';

class RoleDataRepository {
  /// Simulates a backend fetch latency dynamically mapping exact nested metrics
  Future<RoleDataModel> fetchRoleData(String roleId) async {
    await Future.delayed(const Duration(milliseconds: 1200));

    // Define Role-specific Key Performance Indicators natively natively
    List<KpiMetric> kpis = [];
    List<ActivityLog> activity = [];

    // Corporate Head Office Logics
    if (roleId == 'founder_ceo') {
      kpis = const [
        KpiMetric(label: 'Total Active Patients', value: '4,102', trend: '+12.4%', isPositive: true, icon: Icons.people),
        KpiMetric(label: 'Global MRR', value: '\$1.2M', trend: '+4.1%', isPositive: true, icon: Icons.attach_money),
        KpiMetric(label: 'Franchise Compliance', value: '98.2%', trend: '-0.4%', isPositive: false, icon: Icons.verified),
      ];
      activity = const [
        ActivityLog(title: 'New Franchise Onboarded', timestamp: '10 mins ago', description: 'Hamilton Branch registered successfully.'),
        ActivityLog(title: 'Compliance Audit Generated', timestamp: '2 hours ago', description: 'Monthly platform audit complete.'),
      ];
    } 
    // Clinical Team Logics
    else if (roleId == 'rn' || roleId == 'psw' || roleId == 'physiotherapist') {
      kpis = const [
        KpiMetric(label: "Today's Visits", value: '8', trend: 'On Track', isPositive: true, icon: Icons.local_hospital),
        KpiMetric(label: 'Pending Notes', value: '2', trend: 'Action Req', isPositive: false, icon: Icons.note_alt),
        KpiMetric(label: 'Weekly Hours', value: '38h', trend: '+2h', isPositive: true, icon: Icons.access_time),
      ];
      activity = const [
        ActivityLog(title: 'Visit Completed', timestamp: '1 hour ago', description: 'Patient: Jenkins, A. - Vitals logged.'),
        ActivityLog(title: 'Care Plan Updated', timestamp: 'Yesterday', description: 'New physio routine assigned.'),
      ];
    }
    // Business Development Logics
    else if (roleId.contains('bd_manager') || roleId == 'head_business_development') {
      kpis = const [
        KpiMetric(label: 'Active Leads', value: '142', trend: '+22.1%', isPositive: true, icon: Icons.campaign),
        KpiMetric(label: 'Conversion Rate', value: '18.4%', trend: '+1.2%', isPositive: true, icon: Icons.trending_up),
        KpiMetric(label: 'Pipeline Value', value: '\$450k', trend: 'Stable', isPositive: true, icon: Icons.pie_chart),
      ];
      activity = const [
        ActivityLog(title: 'Lead Converted', timestamp: '3 hours ago', description: 'St. Marys Hospital partnership signed.'),
      ];
    }
    // Generic fallback for all other 20+ specialized roles correctly dynamically intelligently
    else {
      kpis = [
        KpiMetric(label: 'System Status', value: 'Optimal', trend: 'Live', isPositive: true, icon: Icons.check_circle),
        KpiMetric(label: 'Active Sessions', value: '1,204', trend: 'Normal', isPositive: true, icon: Icons.computer),
        KpiMetric(label: 'Unread Messages', value: '5', trend: 'Action Req', isPositive: false, icon: Icons.mail),
      ];
      activity = const [
        ActivityLog(title: 'System Boot', timestamp: 'Just now', description: 'Connected to Data Core successfully.'),
      ];
    }

    return RoleDataModel(
      roleId: roleId,
      greetingTitle: 'Welcome back!',
      kpis: kpis,
      recentActivity: activity,
    );
  }
}
