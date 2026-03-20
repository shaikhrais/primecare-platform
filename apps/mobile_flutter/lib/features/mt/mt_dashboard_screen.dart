import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MtDashboardScreen extends StatelessWidget {
  const MtDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('My Jane Schedule (MT)', style: TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0F172A))),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800), // Desktop/Tablet Responsive Lock
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              _buildTherapistHeader(),
              const SizedBox(height: 24),
              const Text("TODAY'S MASSAGE BOOKINGS", style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.bold, letterSpacing: 1.5)),
              const SizedBox(height: 16),
              _buildJaneBookingBlock(context, '10:00 AM', '11:00 AM', 'Sports Therapy Massage', 'James Gym Facility', const Color(0xFFF59E0B)),
              _buildJaneBookingBlock(context, '1:00 PM', '2:30 PM', 'Deep Tissue 90m', 'Client Residence (North York)', const Color(0xFFEF4444)),
              _buildJaneBookingBlock(context, '4:00 PM', '5:00 PM', 'Swedish Relaxation', 'PrimeCare Core Clinic', const Color(0xFF10B981)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTherapistHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: const Color(0xFF0F172A), borderRadius: BorderRadius.circular(16)),
      child: Row(
        children: [
          const CircleAvatar(radius: 24, backgroundColor: Color(0xFF8B5CF6), child: Icon(Icons.spa, color: Colors.white, size: 28)),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text('Welcome back, Jessica', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              SizedBox(height: 4),
              Text('3 Booked Active Sessions', style: TextStyle(color: Color(0xFF94A3B8))),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildJaneBookingBlock(BuildContext context, String start, String end, String clinicalType, String location, Color statusColor) {
    // Mimicking the rigid Jane-style booking blocks
    return InkWell(
      onTap: () => context.push('/mt/client-profile'),
      hoverColor: Colors.transparent,
      child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE2E8F0)),
        boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 10, offset: Offset(0, 4))],
      ),
      child: Row(
        children: [
          // Left Stripe Status Identifier (Jane UI Pattern)
          Container(
            width: 8,
            height: 100,
            decoration: BoxDecoration(color: statusColor, borderRadius: const BorderRadius.only(topLeft: Radius.circular(12), bottomLeft: Radius.circular(12))),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$start - \$end', style: const TextStyle(fontWeight: FontWeight.w900, color: Color(0xFF0F172A), fontSize: 16)),
                      Icon(Icons.more_horiz, color: const Color(0xFFCBD5E1)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(clinicalType, style: const TextStyle(color: Color(0xFF3B82F6), fontWeight: FontWeight.bold, fontSize: 14)),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 14, color: Color(0xFF64748B)),
                      const SizedBox(width: 4),
                      Text(location, style: const TextStyle(color: Color(0xFF475569))),
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
