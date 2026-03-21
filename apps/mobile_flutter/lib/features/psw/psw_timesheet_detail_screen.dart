import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class PswTimesheetDetailScreen extends StatelessWidget {
  final String date;
  final double earnings;
  final bool surgeActive;

  const PswTimesheetDetailScreen({
    super.key,
    required this.date,
    required this.earnings,
    required this.surgeActive
  });

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: PrimeCareAppBar(title: '$date Shift Details'),
      body: PrimeCareCenter(
        child: DesktopPaneWrapper(
          child: PrimeCareScrollWrapper(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: PrimeCareColumn(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Macro Earnings Payout Calculation Graphic
            PrimeCareCard(
              padding: EdgeInsets.all(32),
              
              child: PrimeCareColumn(
                children: [
                  PrimeCareText('Gross Daily Earnings', style: TextStyle(color: PrimeCareColors.slate500, fontSize: 16)),
                  PrimeCareSizedBox(height: 12),
                  PrimeCareText('\$${earnings.toStringAsFixed(2)}', style: TextStyle(fontSize: 48, fontWeight: FontWeight.w900, color: PrimeCareColors.radarDark, letterSpacing: -1)),
                  
                  if (surgeActive) ...[
                    PrimeCareSizedBox(height: 16),
                    PrimeCareCard(
                      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      
                      child: PrimeCareRow(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          PrimeCareIcon(Icons.bolt_rounded, color: PrimeCareColors.emerald, size: 20),
                          PrimeCareSizedBox(width: 8),
                          PrimeCareText('High Demand Surge Active (+1.5x)', style: TextStyle(color: PrimeCareColors.emerald, fontWeight: FontWeight.bold)),
                        ],
                      )
                    )
                  ],
                ],
              ),
            ),
            
            PrimeCareSizedBox(height: 32),
            
            // Tax Simulator Breakdown Widget
            PrimeCareText('NET TAKEHOME CALCULATION', style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.5)),
            PrimeCareSizedBox(height: 16),
            PrimeCareCard(
              padding: EdgeInsets.all(24),
              
              child: PrimeCareColumn(
                children: [
                  _buildLineItem('Base Pay (8h x \$25.00)', '\$200.00'),
                  PrimeCareSizedBox(height: 12),
                  _buildLineItem('Surge OT (2.5h x \$37.50)', '\$93.75'),
                  PrimeCareSizedBox(height: 12),
                  _buildLineItem('Travel Stipend (14km)', '\$21.25'),
                  PrimeCarePadding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Divider(color: PrimeCareColors.slate200),
                  ),
                  _buildLineItem('Est. Target Pre-Tax', '\$315.00', bold: true),
                  PrimeCareSizedBox(height: 12),
                  _buildLineItem('- Federal Deductions (15%)', '-\$47.25', color: PrimeCareColors.rose),
                  _buildLineItem('- CPP Contributions (2%)', '-\$6.30', color: PrimeCareColors.rose),
                ],
              ),
            ),

            PrimeCareSizedBox(height: 32),

            // EVV GPS Logging Verification Node
            PrimeCareText('TELEMETRY GPS LOGS', style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.w900, fontSize: 12, letterSpacing: 1.5)),
            PrimeCareSizedBox(height: 16),
            PrimeCareCard(
              padding: EdgeInsets.all(24),
              
              child: PrimeCareColumn(
                children: [
                  _buildGpsLog('CLOCK IN', '10:04:12 AM', 'Lat 43.65, Lon -79.38 • Accuracy 4m', true),
                  PrimeCareContainer(
                    margin: EdgeInsets.only(left: 17),
                    height: 32, width: 2, 
                    color: PrimeCareColors.slate200, 
                    alignment: Alignment.centerLeft
                  ),
                  _buildGpsLog('CLOCK OUT', '08:34:55 PM', 'Lat 43.65, Lon -79.38 • Accuracy 6m', false),
                ],
              ),
            ),
          ],
        ),
      )
        ),
      ),
    );
  }

  Widget _buildLineItem(String label, String amount, {bool bold = false, Color? color}) {
    return PrimeCareRow(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PrimeCareText(label, style: TextStyle(fontSize: 15, fontWeight: bold ? FontWeight.bold : FontWeight.normal, color: color ?? Color(0xFF475569))),
        PrimeCareText(amount, style: TextStyle(fontSize: 15, fontWeight: bold ? FontWeight.bold : FontWeight.w600, color: color ?? PrimeCareColors.radarDark)),
      ],
    );
  }

  Widget _buildGpsLog(String type, String time, String geo, bool isStart) {
    return PrimeCareRow(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimeCareIcon(isStart ? Icons.gps_fixed : Icons.exit_to_app_rounded, color: isStart ? PrimeCareColors.emerald : Color(0xFF3B82F6), size: 36),
        PrimeCareSizedBox(width: 16),
        PrimeCareColumn(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PrimeCareText(type, style: TextStyle(color: isStart ? PrimeCareColors.emerald : Color(0xFF3B82F6), fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 1)),
            PrimeCareSizedBox(height: 4),
            PrimeCareText(time, style: TextStyle(fontWeight: FontWeight.w900, fontSize: 18, color: PrimeCareColors.radarDark)),
            PrimeCareSizedBox(height: 4),
            PrimeCareText(geo, style: TextStyle(color: PrimeCareColors.slate500, fontSize: 13, fontFamily: 'monospace')),
          ],
        )
      ],
    );
  }
}
