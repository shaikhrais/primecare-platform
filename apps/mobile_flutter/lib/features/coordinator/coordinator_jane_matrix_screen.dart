import 'package:flutter/material.dart';
import '../../core/colors.dart';
import 'package:primecare_ui/primecare_ui.dart';


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
    return PrimeCareScaffold(
      
      body: PrimeCareSafeArea(
        child: PrimeCareColumn(
          children: [
            _buildLegendBar(),
            PrimeCareExpanded(
              child: SingleChildScrollView(scrollDirection: Axis.vertical,
                child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: totalHours * hourColumnWidth + 150, // +150 for Y-Axis Names
                    height: providers.length * providerRowHeight + 50, // +50 for X-Axis Time
                    child: PrimeCareStack(
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
    return PrimeCareContainer(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      color: Colors.white,
      child: PrimeCareRow(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildLegendItem('Unassigned', Color(0xFFEF4444)),
          _buildLegendItem('Assigned', PrimeCareColors.amber),
          _buildLegendItem('GPS Verified', PrimeCareColors.emerald),
          _buildLegendItem('Completed', Color(0xFF3B82F6)),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return PrimeCareRow(
      children: [
        PrimeCareCard(width: 12, height: 12, child: const SizedBox.shrink()),
        SizedBox(width: 6),
        PrimeCareText(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF475569))),
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
      child: PrimeCareRow(
        children: List.generate(totalHours, (index) {
          int hour = startHour + index;
          String time = hour > 12 ? '\${hour - 12} PM' : (hour == 12 ? '12 PM' : '\$hour AM');
          return PrimeCareCard(
            width: hourColumnWidth,
            height: 50,
            
            padding: EdgeInsets.only(left: 8),
            
            child: PrimeCareText(time, style: TextStyle(fontWeight: FontWeight.bold, color: PrimeCareColors.slate500)),
          );
        }),
      ),
    );
  }

  Widget _buildProviderAxis() {
    return Positioned(
      top: 50,
      left: 0,
      child: PrimeCareColumn(
        children: providers.map((name) {
          return PrimeCareCard(
            width: 150,
            height: providerRowHeight,
            
            padding: EdgeInsets.symmetric(horizontal: 12),
            
            child: PrimeCareRow(
              children: [
                CircleAvatar(radius: 14, backgroundColor: PrimeCareColors.slate200, child: PrimeCareIcon(Icons.person, size: 16, color: Colors.blueGrey[700])),
                SizedBox(width: 8),
                PrimeCareExpanded(child: PrimeCareText(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: PrimeCareColors.radarDark), maxLines: 2)),
              ],
            ),
          );
        }).toList().cast<Widget>(),
      ),
    );
  }

  Widget _buildShiftBlocks() {
    return Positioned(
      top: 50,
      left: 150,
      child: PrimeCareStack(
        children: shifts.map((shift) {
          final top = shift['providerIndex'] * providerRowHeight;
          final left = shift['startHourOffset'] * hourColumnWidth;
          final width = shift['durationHours'] * hourColumnWidth;

          Color blockColor;
          switch (shift['status']) {
            case 'unstaffed': blockColor = Color(0xFFEF4444); break; // Red
            case 'assigned': blockColor = PrimeCareColors.amber; break;  // Amber
            case 'verified': blockColor = PrimeCareColors.emerald; break;  // Emerald
            case 'completed': blockColor = Color(0xFF3B82F6); break; // Blue
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
        }).toList().cast<Widget>(),
      ),
    );
  }

  Widget _buildBlockUnit(String patientName, double width, double height, Color color) {
    return PrimeCareCard(
      width: width - 4,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: 2),
      padding: EdgeInsets.all(8),
      
      child: PrimeCareColumn(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PrimeCareExpanded(child: PrimeCareText(patientName, style: TextStyle(color: color.withAlpha(255).withGreen(color.green ~/ 2), fontWeight: FontWeight.w900, fontSize: 12), overflow: TextOverflow.ellipsis)),
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
      ..color = PrimeCareColors.slate200
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
