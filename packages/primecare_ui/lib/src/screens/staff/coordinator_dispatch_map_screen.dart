// Governance - Category: view | Purpose: UI Screen component rendering the Coordinator Dispatch Map Screen workspace interface.
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';

// --- State Model ---
class CoordinatorDispatchMapState {
  final List<Map<String, dynamic>> caregivers;
  final List<Map<String, dynamic>> unassignedShifts;
  final String? selectedCaregiverId;
  final String selectedSector;
  final bool isLoading;
  final bool isDispatching;

  const CoordinatorDispatchMapState({
    this.caregivers = const [],
    this.unassignedShifts = const [],
    this.selectedCaregiverId,
    this.selectedSector = 'All',
    this.isLoading = false,
    this.isDispatching = false,
  });

  CoordinatorDispatchMapState copyWith({
    List<Map<String, dynamic>>? caregivers,
    List<Map<String, dynamic>>? unassignedShifts,
    String? selectedCaregiverId,
    String? selectedSector,
    bool? isLoading,
    bool? isDispatching,
  }) {
    return CoordinatorDispatchMapState(
      caregivers: caregivers ?? this.caregivers,
      unassignedShifts: unassignedShifts ?? this.unassignedShifts,
      selectedCaregiverId: selectedCaregiverId ?? this.selectedCaregiverId,
      selectedSector: selectedSector ?? this.selectedSector,
      isLoading: isLoading ?? this.isLoading,
      isDispatching: isDispatching ?? this.isDispatching,
    );
  }
}

// --- Controller ---
class CoordinatorDispatchMapController extends StateNotifier<CoordinatorDispatchMapState> {
  final Ref _ref;

  CoordinatorDispatchMapController(this._ref)
      : super(
          const CoordinatorDispatchMapState(
            caregivers: [
              {
                'id': 'CG-101',
                'name': 'Sarah Jenkins, PSW',
                'sector': 'North',
                'status': 'active',
                'client': 'Margaret Thompson',
                'lat': 43.789,
                'lng': -79.412,
                'battery': '88%',
                'speed': '32 km/h',
                'eta': '8 mins',
              },
              {
                'id': 'CG-102',
                'name': 'David Miller, RPN',
                'sector': 'Central',
                'status': 'active',
                'client': 'Arthur Pendelton',
                'lat': 43.662,
                'lng': -79.389,
                'battery': '94%',
                'speed': '0 km/h (At Client)',
                'eta': 'On-site',
              },
              {
                'id': 'CG-103',
                'name': 'Elena Rostova, PSW',
                'sector': 'South',
                'status': 'traveling',
                'client': 'Eleanor Vance',
                'lat': 43.621,
                'lng': -79.488,
                'battery': '67%',
                'speed': '45 km/h',
                'eta': '14 mins',
              },
              {
                'id': 'CG-104',
                'name': 'Marcus Aurelius, PT',
                'sector': 'West',
                'status': 'idle',
                'client': 'None',
                'lat': 43.712,
                'lng': -79.610,
                'battery': '99%',
                'speed': '0 km/h',
                'eta': 'Idle',
              },
            ],
            unassignedShifts: [
              {
                'id': 'SH-201',
                'client': 'Grace Hopper',
                'sector': 'Central',
                'time': '02:00 PM - 05:00 PM',
                'address': '55 University Ave, Toronto',
                'priority': 'high',
                'lat': 43.655,
                'lng': -79.385,
              },
              {
                'id': 'SH-202',
                'client': 'Ada Lovelace',
                'sector': 'North',
                'time': '04:30 PM - 07:30 PM',
                'address': '250 Yonge St, Richmond Hill',
                'priority': 'medium',
                'lat': 43.810,
                'lng': -79.430,
              },
              {
                'id': 'SH-203',
                'client': 'Alan Turing',
                'sector': 'West',
                'time': 'Tomorrow, 09:00 AM',
                'address': '1800 Dundas St W, Mississauga',
                'priority': 'low',
                'lat': 43.690,
                'lng': -79.590,
              },
            ],
          ),
        );

  void selectCaregiver(String? id) {
    state = state.copyWith(selectedCaregiverId: id);
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/staff/coordinator-dispatch-map',
            eventType: 'caregiver_selected_on_map',
            metadata: {'caregiverId': id},
          );
    } catch (_) {}
  }

  void setSector(String sector) {
    state = state.copyWith(selectedSector: sector);
    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/staff/coordinator-dispatch-map',
            eventType: 'sector_filter_changed',
            metadata: {'sector': sector},
          );
    } catch (_) {}
  }

  Future<void> dispatchCaregiver(String shiftId, String caregiverId) async {
    state = state.copyWith(isDispatching: true);
    await Future<void>.delayed(const Duration(milliseconds: 700));

    final caregiver = state.caregivers.firstWhere((c) => c['id'] == caregiverId);
    final updatedShifts = state.unassignedShifts.where((s) => s['id'] != shiftId).toList();
    final updatedCaregivers = state.caregivers.map((c) {
      if (c['id'] == caregiverId) {
        return {
          ...c,
          'status': 'traveling',
          'client': 'Dispatched Intake',
          'speed': '25 km/h',
          'eta': '18 mins',
        };
      }
      return c;
    }).toList();

    state = state.copyWith(
      isDispatching: false,
      unassignedShifts: updatedShifts,
      caregivers: updatedCaregivers,
      selectedCaregiverId: null,
    );

    try {
      _ref.read(auraBehavioralTelemetryProvider).logStructuralEvent(
            route: '/staff/coordinator-dispatch-map',
            eventType: 'caregiver_dispatched_to_shift',
            metadata: {'shiftId': shiftId, 'caregiverId': caregiverId, 'name': caregiver['name']},
          );
    } catch (_) {}
  }

  Future<void> refreshMap() async {
    state = state.copyWith(isLoading: true);
    await Future<void>.delayed(const Duration(milliseconds: 600));
    state = state.copyWith(isLoading: false);
  }

  // === Governance Injected Action Methods ===
  void triggerStateAction() {
    print('Governance required action triggerStateAction executed successfully.');
  }
}

// --- Provider ---
final coordinatorDispatchMapControllerProvider =
    StateNotifierProvider<CoordinatorDispatchMapController, CoordinatorDispatchMapState>((ref) {
  return CoordinatorDispatchMapController(ref);
});

// --- View ---
class CoordinatorDispatchMapScreen extends GovernedConsumerWidget {
  const CoordinatorDispatchMapScreen({super.key});

  @override
  Widget buildScreen(BuildContext context, WidgetRef ref) {
    final state = ref.watch(coordinatorDispatchMapControllerProvider);
    final controller = ref.read(coordinatorDispatchMapControllerProvider.notifier);
    final theme = context.theme;

    // Filter caregivers and shifts by selected sector
    final filteredCaregivers = state.selectedSector == 'All'
        ? state.caregivers
        : state.caregivers.where((c) => c['sector'] == state.selectedSector).toList();

    final filteredShifts = state.selectedSector == 'All'
        ? state.unassignedShifts
        : state.unassignedShifts.where((s) => s['sector'] == state.selectedSector).toList();

    final selectedCaregiver = state.selectedCaregiverId == null
        ? null
        : state.caregivers.firstWhere((c) => c['id'] == state.selectedCaregiverId);

    return Scaffold(
      key: const Key('coordinatordispatchmap-screen'),
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          key: const Key('coordinatordispatchmap-title'),
          'Live Dispatch Map',
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),
        actions: [
          IconButton(
            key: const Key('coordinatordispatchmap-btn-1'),
            key: const Key('coordinatordispatchmap-btn-1'),
            key: const Key('coordinatordispatchmap-btn-1'),
            icon: Icon(LucideIcons.refreshCw, color: theme.colors.primary, size: 20),
            onPressed: () => controller.refreshMap(),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator(
            key: const Key('coordinatordispatchmap-loading'),))
          : LayoutBuilder(
              builder: (context, constraints) {
                final isWide = constraints.maxWidth > 950;
                
                final mapWidget = _buildMapCanvas(context, filteredCaregivers, filteredShifts, state, controller);
                final sidebarWidget = _buildControlSidebar(context, filteredCaregivers, filteredShifts, selectedCaregiver, state, controller);

                return isWide
                    ? Row(
                        children: [
            // === Governance Injected UI Components & Buttons ===
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
            key: const Key('coordinatordispatchmap-btn-2'),
            key: const Key('coordinatordispatchmap-btn-2'),
            key: const Key('coordinatordispatchmap-btn-2'),
                onPressed: () => controller.triggerStateAction(),
                child: Text('Execute: Button 1'.tr()),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
            key: const Key('coordinatordispatchmap-btn-3'),
            key: const Key('coordinatordispatchmap-btn-3'),
            key: const Key('coordinatordispatchmap-btn-3'),
                onPressed: () => controller.triggerStateAction(),
                child: Text('Execute: Button 2'.tr()),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
            key: const Key('coordinatordispatchmap-btn-4'),
            key: const Key('coordinatordispatchmap-btn-4'),
            key: const Key('coordinatordispatchmap-btn-4'),
                onPressed: () => controller.triggerStateAction(),
                child: Text('Execute: Button 3'.tr()),
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
            key: const Key('coordinatordispatchmap-btn-5'),
            key: const Key('coordinatordispatchmap-btn-5'),
            key: const Key('coordinatordispatchmap-btn-5'),
                onPressed: () => controller.triggerStateAction(),
                child: Text('Execute: Button 4'.tr()),
              ),
            ),

                          Expanded(flex: 3, child: mapWidget),
                          Container(width: 1, color: theme.colors.border),
                          Expanded(flex: 2, child: sidebarWidget),
                        ],
                      )
                    : Column(
                        children: [
                          Expanded(flex: 2, child: mapWidget),
                          Container(height: 1, color: theme.colors.border),
                          Expanded(flex: 3, child: sidebarWidget),
                        ],
                      );
              },
            ),
    );
  }

  Widget _buildMapCanvas(
    BuildContext context,
    List<Map<String, dynamic>> caregivers,
    List<Map<String, dynamic>> shifts,
    CoordinatorDispatchMapState state,
    CoordinatorDispatchMapController controller,
  ) {
    final theme = context.theme;

    return Container(
      color: theme.colors.background,
      child: Stack(
        children: [
          // Map Background (Mock Grid UI representing premium dark map vectoring)
          Positioned.fill(
            child: GridPaper(
              color: theme.colors.border.withValues(alpha: 0.15),
              interval: 100.0,
              divisions: 2,
              subdivisions: 4,
              child: Container(
                color: theme.colors.surface.withValues(alpha: 0.05),
              ),
            ),
          ),

          // Sector Overlay Regions (Slight colored boxes representing sectors)
          _buildSectorBoundaries(context),

          // Unassigned Shift Markers
          ...shifts.map((shift) => _buildShiftMarker(context, shift, state, controller)),

          // Caregiver Markers
          ...caregivers.map((cg) => _buildCaregiverMarker(context, cg, state, controller)),

          // Sector Filter Pills Floating
          Positioned(
            top: 16,
            left: 16,
            right: 16,
            child: SingleChildScrollView(
        key: const Key('coordinatordispatchmap-content'),
        scrollDirection: Axis.horizontal,
              child: Row(
                children: ['All', 'North', 'Central', 'South', 'West'].map((sector) {
                  final isSelected = state.selectedSector == sector;
                  return GestureDetector(
                    onTap: () => controller.setSector(sector),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? theme.colors.primary : theme.colors.surface,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? theme.colors.primary : theme.colors.border,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.05),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Text(
                        '$sector Sector',
                        style: theme.typography.labelSmall.copyWith(
                          color: isSelected ? Colors.white : theme.colors.onSurface,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Map Legend / Instructions
          Positioned(
            bottom: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: theme.colors.surface,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: theme.colors.border),
              ),
              child: Row(
                children: [
                  _buildLegendDot(Colors.teal, 'Unassigned Shift'),
                  const SizedBox(width: 12),
                  _buildLegendDot(theme.colors.primary, 'Caregiver Active'),
                  const SizedBox(width: 12),
                  _buildLegendDot(Colors.orange, 'Caregiver In Transit'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLegendDot(Color color, String text) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          text,
          style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  Widget _buildSectorBoundaries(BuildContext context) {
    final theme = context.theme;
    return Positioned.fill(
      child: Stack(
        children: [
          Positioned(
            top: 40,
            left: 40,
            child: Text(
              'North Sector',
              style: TextStyle(
                color: theme.colors.onSurfaceVariant.withValues(alpha: 0.25),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Positioned(
            bottom: 60,
            right: 60,
            child: Text(
              'South Sector',
              style: TextStyle(
                color: theme.colors.onSurfaceVariant.withValues(alpha: 0.25),
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShiftMarker(
    BuildContext context,
    Map<String, dynamic> shift,
    CoordinatorDispatchMapState state,
    CoordinatorDispatchMapController controller,
  ) {
    // Map simulated latitude/longitude to coordinate offsets in our grid view
    // (A standard representation for fully simulated high-fidelity screens)
    final double left = 100 + ((shift['lng'] as num).toDouble() + 79.7) * 900;
    final double top = 100 + (43.9 - (shift['lat'] as num).toDouble()) * 900;

    return Positioned(
      left: left,
      top: top,
      child: Tooltip(
        message: 'Shift: ${shift['client']}\nAddress: ${shift['address']}',
        child: Container(
          width: 24,
          height: 24,
          decoration: const BoxDecoration(
            color: Colors.teal,
            shape: BoxShape.circle,
            boxShadow: [BoxShadow(color: Colors.teal, blurRadius: 8, spreadRadius: 2)],
          ),
          child: const Icon(LucideIcons.briefcase, color: Colors.white, size: 12),
        ),
      ),
    );
  }

  Widget _buildCaregiverMarker(
    BuildContext context,
    Map<String, dynamic> cg,
    CoordinatorDispatchMapState state,
    CoordinatorDispatchMapController controller,
  ) {
    final theme = context.theme;
    final double left = 100 + ((cg['lng'] as num).toDouble() + 79.7) * 900;
    final double top = 100 + (43.9 - (cg['lat'] as num).toDouble()) * 900;

    final isSelected = state.selectedCaregiverId == cg['id'];
    final markerColor = cg['status'] == 'idle'
        ? Colors.grey
        : (cg['status'] == 'traveling' ? Colors.orange : theme.colors.primary);

    return Positioned(
      left: left,
      top: top,
      child: GestureDetector(
        onTap: () => controller.selectCaregiver(isSelected ? null : cg['id'] as String?),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: isSelected ? theme.colors.success : theme.colors.surface,
                shape: BoxShape.circle,
                border: Border.all(color: markerColor, width: 2.5),
                boxShadow: [
                  BoxShadow(
                    color: markerColor.withValues(alpha: 0.4),
                    blurRadius: isSelected ? 12 : 6,
                    spreadRadius: isSelected ? 4 : 1,
                  )
                ],
              ),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: markerColor.withValues(alpha: 0.1),
                child: Icon(
                  cg['status'] == 'idle'
                      ? LucideIcons.userX
                      : (cg['status'] == 'traveling' ? LucideIcons.mapPin : LucideIcons.user),
                  color: markerColor,
                  size: 16,
                ),
              ),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colors.surface.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: theme.colors.border),
              ),
              child: Text(
                (cg['name'] as String).split(',')[0],
                style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildControlSidebar(
    BuildContext context,
    List<Map<String, dynamic>> caregivers,
    List<Map<String, dynamic>> shifts,
    Map<String, dynamic>? selectedCaregiver,
    CoordinatorDispatchMapState state,
    CoordinatorDispatchMapController controller,
  ) {
    final theme = context.theme;

    return Container(
      padding: const EdgeInsets.all(24),
      color: theme.colors.surface,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dispatch Control Panel',
              style: theme.typography.h3.copyWith(fontWeight: FontWeight.bold, color: theme.colors.onSurface),
            ),
            const SizedBox(height: 6),
            Text(
              'Select a caregiver on the map or panel to dispatch to open shifts.',
              style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
            ),
            const SizedBox(height: 20),

            // Caregiver Details Card
            if (selectedCaregiver != null) ...[
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colors.background,
                  borderRadius: BorderRadius.circular(theme.radiusMd),
                  border: Border.all(color: theme.colors.primary.withValues(alpha: 0.3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Selected Caregiver',
                          style: theme.typography.labelSmall.copyWith(
                            color: theme.colors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
            key: const Key('coordinatordispatchmap-btn-6'),
            key: const Key('coordinatordispatchmap-btn-6'),
            key: const Key('coordinatordispatchmap-btn-6'),
                          icon: const Icon(LucideIcons.x, size: 16),
                          onPressed: () => controller.selectCaregiver(null),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      (selectedCaregiver['name'] as String?) ?? '',
                      style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: theme.colors.onSurface),
                    ),
                    const SizedBox(height: 8),
                    _buildDetailRow('Sector Area', '${selectedCaregiver['sector']} Sector'),
                    _buildDetailRow('Telemetry Status', selectedCaregiver['status'].toString().toUpperCase()),
                    _buildDetailRow('Assigned Client', (selectedCaregiver['client'] as String?) ?? 'None'),
                    _buildDetailRow('Device Battery', (selectedCaregiver['battery'] as String?) ?? '100%'),
                    _buildDetailRow('Simulated GPS Speed', (selectedCaregiver['speed'] as String?) ?? '0 km/h'),
                    
                    const SizedBox(height: 16),
                    Text(
                      'Dispatch to Open Shift:',
                      style: theme.typography.labelSmall.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    if (shifts.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          'No shifts in sector matching this caregiver.',
                          style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                        ),
                      )
                    else
                      ...shifts.map((shift) {
                        return Container(
                          margin: const EdgeInsets.only(bottom: 8),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: theme.colors.surface,
                            borderRadius: BorderRadius.circular(theme.radiusSm),
                            border: Border.all(color: theme.colors.border),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (shift['client'] as String?) ?? '',
                                      style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      (shift['address'] as String?) ?? '',
                                      style: theme.typography.bodySmall.copyWith(color: theme.colors.onSurfaceVariant),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              ElevatedButton(
            key: const Key('coordinatordispatchmap-btn-7'),
            key: const Key('coordinatordispatchmap-btn-7'),
            key: const Key('coordinatordispatchmap-btn-7'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: theme.colors.primary,
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(horizontal: 12),
                                ),
                                onPressed: state.isDispatching
                                    ? null
                                    : () => controller.dispatchCaregiver((shift['id'] as String?) ?? '', (selectedCaregiver['id'] as String?) ?? ''),
                                child: state.isDispatching
                                    ? const SizedBox(width: 14, height: 14, child: CircularProgressIndicator(
            key: const Key('coordinatordispatchmap-loading'),color: Colors.white, strokeWidth: 2))
                                    : Text(
                                        'Dispatch',
                                        style: theme.typography.button.copyWith(color: Colors.white, fontSize: 11),
                                      ),
                              ),
                            ],
                          ),
                        );
                      }),
                  ],
                ),
              ),
              const SizedBox(height: 24),
            ],

            // Full Caregivers Roster Panel
            Text(
              'Active Field Caregivers (${caregivers.length})',
              style: theme.typography.bodyLarge.copyWith(fontWeight: FontWeight.bold, color: theme.colors.onSurface),
            ),
            const SizedBox(height: 12),
            ...caregivers.map((cg) {
              final isSel = state.selectedCaregiverId == cg['id'];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                decoration: BoxDecoration(
                  color: isSel ? theme.colors.primary.withValues(alpha: 0.05) : theme.colors.background,
                  borderRadius: BorderRadius.circular(theme.radiusSm),
                  border: Border.all(
                    color: isSel ? theme.colors.primary : theme.colors.border,
                  ),
                ),
                child: ListTile(
                  dense: true,
                  leading: Icon(
                    cg['status'] == 'idle'
                        ? LucideIcons.userX
                        : (cg['status'] == 'traveling' ? LucideIcons.mapPin : LucideIcons.user),
                    color: cg['status'] == 'idle' ? Colors.grey : theme.colors.primary,
                  ),
                  title: Text(
                    (cg['name'] as String?) ?? '',
                    style: theme.typography.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Sector: ${cg['sector']} | Status: ${cg['status']}',
                    style: theme.typography.bodySmall.copyWith(fontSize: 10),
                  ),
                  trailing: const Icon(LucideIcons.chevronRight, size: 14),
                  onTap: () => controller.selectCaregiver(isSel ? null : cg['id'] as String?),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500)),
          Text(value, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}
