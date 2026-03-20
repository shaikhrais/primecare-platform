import 'package:flutter/material.dart';

class CoordinatorJaneMatrixScreen extends StatefulWidget {
  const CoordinatorJaneMatrixScreen({super.key});

  @override
  State<CoordinatorJaneMatrixScreen> createState() => _CoordinatorJaneMatrixScreenState();
}

class _CoordinatorJaneMatrixScreenState extends State<CoordinatorJaneMatrixScreen> {
  // Configurable Constraints
  final double hourColumnWidth = 100.0;
  final double providerRowHeight = 80.0;
  final int totalHours = 14; // 8 AM to 10 PM
  final int startHour = 8;
  
  final List<String> providers = [
    'Sarah Jenkins (RN)',
    'David Chen (PSW)',
    'Maria Garcia (PSW)',
    'James Wilson (RN)',
    'Anita Patel (PSW)',
    'Michael Ross (PSW)',
    'Laura White (PSW)',
    'Jessica Wong (MT)',     // [Phase 50] Inject Native MT support
    'Marcus Thorne (MT)',    // [Phase 50] Into physical Jane Matrix
  ];

  // Dummy Shift Data
  final List<Map<String, dynamic>> shifts = [
    {'providerIndex': 0, 'startHourOffset': 1.0, 'durationHours': 4.0, 'patient': 'John Doe', 'status': 'completed'},
    {'providerIndex': 0, 'startHourOffset': 6.0, 'durationHours': 3.0, 'patient': 'Alice Smith', 'status': 'verified'},
    {'providerIndex': 1, 'startHourOffset': 0.0, 'durationHours': 8.0, 'patient': 'Facility Block', 'status': 'assigned'},
    {'providerIndex': 2, 'startHourOffset': 2.5, 'durationHours': 2.0, 'patient': 'Bob Johnson', 'status': 'unstaffed'},
    {'providerIndex': 3, 'startHourOffset': 4.0, 'durationHours': 5.0, 'patient': 'Eva Green', 'status': 'assigned'},
    {'providerIndex': 4, 'startHourOffset': 1.0, 'durationHours': 3.5, 'patient': 'Tom Baker', 'status': 'completed'},
    {'providerIndex': 5, 'startHourOffset': 5.0, 'durationHours': 6.0, 'patient': 'Mary Clark', 'status': 'verified'},
    {'providerIndex': 7, 'startHourOffset': 2.0, 'durationHours': 1.5, 'patient': 'Sports Massage - Gym', 'status': 'assigned'},
    {'providerIndex': 8, 'startHourOffset': 4.5, 'durationHours': 1.0, 'patient': 'Therapeutic Massage 60m', 'status': 'verified'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Live Dispatch Matrix', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
        backgroundColor: Colors.white,
        elevation: 1,
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(color: const Color(0xFFDBEAFE), borderRadius: BorderRadius.circular(12)),
            child: const Center(child: Text('94% Fleet Utilization', style: TextStyle(color: Color(0xFF2563EB), fontWeight: FontWeight.bold))),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            _buildLegendBar(),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: totalHours * hourColumnWidth + 150, // +150 for Y-Axis Names
                    height: providers.length * providerRowHeight + 50, // +50 for X-Axis Time
                    child: Stack(
                      children: [
                        _buildGridSystem(),
                        _buildTimeAxis(),
                        _buildProviderAxis(),
                        _buildShiftBlocks(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendItem('Unassigned', const Color(0xFFEF4444)),
          _buildLegendItem('Assigned', const Color(0xFFF59E0B)),
          _buildLegendItem('GPS Verified', const Color(0xFF10B981)),
          _buildLegendItem('Completed', const Color(0xFF3B82F6)),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(width: 12, height: 12, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(2))),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
      ],
    );
  }

  Widget _buildGridSystem() {
    return Positioned(
      top: 50,
      left: 150,
      child: CustomPaint(
        size: Size(totalHours * hourColumnWidth, providers.length * providerRowHeight),
        painter: GridPainter(totalHours, providers.length, hourColumnWidth, providerRowHeight),
      ),
    );
  }

  Widget _buildTimeAxis() {
    return Positioned(
      top: 0,
      left: 150,
      child: Row(
        children: List.generate(totalHours, (index) {
          int hour = startHour + index;
          String time = hour > 12 ? '\${hour - 12} PM' : (hour == 12 ? '12 PM' : '\$hour AM');
          return Container(
            width: hourColumnWidth,
            height: 50,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 8),
            decoration: const BoxDecoration(
              color: Color(0xFFF1F5F9),
              border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)), right: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Text(time, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF64748B))),
          );
        }),
      ),
    );
  }

  Widget _buildProviderAxis() {
    return Positioned(
      top: 50,
      left: 0,
      child: Column(
        children: providers.map((name) {
          return Container(
            width: 150,
            height: providerRowHeight,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0)), right: BorderSide(color: Color(0xFFE2E8F0))),
            ),
            child: Row(
              children: [
                CircleAvatar(radius: 14, backgroundColor: const Color(0xFFE2E8F0), child: Icon(Icons.person, size: 16, color: Colors.blueGrey[700])),
                const SizedBox(width: 8),
                Expanded(child: Text(name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Color(0xFF0F172A)), maxLines: 2)),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildShiftBlocks() {
    return Positioned(
      top: 50,
      left: 150,
      child: Stack(
        children: shifts.map((shift) {
          final top = shift['providerIndex'] * providerRowHeight;
          final left = shift['startHourOffset'] * hourColumnWidth;
          final width = shift['durationHours'] * hourColumnWidth;

          Color blockColor;
          switch (shift['status']) {
            case 'unstaffed': blockColor = const Color(0xFFEF4444); break; // Red
            case 'assigned': blockColor = const Color(0xFFF59E0B); break;  // Amber
            case 'verified': blockColor = const Color(0xFF10B981); break;  // Emerald
            case 'completed': blockColor = const Color(0xFF3B82F6); break; // Blue
            default: blockColor = Colors.grey;
          }

          // DRAGGABLE WRAPPER
          return Positioned(
            top: top + 10,
            left: left,
            child: Draggable(
              feedback: Material(
                color: Colors.transparent,
                child: _buildBlockUnit(shift['patient'], width, providerRowHeight - 20, blockColor.withAlpha(200)),
              ),
              childWhenDragging: _buildBlockUnit(shift['patient'], width, providerRowHeight - 20, blockColor.withAlpha(50)),
              child: _buildBlockUnit(shift['patient'], width, providerRowHeight - 20, blockColor),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBlockUnit(String patientName, double width, double height, Color color) {
    return Container(
      width: width - 4,
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 2),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        border: Border(left: BorderSide(color: color, width: 4), top: BorderSide(color: color.withAlpha(100)), right: BorderSide(color: color.withAlpha(100)), bottom: BorderSide(color: color.withAlpha(100))),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(patientName, style: TextStyle(color: color.withAlpha(255).withGreen(color.green ~/ 2), fontWeight: FontWeight.w900, fontSize: 12), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }
}

class GridPainter extends CustomPainter {
  final int totalHours;
  final int totalProviders;
  final double colWidth;
  final double rowHeight;

  GridPainter(this.totalHours, this.totalProviders, this.colWidth, this.rowHeight);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = const Color(0xFFE2E8F0)
      ..strokeWidth = 1.0;

    // Draw Vertical Time Lines (Half hour intervals optionally later)
    for (int i = 0; i <= totalHours; i++) {
      double x = i * colWidth;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    // Draw Horizontal Provider Lines
    for (int i = 0; i <= totalProviders; i++) {
      double y = i * rowHeight;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
