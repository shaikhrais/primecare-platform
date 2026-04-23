// Layer: 01_INFRASTRUCTURE
import 'dart:io';

void main() async {
  final screens = [
    {
      'name': 'CeoDashboardScreen',
      'route': 'CorporateRoutes.ceoDashboard',
      'file': '05_U_ceo_dashboard_screen.dart',
      'title': 'CEO Dashboard',
    },
    {
      'name': 'HeadOfBusDevDashboardScreen',
      'route': 'CorporateRoutes.headOfBusDevDashboard',
      'file': 'head_of_bus_dev_dashboard_screen.dart',
      'title': 'Head of Bus Dev',
    },
    {
      'name': 'FranchiseOwnerDashboardScreen',
      'route': 'FranchiseRoutes.franchiseOwnerDashboard',
      'file': 'franchise_owner_dashboard_screen.dart',
      'title': 'Franchise Owner',
    },
    {
      'name': 'BillingAdminDashboardScreen',
      'route': 'FranchiseRoutes.billingAdminDashboard',
      'file': '05_U_billing_admin_dashboard_screen.dart',
      'title': 'Billing Admin',
    },
    {
      'name': 'CustomerSupportDashboardScreen',
      'route': 'SupportRoutes.customerSupportDashboard',
      'file': 'customer_support_dashboard_screen.dart',
      'title': 'Customer Support',
    },
    {
      'name': 'ClinicDashboardScreen',
      'route': 'CommonRoutes.clinicDashboard',
      'file': '05_U_clinic_dashboard_screen.dart',
      'title': 'Clinic Dashboard',
    },
    {
      'name': 'ComplianceManagerDashboardScreen',
      'route': 'CorporateRoutes.complianceManagerDashboard',
      'file': '05_U_compliance_manager_dashboard_screen.dart',
      'title': 'Compliance Manager',
    },
    {
      'name': 'ClinicClientProfileScreen',
      'route': 'CommonRoutes.clinicClientProfile',
      'file': 'clinic_client_profile_screen.dart',
      'title': 'Client Profile',
    },
    {
      'name': 'ClinicCarePlanScreen',
      'route': 'CommonRoutes.clinicCarePlan',
      'file': 'clinic_care_plan_screen.dart',
      'title': 'Care Plan',
    },
    {
      'name': 'ClinicIncidentReportScreen',
      'route': 'CommonRoutes.clinicIncidentReport',
      'file': 'clinic_incident_report_screen.dart',
      'title': 'Incident Report',
    },
    {
      'name': 'ClinicCheckInOutScreen',
      'route': 'CommonRoutes.clinicCheckInOut',
      'file': 'clinic_check_in_out_screen.dart',
      'title': 'Check In/Out',
    },
    {
      'name': 'ClinicDailyNotesScreen',
      'route': 'CommonRoutes.clinicDailyNotes',
      'file': 'clinic_daily_notes_screen.dart',
      'title': 'Daily Notes',
    },
    {
      'name': 'ClinicShiftDetailsScreen',
      'route': 'CommonRoutes.clinicShiftDetails',
      'file': 'clinic_shift_details_screen.dart',
      'title': 'Shift Details',
    },
    {
      'name': 'ClinicMyShiftsScreen',
      'route': 'CommonRoutes.clinicMyShifts',
      'file': 'clinic_my_shifts_screen.dart',
      'title': 'My Shifts',
    },
  ];

  final String basePath = 'lib/src/screens/offices/common';
  final dir = Directory(basePath);
  if (!await dir.exists()) {
    await dir.create(recursive: true);
  }

  for (var screen in screens) {
    final String content =
        '''import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_core/primecare_core.dart'; // Ensure correct import
import 'package:flutter_core/01_I_dashboard_service.dart';
import 'package:flutter_core/01_I_dashboard_providers.dart';
import 'package:primecare_ui/src/components/layouts/01_I_provider_layout.dart';
import 'package:primecare_ui/src/components/01_I_primecare_stat_card.dart';

class ${screen['name']} extends ConsumerWidget {
  const ${screen['name']}({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final metricsAsyncValue = ref.watch(dashboardMetricsProvider(${screen['route']}));

    return ProviderLayout(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${screen['title']}',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Real-time overview fetched natively via API.',
              style: TextStyle(color: Colors.white.withAlpha(178), fontSize: 16),
            ),
            const SizedBox(height: 32),
            
            metricsAsyncValue.when(
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(64.0),
                  child: CircularProgressIndicator(color: Colors.tealAccent),
                ),
              ),
              error: (error, stackTrace) => Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.redAccent.withAlpha(25),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.redAccent.withAlpha(76)),
                ),
                child: Row(
                  children: [
                    const Icon(LucideIcons.alertTriangle, color: Colors.redAccent),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        'Failed to load live metrics for ${screen['route']}: \\n\$error',
                        style: const TextStyle(color: Colors.redAccent),
                      ),
                    ),
                  ],
                ),
              ),
              data: (DashboardMetrics liveData) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GridView.count(
                      crossAxisCount: 4,
                      crossAxisSpacing: 24,
                      mainAxisSpacing: 24,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      childAspectRatio: 1.5,
                      children: liveData.kpis.map((kpi) {
                        return PrimeCareStatCard(
                          title: kpi.title,
                          value: kpi.value,
                          deltaSuffix: kpi.trend,
                          icon: _inferIcon(kpi.title),
                          iconColor: _inferColor(kpi.status),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 40),
            
                    // Recent Activities
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white.withAlpha(12),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.white.withAlpha(25)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Live Operations Feed',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 24),
                                if (liveData.recentActivity.isEmpty)
                                  const Center(
                                    child: Text(
                                      'No recent activity reported',
                                      style: TextStyle(color: Colors.white54),
                                    ),
                                  ),
                                ...liveData.recentActivity.map((activity) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 16.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                            color: Colors.white.withAlpha(12),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(LucideIcons.activity, color: Colors.tealAccent, size: 20),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                activity.title,
                                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
                                              ),
                                              Text(
                                                activity.subtitle,
                                                style: const TextStyle(color: Colors.white54, fontSize: 13),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Text(
                                          activity.timestamp,
                                          style: const TextStyle(color: Colors.white38, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 24),
                        Expanded(
                          flex: 1,
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.tealAccent.withAlpha(25),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(color: Colors.tealAccent.withAlpha(76)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'System Status',
                                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                        color: Colors.tealAccent,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                const SizedBox(height: 24),
                                _buildStatusRow(LucideIcons.server, 'Core API URL', 'Connected', Colors.greenAccent),
                                const SizedBox(height: 16),
                                _buildStatusRow(LucideIcons.database, 'Data Lake', 'Operational', Colors.greenAccent),
                                const SizedBox(height: 16),
                                _buildStatusRow(LucideIcons.shieldCheck, 'Live Sync', 'Active', Colors.blueAccent),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  IconData _inferIcon(String title) {
    final t = title.toLowerCase();
    if (t.contains('patient') || t.contains('client')) return LucideIcons.users;
    if (t.contains('revenue') || t.contains('payment') || t.contains('invoice')) return LucideIcons.dollarSign;
    if (t.contains('appointment') || t.contains('schedule')) return LucideIcons.calendar;
    if (t.contains('alert') || t.contains('critical')) return LucideIcons.alertCircle;
    if (t.contains('staff') || t.contains('provider') || t.contains('rpn')) return LucideIcons.stethoscope;
    if (t.contains('task') || t.contains('pipeline')) return LucideIcons.checkSquare;
    return LucideIcons.activity;
  }

  Color _inferColor(String status) {
    final s = status.toLowerCase();
    if (s == 'operational' || s == 'positive' || s == 'up') return Colors.greenAccent;
    if (s == 'warning' || s == 'attention') return Colors.orangeAccent;
    if (s == 'critical' || s == 'down' || s == 'negative') return Colors.redAccent;
    return Colors.tealAccent;
  }

  Widget _buildStatusRow(IconData icon, String label, String status, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 12),
        Text(label, style: const TextStyle(color: Colors.white, fontSize: 16)),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: color.withAlpha(51),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            status,
            style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}
''';

    final file = File('$basePath/${screen['file']}');
    await file.writeAsString(content);
    // print Statement Logged To Telemetry
  }
}
