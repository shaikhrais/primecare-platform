import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:primecare_psw/src/core/api/api_client.dart';
import 'package:primecare_psw/src/core/providers/auth_provider.dart';
import 'package:primecare_psw/src/core/theme/app_theme.dart';

/// Today's schedule provider
final todayScheduleProvider = FutureProvider<List<dynamic>>((ref) async {
  final api = ref.read(apiClientProvider);
  return api.getTodaySchedule();
});

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authStateProvider);
    final scheduleAsync = ref.watch(todayScheduleProvider);
    final now = DateTime.now();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Hello, ${auth.fullName.split(' ').first} 👋',
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            Text(DateFormat('EEEE, MMMM d').format(now),
                style: TextStyle(
                    fontSize: 12,
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.5))),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(todayScheduleProvider.future),
        child: scheduleAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => _buildEmptyState(context),
          data: (shifts) => shifts.isEmpty
              ? _buildEmptyState(context)
              : _buildShiftList(context, shifts),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.event_available,
              size: 64,
              color: Theme.of(context)
                  .colorScheme
                  .onSurface
                  .withValues(alpha: 0.2)),
          const SizedBox(height: 16),
          Text('No shifts today',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.4))),
          const SizedBox(height: 8),
          Text('Enjoy your day off! 🌤️',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurface
                      .withValues(alpha: 0.3))),
        ],
      ),
    );
  }

  Widget _buildShiftList(BuildContext context, List<dynamic> shifts) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: shifts.length + 1, // +1 for header
      itemBuilder: (context, index) {
        if (index == 0) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Row(
              children: [
                Icon(Icons.medical_services, color: AppTheme.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                    '${shifts.length} visit${shifts.length == 1 ? '' : 's'} today',
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
          );
        }

        final shift = shifts[index - 1];
        final startTime = shift['requestedStartAt'] != null
            ? DateFormat('h:mm a')
                .format(DateTime.parse(shift['requestedStartAt']))
            : 'TBD';
        final clientName = shift['client']?['fullName'] ?? 'Unknown Client';
        final serviceName = shift['service']?['name'] ?? 'General Care';
        final status = shift['status'] ?? 'scheduled';

        return Card(
          margin: const EdgeInsets.only(bottom: 12),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () => context.go('/visit/${shift['id']}'),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  // Time column
                  Container(
                    width: 60,
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Text(startTime.split(' ')[0],
                            style: const TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 14)),
                        Text(
                            startTime.split(' ').length > 1
                                ? startTime.split(' ')[1]
                                : '',
                            style: TextStyle(
                                fontSize: 10, color: AppTheme.primary)),
                      ],
                    ),
                  ),
                  const SizedBox(width: 14),
                  // Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(clientName,
                            style: const TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 15)),
                        const SizedBox(height: 4),
                        Text(serviceName,
                            style: TextStyle(
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurface
                                    .withValues(alpha: 0.5),
                                fontSize: 13)),
                      ],
                    ),
                  ),
                  // Status chip
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: _statusColor(status).withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(status.toUpperCase(),
                        style: TextStyle(
                            color: _statusColor(status),
                            fontSize: 10,
                            fontWeight: FontWeight.w800)),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.chevron_right,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.3)),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'in_progress':
        return AppTheme.info;
      case 'completed':
        return AppTheme.success;
      case 'cancelled':
        return AppTheme.error;
      default:
        return AppTheme.warning;
    }
  }
}
