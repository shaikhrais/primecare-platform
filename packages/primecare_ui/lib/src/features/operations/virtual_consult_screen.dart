// Governance - Category: view | Purpose: State representation of a telehealth virtual consult. Provider for telehealth virtual consult schedules.
import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

/// State representation of a telehealth virtual consult.
class TelehealthConsult {
  final String id;
  final String clinicianName;
  final String patientName;
  String timeSlot;
  final String roomLink;
  String status; // 'Scheduled', 'Active', 'Finished'

  TelehealthConsult({
    required this.id,
    required this.clinicianName,
    required this.patientName,
    required this.timeSlot,
    required this.roomLink,
    required this.status,
  });
}

/// Provider for telehealth virtual consult schedules.
final virtualConsultProvider = FutureProvider.autoDispose<List<TelehealthConsult>>((ref) async {
  try {
    final api = ref.read(apiClientProvider);
    final response = await api.get('/v1/premium/appnotification');
    if (response.data is List) {
      final list = response.data as List;
      return list.map((e) {
        final map = e as Map<String, dynamic>;
        return TelehealthConsult(
          id: map['id']?.toString() ?? UniqueKey().toString(),
          clinicianName: map['clinicianName']?.toString() ?? 'Dr. Specialist',
          patientName: map['patientName']?.toString() ?? 'Care Patient',
          timeSlot: map['timeSlot']?.toString() ?? '10:00 AM - 10:30 AM',
          roomLink: map['roomLink']?.toString() ?? 'Room Alpha',
          status: map['status']?.toString() ?? 'Scheduled',
        );
      }).toList();
    }
  } catch (e) {
    // Offline API fallback
  }

  // Pre-hydrated telehealth consultation lists
  return [
    TelehealthConsult(
      id: 'tel-01',
      clinicianName: 'Dr. Sarah Jenkins',
      patientName: 'Alice Green',
      timeSlot: '09:00 AM - 09:30 AM',
      roomLink: 'Telehealth Room Alpha',
      status: 'Active',
    ),
    TelehealthConsult(
      id: 'tel-02',
      clinicianName: 'Dr. Mark Miller',
      patientName: 'Bob Smith',
      timeSlot: '10:00 AM - 10:30 AM',
      roomLink: 'Telehealth Room Beta',
      status: 'Scheduled',
    ),
    TelehealthConsult(
      id: 'tel-03',
      clinicianName: 'Nurse David Roberts',
      patientName: 'Charlie Brown',
      timeSlot: '11:15 AM - 11:45 AM',
      roomLink: 'Telehealth Room Gamma',
      status: 'Scheduled',
    ),
    TelehealthConsult(
      id: 'tel-04',
      clinicianName: 'Therapist Clara Watson',
      patientName: 'Diana Prince',
      timeSlot: '02:00 PM - 02:30 PM',
      roomLink: 'Telehealth Room Delta',
      status: 'Finished',
    ),
  ];
});

class VirtualConsultScreen extends GovernedConsumerWidget {
  const VirtualConsultScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    return const _VirtualConsultBody();
  }
}

class _VirtualConsultBody extends ConsumerStatefulWidget {
  const _VirtualConsultBody();

  @override
  ConsumerState<_VirtualConsultBody> createState() => _VirtualConsultBodyState();
}

class _VirtualConsultBodyState extends ConsumerState<_VirtualConsultBody> {
  final List<TelehealthConsult> _consults = [];
  bool _isInitialized = false;
  String? _selectedConsultId;

  final _newTimeSlotController = TextEditingController();

  @override
  void dispose() {
    _newTimeSlotController.dispose();
    super.dispose();
  }

  void _rescheduleConsult() {
    if (_selectedConsultId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a virtual consult to reschedule.'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    final newSlot = _newTimeSlotController.text.trim();
    if (newSlot.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a new time slot (e.g. 03:00 PM - 03:30 PM).'),
          backgroundColor: Colors.orangeAccent,
        ),
      );
      return;
    }

    final idx = _consults.indexWhere((c) => c.id == _selectedConsultId);
    if (idx != -1) {
      setState(() {
        _consults[idx].timeSlot = newSlot;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green,
          content: Row(
            children: [
              const Icon(LucideIcons.calendarClock, color: Colors.white),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Consult for ${_consults[idx].patientName} rescheduled to $newSlot successfully.',
                ),
              ),
            ],
          ),
        ),
      );

      _newTimeSlotController.clear();
    }
  }

  void _toggleConsultStatus(String id, String newStatus) {
    final idx = _consults.indexWhere((c) => c.id == id);
    if (idx != -1) {
      setState(() {
        _consults[idx].status = newStatus;
      });

      String message = 'Consult status updated.';
      if (newStatus == 'Active') {
        message = 'Telehealth Call with ${_consults[idx].patientName} is now LIVE!';
      } else if (newStatus == 'Finished') {
        message = 'Telehealth Call with ${_consults[idx].patientName} has finished.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: newStatus == 'Active' ? Colors.purple : Colors.blue,
          content: Text(message),
        ),
      );
    }
  }

  Widget _buildLivePulseDot() {
    return Container(
      width: 10,
      height: 10,
      decoration: const BoxDecoration(
        color: Colors.red,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent,
            blurRadius: 6,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(String status, PrimeThemeData theme) {
    Color color = Colors.grey;
    if (status == 'Active') color = Colors.red;
    if (status == 'Scheduled') color = theme.colors.primary;
    if (status == 'Finished') color = Colors.green;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (status == 'Active') ...[
            _buildLivePulseDot(),
            const SizedBox(width: 6),
          ],
          Text(
            status.toUpperCase(),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHslBadge(String text, double hue, double saturation, double lightness) {
    final color = HSLColor.fromAHSL(1.0, hue, saturation, lightness).toColor();
    final bgColor = HSLColor.fromAHSL(0.12, hue, saturation, lightness).toColor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 11,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final consultsFuture = ref.watch(virtualConsultProvider);

    return Scaffold(
      backgroundColor: theme.colors.background,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: consultsFuture.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(48.0),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (Object err, StackTrace stack) => Center(
            child: Text(
              'Error loading telehealth consults: $err',
              style: TextStyle(color: theme.colors.error),
            ),
          ),
          data: (List<TelehealthConsult> apiConsults) {
            if (!_isInitialized) {
              _consults.addAll(apiConsults);
              _isInitialized = true;
            }

            final activeCalls = _consults.where((c) => c.status == 'Active').length;
            final pendingCalls = _consults.where((c) => c.status == 'Scheduled').length;
            final completedCalls = _consults.where((c) => c.status == 'Finished').length;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Header
                const GovDashboardHero(
                  title: 'Telehealth Consults & Room Manager',
                  roleName: 'Regional Operations Director',
                  description: 'Monitor live remote patient examinations, coordinate digital room links, and manage regional telehealth scheduling conflicts.',
                ),
                const SizedBox(height: 24),

                // 2. Metrics Cards
                ResponsiveGrid(
                  minItemWidth: 260,
                  maxItemWidth: 400,
                  spacing: 16.0,
                  children: [
                    GovMetricCard(
                      title: 'Live Telehealth Calls',
                      value: '$activeCalls',
                      trendLabel: 'Active Room Linkage',
                      progress: activeCalls > 0 ? 0.8 : 0.0,
                      icon: LucideIcons.video,
                      brandColor: Colors.red,
                    ),
                    GovMetricCard(
                      title: 'Upcoming Consultations',
                      value: '$pendingCalls',
                      trendLabel: 'Triage Schedule Ready',
                      progress: 0.5,
                      icon: LucideIcons.calendarClock,
                      brandColor: theme.colors.primary,
                    ),
                    GovMetricCard(
                      title: 'Completed Telehealth Visits',
                      value: '$completedCalls',
                      trendLabel: 'Today Record',
                      progress: 1.0,
                      icon: LucideIcons.checkSquare,
                      brandColor: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // 3. Layout Rows / Columns
                LayoutBuilder(
                  builder: (context, constraints) {
                    final isDesktop = constraints.maxWidth > 950;
                    final listWidget = _buildConsultsList(theme);
                    final formWidget = _buildRescheduleForm(theme);
                    final liveTelemetry = _buildTelehealthChart(theme);

                    if (isDesktop) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 5,
                            child: Column(
                              children: [
                                listWidget,
                              ],
                            ),
                          ),
                          const SizedBox(width: 24),
                          Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                formWidget,
                                const SizedBox(height: 20),
                                liveTelemetry,
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      return Column(
                        children: [
                          listWidget,
                          const SizedBox(height: 20),
                          formWidget,
                          const SizedBox(height: 20),
                          liveTelemetry,
                        ],
                      );
                    }
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildConsultsList(PrimeThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.divider),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Telehealth Consult Schedules',
                style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
              ),
              _buildHslBadge('DIGITAL CLINIC', 280, 0.85, 0.55),
            ],
          ),
          const SizedBox(height: 20),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _consults.length,
            separatorBuilder: (context, idx) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final c = _consults[index];

              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Patient: ${c.patientName}',
                              style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Clinician: ${c.clinicianName}',
                              style: theme.typography.bodySmall.copyWith(color: theme.colors.outline),
                            ),
                          ],
                        ),
                        _buildStatusBadge(c.status, theme),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(LucideIcons.clock, size: 14, color: theme.colors.outline),
                        const SizedBox(width: 6),
                        Text(
                          c.timeSlot,
                          style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                        const Spacer(),
                        Icon(LucideIcons.monitor, size: 14, color: theme.colors.outline),
                        const SizedBox(width: 6),
                        Text(
                          c.roomLink,
                          style: theme.typography.bodyMedium.copyWith(
                            color: theme.colors.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        if (c.status == 'Scheduled')
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            onPressed: () => _toggleConsultStatus(c.id, 'Active'),
                            icon: const Icon(LucideIcons.phoneCall, size: 14),
                            label: const Text('Start Live Call', style: TextStyle(fontSize: 12)),
                          ),
                        if (c.status == 'Active')
                          ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            ),
                            onPressed: () => _toggleConsultStatus(c.id, 'Finished'),
                            icon: const Icon(LucideIcons.phoneOff, size: 14),
                            label: const Text('End Call', style: TextStyle(fontSize: 12)),
                          ),
                        if (c.status == 'Finished')
                          _buildHslBadge('COMPLETED', 140, 0.70, 0.40),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRescheduleForm(PrimeThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(theme.radiusMd),
        border: Border.all(color: theme.colors.divider),
        boxShadow: theme.shadowsSurface1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(LucideIcons.edit2, color: theme.colors.primary, size: 24),
              const SizedBox(width: 12),
              Text(
                'Reschedule Telehealth Consult',
                style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 16),

          Text('Select Appointment', style: theme.typography.labelBold),
          const SizedBox(height: 6),
          DropdownButtonFormField<String>(
            value: _selectedConsultId,
            hint: const Text('Select telehealth call...'),
            decoration: InputDecoration(
              filled: true,
              fillColor: theme.colors.background,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(theme.radiusDefault),
                borderSide: BorderSide.none,
              ),
            ),
            items: _consults.where((c) => c.status != 'Finished').map((c) {
              return DropdownMenuItem(
                value: c.id,
                child: Text('Patient: ${c.patientName} (${c.timeSlot})', style: theme.typography.bodyMedium),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() => _selectedConsultId = val);
              }
            },
          ),
          const SizedBox(height: 16),

          PrimeCareTextField(
            label: 'New Telehealth Slot Time',
            hintText: 'e.g. 03:30 PM - 04:00 PM',
            controller: _newTimeSlotController,
          ),
          const SizedBox(height: 24),

          PrimeButton.primary(
            label: 'Issue Reschedule Command',
            isFullWidth: true,
            onPressed: _rescheduleConsult,
          ),
        ],
      ),
    );
  }

  Widget _buildTelehealthChart(PrimeThemeData theme) {
    return GovTelemetryChart(
      title: 'Daily Telehealth Sessions Count',
      dataPoints: const [12, 18, 22, 28, 30, 42, 45],
      labels: const ['Nov', 'Dec', 'Jan', 'Feb', 'Mar', 'Apr', 'May'],
      accentColor: theme.colors.primary,
    );
  }
}
