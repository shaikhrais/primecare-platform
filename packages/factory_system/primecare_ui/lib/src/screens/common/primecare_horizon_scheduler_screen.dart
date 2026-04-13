import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_core/flutter_core.dart';
import '../../components/scheduler/horizon_grid.dart';
import '../../components/cards/primecare_aura_card.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PrimeCareHorizonSchedulerScreen extends ConsumerWidget {
  const PrimeCareHorizonSchedulerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduleAsync = ref.watch(horizonScheduleProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: scheduleAsync.when(
        data: (schedule) => Row(
          children: [
            // Main Content Space
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header Area
                  _buildHeader(context),

                  // Horizon Grid
                  Expanded(child: HorizonGrid(schedule: schedule)),
                ],
              ),
            ),

            // Receptionist Control Sidebar (Glassmorphism)
            _buildSidebar(context, schedule),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, st) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.2),
        border: const Border(bottom: BorderSide(color: Colors.white10)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Institutional Horizon',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const Text(
                'Centralized Staff Matrix & Appointment Control',
                style: TextStyle(color: Colors.white38, fontSize: 12),
              ),
            ],
          ),
          Row(
            children: [
              _buildMetricButton(
                context,
                'Total Staff',
                '48',
                LucideIcons.users,
              ),
              const SizedBox(width: 12),
              _buildMetricButton(context, 'Waiting', '12', LucideIcons.clock),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMetricButton(
    BuildContext context,
    String label,
    String value,
    IconData icon,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.blueAccent),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Text(
                label,
                style: const TextStyle(color: Colors.white38, fontSize: 10),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSidebar(BuildContext context, HorizonSchedule schedule) {
    return Container(
      width: 320,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor.withValues(alpha: 0.4),
        border: const Border(left: BorderSide(color: Colors.white10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimeCareAuraCard(
              insights: [
                IntelligenceInsight(
                  id: 'res_cap_1',
                  title: 'Resource Optimization',
                  summary: 'Laser Alpha is idle. Room 102 available soon.',
                  impact: InsightImpact.info,
                ),
                IntelligenceInsight(
                  id: 'staff_1_p',
                  title: 'High Pressure Alert',
                  summary: 'Dr. Shaikh is over capacity.',
                  impact: InsightImpact.caution,
                ),
              ],
            ),
            const SizedBox(height: 32),

            // NEW: Institutional Capacity Monitor
            const Text(
              'INSTITUTIONAL CAPACITY',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white38,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(height: 16),
            ...schedule.resources.map((res) {
              final isAssigned = schedule.appointments.any(
                (a) =>
                    a.resourceId == res.id &&
                    a.startTime.isBefore(
                      DateTime.now().add(const Duration(minutes: 30)),
                    ) &&
                    a.endTime.isAfter(DateTime.now()),
              );

              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: isAssigned
                            ? const Color(0xFF6366F1).withValues(alpha: 0.1)
                            : Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        res.type == ResourceType.room
                            ? LucideIcons.home
                            : LucideIcons.zap,
                        size: 14,
                        color: isAssigned
                            ? const Color(0xFF6366F1)
                            : Colors.white24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            res.name,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isAssigned
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isAssigned ? Colors.white : Colors.white60,
                            ),
                          ),
                          Text(
                            isAssigned ? 'In Use' : 'Ready',
                            style: TextStyle(
                              fontSize: 9,
                              color: isAssigned
                                  ? const Color(
                                      0xFF6366F1,
                                    ).withValues(alpha: 0.7)
                                  : Colors.greenAccent.withValues(alpha: 0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),

            const SizedBox(height: 40),
            Text(
              'Unassigned Queue',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return _buildQueueItem(context, index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQueueItem(BuildContext context, int index) {
    final patients = [
      'John Doe',
      'Sarah Connor',
      'Kyle Reese',
      'James Wilson',
      'Ellen Ripley',
    ];
    final patient = patients[index % patients.length];

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.03),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.blueAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              LucideIcons.user,
              size: 18,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
                const Text(
                  'Waiting: 15m',
                  style: TextStyle(color: Colors.white38, fontSize: 11),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              LucideIcons.plusCircle,
              size: 20,
              color: Colors.white30,
            ),
          ),
        ],
      ),
    );
  }
}
