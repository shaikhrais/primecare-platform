// Governance - Category: service | Purpose: Core implementation file for the Live Dispatch Map platform logic.
import 'package:primecare_ui/primecare_ui.dart';

// --- MVC State Model ---
class LiveDispatchMapState {
  final List<Map<String, dynamic>> activeVisits;
  final List<Map<String, dynamic>> unassignedShifts;
  final String? selectedShiftId;
  final bool isAssigning;
  final String searchQuery;
  final String activeFilter;

  const LiveDispatchMapState({
    required this.activeVisits,
    required this.unassignedShifts,
    this.selectedShiftId,
    required this.isAssigning,
    required this.searchQuery,
    required this.activeFilter,
  });

  LiveDispatchMapState copyWith({
    List<Map<String, dynamic>>? activeVisits,
    List<Map<String, dynamic>>? unassignedShifts,
    String? selectedShiftId,
    bool? isAssigning,
    String? searchQuery,
    String? activeFilter,
  }) {
    return LiveDispatchMapState(
      activeVisits: activeVisits ?? this.activeVisits,
      unassignedShifts: unassignedShifts ?? this.unassignedShifts,
      selectedShiftId: selectedShiftId ?? this.selectedShiftId,
      isAssigning: isAssigning ?? this.isAssigning,
      searchQuery: searchQuery ?? this.searchQuery,
      activeFilter: activeFilter ?? this.activeFilter,
    );
  }
}

// --- Controller ---
class LiveDispatchMapController extends StateNotifier<LiveDispatchMapState> {
  final Ref _ref;

  LiveDispatchMapController(this._ref)
      : super(
          const LiveDispatchMapState(
            activeVisits: [
              {
                'id': 'v-101',
                'caregiver': 'Sarah Jenkins, PSW',
                'client': 'Margaret Thompson',
                'status': 'active',
                'statusText': 'In Progress',
                'checkIn': '08:30 AM',
                'gpsVariance': '0.05 mi (Within limit)',
                'severity': 'success',
                'lat': 43.6532,
                'lng': -79.3832,
              },
              {
                'id': 'v-102',
                'caregiver': 'David Miller, RPN',
                'client': 'James Wilson',
                'status': 'delayed',
                'statusText': 'Delayed 18 mins',
                'checkIn': 'Pending',
                'gpsVariance': '1.2 mi (Out of bounds)',
                'severity': 'warning',
                'lat': 43.6601,
                'lng': -79.3905,
              },
              {
                'id': 'v-103',
                'caregiver': 'Elena Rostova, RN',
                'client': 'Sophie Leblanc',
                'status': 'active',
                'statusText': 'In Progress',
                'checkIn': '09:15 AM',
                'gpsVariance': '0.12 mi (Within limit)',
                'severity': 'success',
                'lat': 43.6450,
                'lng': -79.3750,
              },
            ],
            unassignedShifts: [
              {
                'id': 's-501',
                'client': 'Robert Davis',
                'time': '10:30 AM - 12:30 PM',
                'roleRequired': 'PSW Needed',
                'location': 'Metro Downtown Care Center',
              },
              {
                'id': 's-502',
                'client': 'Patricia Garcia',
                'time': '01:00 PM - 04:00 PM',
                'roleRequired': 'RN Needed',
                'location': 'North York Heights Home',
              },
            ],
            selectedShiftId: null,
            isAssigning: false,
            searchQuery: '',
            activeFilter: 'all',
          ),
        );

  void selectShift(String? shiftId) {
    state = state.copyWith(selectedShiftId: shiftId);
  }

  void updateSearch(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void updateFilter(String filter) {
    state = state.copyWith(activeFilter: filter);
  }

  void assignCaregiver(String shiftId, String caregiverName) {
    state = state.copyWith(isAssigning: true);

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/live_dispatch_map',
            eventType: 'dispatch_shift_assigned',
            metadata: {'shiftId': shiftId, 'caregiver': caregiverName},
          );
    } catch (_) {}

    Future.delayed(const Duration(milliseconds: 500), () {
      final shift = state.unassignedShifts.firstWhere((s) => s['id'] == shiftId);
      final newVisit = {
        'id': 'v-${DateTime.now().millisecondsSinceEpoch}',
        'caregiver': caregiverName,
        'client': shift['client'],
        'status': 'active',
        'statusText': 'Dispatched',
        'checkIn': 'Just Now',
        'gpsVariance': '0.0 mi (Initializing)',
        'severity': 'info',
        'lat': 43.6532,
        'lng': -79.3832,
      };

      state = state.copyWith(
        isAssigning: false,
        selectedShiftId: null,
        unassignedShifts: state.unassignedShifts.where((s) => s['id'] != shiftId).toList(),
        activeVisits: [newVisit, ...state.activeVisits],
      );
    });
  }

  void reRouteVisit(String visitId) {
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/generated/live_dispatch_map',
            eventType: 'dispatch_reroute_triggered',
            metadata: {'visitId': visitId},
          );
    } catch (_) {}

    final updated = state.activeVisits.map((v) {
      if (v['id'] == visitId) {
        return {
          ...v,
          'status': 'active',
          'statusText': 'Re-routed / Active',
          'gpsVariance': '0.1 mi (Re-centered)',
          'severity': 'success',
        };
      }
      return v;
    }).toList();

    state = state.copyWith(activeVisits: updated);
  }
}

// --- Provider ---
final liveDispatchMapControllerProvider =
    StateNotifierProvider<LiveDispatchMapController, LiveDispatchMapState>((ref) {
  return LiveDispatchMapController(ref);
});

// --- View ---
class LiveDispatchMap extends GovernedConsumerWidget {
  const LiveDispatchMap({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(liveDispatchMapControllerProvider);
    final controller = ref.read(liveDispatchMapControllerProvider.notifier);
    final theme = context.theme;

    final filteredVisits = state.activeVisits.where((v) {
      final matchesSearch = (v['caregiver'] as String).toLowerCase().contains(state.searchQuery.toLowerCase()) ||
          (v['client'] as String).toLowerCase().contains(state.searchQuery.toLowerCase());
      if (state.activeFilter == 'all') return matchesSearch;
      return matchesSearch && v['status'] == state.activeFilter;
    }).toList();

    return Scaffold(
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Row(
          children: [
            Icon(LucideIcons.map, color: theme.colors.primary),
            const SizedBox(width: 12),
            Text(
              'Live Operations Dispatch Control',
              style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
            ),
          ],
        ),
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Sidebar: Roster Control & Alert center
          Expanded(
            flex: 4,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Real-Time Dispatch Center',
                    style: theme.typography.h2.copyWith(color: theme.colors.onSurface),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Daily Operations: GPS checks and shift matching.',
                    style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                  ),
                  const SizedBox(height: 24),

                  // Search and Filters Segment
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search caregiver or client...',
                            prefixIcon: const Icon(LucideIcons.search, size: 20),
                            fillColor: theme.colors.surface,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(theme.radiusMd),
                              borderSide: BorderSide(color: theme.colors.border),
                            ),
                          ),
                          onChanged: controller.updateSearch,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      _buildFilterChip(context, 'All Active', 'all', state.activeFilter, controller.updateFilter),
                      const SizedBox(width: 8),
                      _buildFilterChip(context, 'In Progress', 'active', state.activeFilter, controller.updateFilter),
                      const SizedBox(width: 8),
                      _buildFilterChip(context, 'Delayed', 'delayed', state.activeFilter, controller.updateFilter),
                    ],
                  ),
                  const SizedBox(height: 24),

                  // Live Alerts List
                  Text(
                    'Operational Tracking Roster (${filteredVisits.length})',
                    style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                  ),
                  const SizedBox(height: 12),
                  ...filteredVisits.map((visit) {
                    final isWarning = visit['status'] == 'delayed';
                    return Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(theme.radiusMd),
                        border: Border.all(
                          color: isWarning ? Colors.amber.shade300 : theme.colors.border,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.02),
                            blurRadius: 6,
                            offset: const Offset(0, 3),
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                (visit['caregiver'] as String),
                                style: theme.typography.bodyLarge.copyWith(
                                  color: theme.colors.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: isWarning
                                      ? Colors.amber.shade50
                                      : theme.colors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(theme.radiusSm),
                                ),
                                child: Text(
                                  (visit['statusText'] as String),
                                  style: theme.typography.labelBold.copyWith(
                                    color: isWarning ? Colors.amber.shade900 : theme.colors.primary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Assigned Client: ${visit['client']}',
                            style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              const Icon(LucideIcons.navigation, size: 14, color: Colors.blue),
                              const SizedBox(width: 6),
                              Text(
                                'Telemetry: ${visit['gpsVariance']}',
                                style: theme.typography.labelMedium.copyWith(color: theme.colors.onSurfaceVariant),
                              ),
                            ],
                          ),
                          if (isWarning) ...[
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                OutlinedButton.icon(
                                  icon: const Icon(LucideIcons.phoneCall, size: 14),
                                  label: const Text('Call Staff'),
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton.icon(
                                  icon: const Icon(LucideIcons.compass, size: 14),
                                  label: const Text('Re-Route'),
                                  onPressed: () => controller.reRouteVisit((visit['id'] as String)),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colors.primary,
                                    foregroundColor: theme.colors.onPrimary,
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ],
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Central Visualizer Grid & Unassigned Queue Panel
          Expanded(
            flex: 5,
            child: Container(
              color: theme.colors.surface.withValues(alpha: 0.4),
              child: Column(
                children: [
                  // Mock Proximity map display (Aesthetic grid)
                  Expanded(
                    flex: 6,
                    child: Container(
                      margin: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: theme.colors.border),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Stack(
                          children: [
                            // Custom grid overlay to simulate geographic lines
                            Positioned.fill(
                              child: CustomPaint(
                                painter: GridMapPainter(theme.colors.border),
                              ),
                            ),
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: RadialGradient(
                                    colors: [
                                      theme.colors.primary.withValues(alpha: 0.05),
                                      Colors.transparent
                                    ],
                                    radius: 1.2,
                                  ),
                                ),
                              ),
                            ),
                            // Simulated Markers
                            ...state.activeVisits.map((v) {
                              final isWarning = v['status'] == 'delayed';
                              return Positioned(
                                left: ((v['lat'] as double) - 43.64) * 2000,
                                top: ((v['lng'] as double) + 79.40) * 2000,
                                child: Tooltip(
                                  message: '${v['caregiver']} matches ${v['client']}',
                                  child: Column(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.all(4),
                                        decoration: BoxDecoration(
                                          color: isWarning ? Colors.amber : theme.colors.primary,
                                          shape: BoxShape.circle,
                                          border: Border.all(color: Colors.white, width: 2),
                                          boxShadow: const [
                                            BoxShadow(color: Colors.black26, blurRadius: 4)
                                          ],
                                        ),
                                        child: Icon(
                                          isWarning ? LucideIcons.alertTriangle : LucideIcons.userCheck,
                                          size: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: Colors.black87,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          (v['client'] as String),
                                          style: const TextStyle(color: Colors.white, fontSize: 10),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                            Positioned(
                              bottom: 16,
                              right: 16,
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                decoration: BoxDecoration(
                                  color: Colors.black87,
                                  borderRadius: BorderRadius.circular(theme.radiusSm),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: const BoxDecoration(
                                          color: Colors.green, shape: BoxShape.circle),
                                    ),
                                    const SizedBox(width: 8),
                                    const Text(
                                      'Telemetry Hub Online',
                                      style: TextStyle(color: Colors.white, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Unassigned Shifts Queue (Bottom drawer simulation)
                  Expanded(
                    flex: 4,
                    child: Container(
                      decoration: BoxDecoration(
                        color: theme.colors.surface,
                        border: Border(top: BorderSide(color: theme.colors.border, width: 2)),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Weekly Unassigned Shifts Queue',
                                style: theme.typography.h4.copyWith(color: theme.colors.onSurface),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: Colors.red.shade50,
                                  borderRadius: BorderRadius.circular(theme.radiusSm),
                                ),
                                child: Text(
                                  '${state.unassignedShifts.length} PENDING MATCH',
                                  style: theme.typography.labelBold.copyWith(color: Colors.red),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: state.unassignedShifts.length,
                              itemBuilder: (context, index) {
                                final shift = state.unassignedShifts[index];
                                final isSelected = state.selectedShiftId == shift['id'];

                                return Container(
                                  width: 280,
                                  margin: const EdgeInsets.only(right: 16, bottom: 4),
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: theme.colors.surface,
                                    borderRadius: BorderRadius.circular(theme.radiusMd),
                                    border: Border.all(
                                      color: isSelected ? theme.colors.primary : theme.colors.border,
                                      width: isSelected ? 2 : 1,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.01),
                                        blurRadius: 4,
                                        offset: const Offset(0, 2),
                                      )
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            (shift['client'] as String),
                                            style: theme.typography.bodyLarge.copyWith(
                                              fontWeight: FontWeight.bold,
                                              color: theme.colors.onSurface,
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                            decoration: BoxDecoration(
                                              color: theme.colors.onSurface.withValues(alpha: 0.05),
                                              borderRadius: BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              (shift['roleRequired'] as String),
                                              style: theme.typography.labelMedium.copyWith(color: theme.colors.primary),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                      Text(
                                        (shift['time'] as String),
                                        style: theme.typography.bodyMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        (shift['location'] as String),
                                        style: theme.typography.labelMedium.copyWith(color: theme.colors.onSurfaceVariant),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const Spacer(),
                                      SizedBox(
                                        width: double.infinity,
                                        child: state.isAssigning && isSelected
                                            ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
                                            : ElevatedButton(
                                                onPressed: isSelected
                                                    ? () => controller.assignCaregiver((shift['id'] as String), 'Grace Hopper, PSW')
                                                    : () => controller.selectShift((shift['id'] as String?)),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: isSelected
                                                      ? Colors.green
                                                      : theme.colors.primary,
                                                  foregroundColor: Colors.white,
                                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                                ),
                                                child: Text(isSelected ? 'Assign Grace PSW' : 'Select to Match'),
                                              ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    BuildContext context,
    String label,
    String filterValue,
    String activeFilter,
    ValueChanged<String> onSelected,
  ) {
    final theme = context.theme;
    final isSelected = activeFilter == filterValue;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) => onSelected(filterValue),
      selectedColor: theme.colors.primary.withValues(alpha: 0.15),
      backgroundColor: theme.colors.surface,
      labelStyle: theme.typography.labelBold.copyWith(
        color: isSelected ? theme.colors.primary : theme.colors.onSurfaceVariant,
      ),
    );
  }
}

// --- Custom Grid Painter for simulated Map lines ---
class GridMapPainter extends CustomPainter {
  final Color lineColor;

  GridMapPainter(this.lineColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor.withValues(alpha: 0.5)
      ..strokeWidth = 1.0;

    const double gap = 40.0;

    for (double x = 0; x < size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
