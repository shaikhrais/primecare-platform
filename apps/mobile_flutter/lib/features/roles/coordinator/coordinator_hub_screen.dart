import 'package:flutter/material.dart';
import 'package:primecare_mobile/core/routing/app_routes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:primecare_ui/primecare_ui.dart';
import 'package:primecare_mobile/features/master/telemetry/universal_dashboard_provider.dart';

class CoordinatorHubScreen extends ConsumerWidget {
  const CoordinatorHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncStats = ref.watch(universalDashboardProvider('coordinator'));

    return Scaffold(
      appBar: AppBar(title: const Text('Dispatch Hub')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: asyncStats.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(24.0),
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (err, stack) => Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Error loading stats: $err',
                  style: const TextStyle(color: Colors.red),
                ),
              ),
              data: (stats) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildStatBox(
                        'Live PSWs',
                        (stats['livePsw']?.toString() ?? '0'),
                        Colors.blue,
                      ),
                      _buildStatBox(
                        'SOS Active',
                        (stats['sosActive']?.toString() ?? '0'),
                        Colors.red,
                      ),
                      _buildStatBox(
                        'Pending',
                        (stats['pendingMatches']?.toString() ?? '0'),
                        Colors.orange,
                      ),
                      _buildStatBox(
                        'Waitlist',
                        (stats['waitlistCount']?.toString() ?? '0'),
                        Colors.purple,
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SliverToBoxAdapter(child: LiveDispatchMap()),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Waitlist Kanban',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: KanbanWaitlistBoard(),
            ),
          ),
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Drag PSW to Assign:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: DragAssignWidget()),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: 60,
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.push('/coordinator/scheduler');
                  },
                  icon: const Icon(Icons.calendar_month, size: 28),
                  label: const Text(
                    'OPEN JANE CALENDAR MATRIX',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purpleAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  Widget _buildStatBox(String label, String value, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [

const SizedBox(height: 24),
PrimeCareQuickActionsGrid(
  sectionTitle: "Coordination Tools",
  actions: [
    PrimeCareActionItem(title: 'Shift Approvals', icon: Icons.check_circle, route: AppRoutes.coordinatorApprovals, color: Colors.green),
    PrimeCareActionItem(title: 'On-Call Mgmt', icon: Icons.phone_in_talk, route: AppRoutes.coordinatorCallin, color: Colors.orange),
    PrimeCareActionItem(title: 'Visit Adjustment', icon: Icons.edit_calendar, route: AppRoutes.coordinatorVisitAdjust, color: Color(0xFF1E88E5)),
    PrimeCareActionItem(title: 'Coordinator Inbox', icon: Icons.mail, route: AppRoutes.coordinatorInbox, color: Colors.blueGrey),
  ]
),

          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
