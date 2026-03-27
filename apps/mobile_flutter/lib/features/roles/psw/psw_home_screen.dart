import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/features/roles/psw/providers/psw_dashboard_provider.dart';
import 'package:primecare_mobile/features/roles/psw/models/psw_dashboard_model.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

class PswHomeScreen extends ConsumerWidget {
  const PswHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Establish the functional binding to the Cloudflare Worker API
    final asyncDashboard = ref.watch(pswDashboardProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(
        child: asyncDashboard.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text(
                  'Failed to load dashboard: $error',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref.refresh(pswDashboardProvider),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          data: (dashboard) {
            // Calculate relative string for start time natively
            String timeText = 'Upcoming';
            if (dashboard.nextShift != null) {
              final diff = dashboard.nextShift!.startTime.difference(
                DateTime.now(),
              );
              if (diff.inHours > 0) {
                timeText = 'in ${diff.inHours}h ${diff.inMinutes % 60}m';
              } else if (diff.inMinutes > 0) {
                timeText = 'in ${diff.inMinutes} mins';
              } else {
                timeText = 'started';
              }
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Natively wire the fetched DB username
                  GreetingHeaderWidget(name: dashboard.userName),
                  const SizedBox(height: 24),

                  // Wire the shift data implicitly from Prisma DB
                  if (dashboard.nextShift != null)
                    NextShiftActionCard(
                      patientName: dashboard.nextShift!.patientName,
                      address: dashboard.nextShift!.address,
                      timeText: timeText,
                      badgeColor: Colors.blue,
                    )
                  else
                    const PrimeCard(
                      child: Center(child: Text('No upcoming shifts today.')),
                    ),

                  const SizedBox(height: 24),

                  // Progress populated correctly
                  Center(
                    child: DailyProgressRing(progress: dashboard.dailyProgress),
                  ),
                  const SizedBox(height: 24),

                  // Alerts securely fetched
                  if (dashboard.urgentAlert != null &&
                      dashboard.urgentAlert!.isNotEmpty)
                    UrgentAlertBanner(message: dashboard.urgentAlert!),

                  const SizedBox(height: 24),
                  PrimeButton(
                    label: 'View Full Schedule',
                    isOutline: true,
                    onPressed: () {
                      context.push('/psw/activities');
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
