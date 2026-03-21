import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';
import 'package:go_router/go_router.dart';

class MtDashboardScreen extends StatelessWidget {
  const MtDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: PrimeCareNavBar(
        title: PrimeCareText('My Jane Schedule (MT)', style: TextStyle(fontWeight: FontWeight.w900, color: PrimeCareColors.radarDark)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 900;
          
          if (isDesktop) {
            return PrimeCareCenter(
              child: DesktopPaneWrapper(
                child: PrimeCareRow(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PrimeCareExpanded(
                      flex: 1,
                      child: PrimeCareScrollWrapper(
                        padding: EdgeInsets.all(24),
                        child: PrimeCareColumn(
                          children: [
                            _buildTherapistHeader(),
                            PrimeCareSizedBox(height: 24),
                            // Simulated Native Desktop Side-Calendar
                            PrimeCareCard(
                              padding: EdgeInsets.all(20),
                              child: PrimeCareColumn(
                                children: [
                                  PrimeCareRow(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [PrimeCareText('March 2026', style: TextStyle(fontWeight: FontWeight.bold)), PrimeCareIcon(Icons.calendar_month, color: PrimeCareColors.slate400)],
                                  ),
                                  PrimeCareSizedBox(height: 16),
                                  PrimeCareText('24 total hours mapped this week.', style: TextStyle(color: PrimeCareColors.slate500)),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    PrimeCareSizedBox(width: 32),
                    PrimeCareExpanded(
                      flex: 2,
                      child: PrimeCareScrollWrapper(
                        padding: EdgeInsets.all(24),
                        child: PrimeCareColumn(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            PrimeCareText("TODAY'S MASSAGE BOOKINGS", style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                            PrimeCareSizedBox(height: 16),
                            _buildJaneBookingBlock(context, '10:00 AM', '11:00 AM', 'Sports Therapy Massage', 'James Gym Facility', PrimeCareColors.amber),
                            _buildJaneBookingBlock(context, '1:00 PM', '2:30 PM', 'Deep Tissue 90m', 'Client Residence (North York)', Color(0xFFEF4444)),
                            _buildJaneBookingBlock(context, '4:00 PM', '5:00 PM', 'Swedish Relaxation', 'PrimeCare Core Clinic', PrimeCareColors.emerald),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          
          return PrimeCareCenter(
            child: DesktopPaneWrapper(
              child: PrimeCareListView(
                padding: EdgeInsets.all(20),
                children: [
                  _buildTherapistHeader(),
                  PrimeCareSizedBox(height: 24),
                  PrimeCareText("TODAY'S MASSAGE BOOKINGS", style: TextStyle(color: PrimeCareColors.slate500, fontWeight: FontWeight.bold, letterSpacing: 1.5)),
                  PrimeCareSizedBox(height: 16),
                  _buildJaneBookingBlock(context, '10:00 AM', '11:00 AM', 'Sports Therapy Massage', 'James Gym Facility', PrimeCareColors.amber),
                  _buildJaneBookingBlock(context, '1:00 PM', '2:30 PM', 'Deep Tissue 90m', 'Client Residence (North York)', Color(0xFFEF4444)),
                  _buildJaneBookingBlock(context, '4:00 PM', '5:00 PM', 'Swedish Relaxation', 'PrimeCare Core Clinic', PrimeCareColors.emerald),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTherapistHeader() {
    return PrimeCareCard(
      padding: EdgeInsets.all(20),
      backgroundColor: PrimeCareColors.radarDark,
      child: PrimeCareRow(
        children: [
          CircleAvatar(radius: 24, defaultIcon: Icons.spa),
          PrimeCareSizedBox(width: 16),
          PrimeCareColumn(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimeCareText('Welcome back, Jessica', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              PrimeCareSizedBox(height: 4),
              PrimeCareText('3 Booked Active Sessions', style: TextStyle(color: PrimeCareColors.slate400)),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildJaneBookingBlock(BuildContext context, String start, String end, String clinicalType, String location, Color statusColor) {
    // Mimicking the rigid Jane-style booking blocks
    return PrimeCareCard(
      onTap: () => context.push('/mt/client-profile'),
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.zero,
      clipBehavior: Clip.hardEdge,
      child: PrimeCareRow(
        children: [
          // Left Stripe Status Identifier (Jane UI Pattern)
          PrimeCareCard(
            width: 8,
            height: 100,
            
          ),
          PrimeCareExpanded(
            child: PrimeCarePadding(
              padding: EdgeInsets.all(16),
              child: PrimeCareColumn(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimeCareRow(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      PrimeCareText('\$start - \$end', style: TextStyle(fontWeight: FontWeight.w900, color: PrimeCareColors.radarDark, fontSize: 16)),
                      PrimeCareIcon(Icons.more_horiz, color: PrimeCareColors.slate300),
                    ],
                  ),
                  PrimeCareSizedBox(height: 8),
                  PrimeCareText(clinicalType, style: TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.bold, fontSize: 14)),
                  PrimeCareSizedBox(height: 4),
                  PrimeCareRow(
                    children: [
                      PrimeCareIcon(Icons.location_on, size: 14, color: PrimeCareColors.slate500),
                      PrimeCareSizedBox(width: 4),
                      PrimeCareText(location, style: TextStyle(color: Color(0xFF475569))),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
