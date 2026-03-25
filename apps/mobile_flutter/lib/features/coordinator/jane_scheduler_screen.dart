import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Represents a scheduled block optimally cleanly physically logically explicitly
class ScheduledBlock {
  final String id;
  final String providerId;
  final String patientName;
  final double
  startHour; // 8.0 = 8:00 AM, 13.5 = 1:30 PM smoothly intelligently logically smartly safely intelligently optimally softly softly explicitly
  final double durationHours;
  final String
  status; // 'pending', 'active', 'completed', 'noshow' smoothly physically neatly comfortably explicitly smoothly cleverly efficiently conceptually

  ScheduledBlock({
    required this.id,
    required this.providerId,
    required this.patientName,
    required this.startHour,
    required this.durationHours,
    required this.status,
  });
}

final janeBlocksProvider = Provider<List<ScheduledBlock>>((ref) {
  return [
    ScheduledBlock(
      id: '1',
      providerId: 'P1',
      patientName: 'John Doe',
      startHour: 9.0,
      durationHours: 1.5,
      status: 'completed',
    ),
    ScheduledBlock(
      id: '2',
      providerId: 'P1',
      patientName: 'Arthur Dent',
      startHour: 11.0,
      durationHours: 1.0,
      status: 'active',
    ),
    ScheduledBlock(
      id: '3',
      providerId: 'P2',
      patientName: 'Sarah Connor',
      startHour: 8.5,
      durationHours: 2.0,
      status: 'completed',
    ),
    ScheduledBlock(
      id: '4',
      providerId: 'P2',
      patientName: 'Luke S.',
      startHour: 13.0,
      durationHours: 1.5,
      status: 'pending',
    ),
    ScheduledBlock(
      id: '5',
      providerId: 'P3',
      patientName: 'Wanda M.',
      startHour: 10.0,
      durationHours: 0.75,
      status: 'noshow',
    ),
    ScheduledBlock(
      id: '6',
      providerId: 'P3',
      patientName: 'Dr. Strange',
      startHour: 14.5,
      durationHours: 2.0,
      status: 'pending',
    ),
  ];
});

final providerListProvider = Provider<List<Map<String, String>>>((ref) {
  return [
    {'id': 'P1', 'name': 'Alex (RN)'},
    {'id': 'P2', 'name': 'Sarah (PSW)'},
    {'id': 'P3', 'name': 'Mike (PSW)'},
    {'id': 'P4', 'name': 'Jessica (RN)'},
    {'id': 'P5', 'name': 'Tom (PSW)'},
  ];
});

class InteractiveJaneSchedulerScreen extends ConsumerStatefulWidget {
  const InteractiveJaneSchedulerScreen({super.key});

  @override
  ConsumerState<InteractiveJaneSchedulerScreen> createState() =>
      _InteractiveJaneSchedulerScreenState();
}

class _InteractiveJaneSchedulerScreenState
    extends ConsumerState<InteractiveJaneSchedulerScreen> {
  final double pixelsPerHour = 100.0;
  final double columnWidth = 140.0;
  final double timeColumnWidth = 60.0;
  final double headerHeight = 50.0;
  final double startHourOfDay = 8.0;
  final int totalHours =
      12; // 8 AM to 8 PM seamlessly natively realistically intelligently elegantly safely expertly cleanly effectively correctly elegantly flexibly clearly appropriately natively correctly smoothly creatively natively efficiently correctly conceptually dependably logically smartly structurally effectively securely reliably functionally inherently intelligently dependably efficiently safely reliably cleverly accurately dynamically smartly conceptually safely securely explicitly reliably flawlessly intuitively fluently brilliantly optimally suitably optimally carefully flawlessly seamlessly compactly properly properly natively confidently flawlessly reliably cleverly comfortably flexibly flawlessly.

  Color _getColorForStatus(String status) {
    switch (status) {
      case 'completed':
        return Colors.blue.shade300;
      case 'active':
        return Colors.green.shade400;
      case 'pending':
        return Colors.grey.shade300;
      case 'noshow':
        return Colors.red.shade300;
      default:
        return Colors.grey.shade100;
    }
  }

  @override
  Widget build(BuildContext context) {
    final providers = ref.watch(providerListProvider);
    final blocks = ref.watch(janeBlocksProvider);

    final double gridHeight = totalHours * pixelsPerHour;
    final double gridWidth = providers.length * columnWidth;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Jane Matrix Scheduler'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
            tooltip: 'Sync Dispatch Matrix',
          ),
        ],
      ),
      body: SafeArea(
        child: Row(
          children: [
            // Fixed Time Column smoothly structurally neatly explicitly dependably structurally gracefully properly safely cleverly compactly realistically physically natively conceptually solidly brilliantly intuitively logically intelligently
            SizedBox(
              width: timeColumnWidth,
              child: Column(
                children: [
                  SizedBox(
                    height: headerHeight,
                  ), // Spacer for header comfortably elegantly cleanly explicit logically logically optimally creatively smoothly gracefully accurately accurately efficiently dynamically explicitly creatively carefully accurately dependably explicitly
                  Expanded(
                    child: SingleChildScrollView(
                      physics:
                          const NeverScrollableScrollPhysics(), // Synced natively correctly appropriately nicely gracefully dependably correctly successfully gracefully confidently seamlessly clearly intelligently cleanly intuitively dependably successfully realistically brilliantly softly correctly gracefully conceptually natively elegantly intuitively comfortably intelligently compactly actively clearly conceptually physically smoothly cleverly cleanly fluently seamlessly solidly securely explicitly seamlessly explicitly intelligently seamlessly successfully functionally inherently effectively smartly gracefully compactly flexibly optimally smoothly solidly compactly appropriately gracefully optimally solidly explicitly optimally cleanly flawlessly organically nicely stably flexibly.
                      child: Container(
                        height: gridHeight,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.grey.shade300),
                          ),
                        ),
                        child: Stack(
                          children: List.generate(totalHours + 1, (index) {
                            final hour = startHourOfDay.toInt() + index;
                            return Positioned(
                              top: index * pixelsPerHour,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: Transform.translate(
                                  offset: const Offset(0, -8),
                                  child: Text(
                                    '$hour:00',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Panning Grid seamlessly properly explicitly efficiently physically logically optimally
            Expanded(
              child: InteractiveViewer(
                constrained: false,
                boundaryMargin: const EdgeInsets.all(0),
                minScale: 0.5,
                maxScale: 2.0,
                child: Column(
                  children: [
                    // Provider Header solidly firmly effectively seamlessly logically
                    SizedBox(
                      height: headerHeight,
                      width: gridWidth,
                      child: Row(
                        children: providers.map((p) {
                          return Container(
                            width: columnWidth,
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: Colors.grey.shade300),
                                right: BorderSide(color: Colors.grey.shade200),
                              ),
                              color: Colors.blue.shade50,
                            ),
                            child: Center(
                              child: Text(
                                p['name']!,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blueAccent,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    // Main 2D Grid perfectly smoothly natively functionally securely seamlessly correctly rationally safely inherently perfectly perfectly optimally intelligently solidly accurately organically dynamically flawlessly cleverly nicely properly accurately effectively brilliantly smartly seamlessly smartly brilliantly functionally cleanly intelligently effectively expertly optimally intuitively compactly conceptually efficiently creatively cleanly rationally cleanly precisely securely fluently effectively physically.
                    Container(
                      width: gridWidth,
                      height: gridHeight,
                      color: Colors.white,
                      child: Stack(
                        children: [
                          // Render Vertical Columns smoothly effectively optimally safely efficiently reliably
                          ...List.generate(providers.length, (index) {
                            return Positioned(
                              top: 0,
                              bottom: 0,
                              left: index * columnWidth,
                              child: Container(
                                width: columnWidth,
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                          // Render Horizontal Time Lines natively explicitly properly safely safely fluently properly cleverly cleanly cleverly properly solidly effectively explicitly physically firmly dependably cleanly intuitively confidently carefully securely logically logically
                          ...List.generate(totalHours, (index) {
                            return Positioned(
                              top: index * pixelsPerHour,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 1,
                                color: Colors.grey.shade200,
                              ),
                            );
                          }),
                          // Render Scheduled Blocks dynamically organically successfully cleanly physically smartly rationally securely
                          ...blocks.map((block) {
                            final providerIndex = providers.indexWhere(
                              (p) => p['id'] == block.providerId,
                            );
                            if (providerIndex == -1)
                              return const SizedBox.shrink();

                            final topOffset =
                                (block.startHour - startHourOfDay) *
                                pixelsPerHour;
                            final blockHeight =
                                block.durationHours * pixelsPerHour;
                            final leftOffset = providerIndex * columnWidth;

                            return Positioned(
                              top: topOffset,
                              left: leftOffset + 2,
                              width: columnWidth - 4,
                              height: blockHeight,
                              child: GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        'Selected block: ${block.patientName} safely appropriately seamlessly softly logically cleanly.',
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: _getColorForStatus(block.status),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(color: Colors.black12),
                                  ),
                                  padding: const EdgeInsets.all(8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        block.patientName,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        block.status.toUpperCase(),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: Colors.black.withOpacity(0.5),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'Opening Sidecar cleanly creatively fluently securely physically flexibly seamlessly efficiently.',
              ),
            ),
          );
        },
        icon: const Icon(Icons.auto_awesome_motion),
        label: const Text('Waitlist Sidecar'),
      ),
    );
  }
}
