import 'package:flutter/material.dart';

class PswHomeScreen extends StatelessWidget {
  const PswHomeScreen({super.key});

  Widget _buildTopKpiCard(String title, String value, IconData icon, Color iconColor) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: Colors.blueGrey.shade700,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C3E50),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2C64B4),
            ),
          ),
        ),
        const Divider(height: 1, thickness: 1, color: Color(0xFFEBEBEB)),
      ],
    );
  }

  Widget _buildBar(String label, int value, Color color, int maxVal) {
    final heightRatio = value / maxVal;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(value.toString(), style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 4),
        Container(
          width: 40, // Slightly thinner to fit mobile screens dynamically 
          height: 120 * heightRatio,
          color: color,
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget _buildPatientOverview() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Patient Overview'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Active Cases', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF34495E))),
                const SizedBox(height: 24),
                SizedBox(
                  height: 180,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      _buildBar('High', 220, const Color(0xFF3498DB), 600),
                      _buildBar('Medium', 580, const Color(0xFF1ABC9C), 600),
                      _buildBar('Low', 410, const Color(0xFFF39C12), 600),
                      _buildBar('Done', 322, const Color(0xFF2980B9), 600),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(color: Color(0xFFEBEBEB), thickness: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentPatients() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Recent Patients'),
          _buildListTile(Icons.person, 'John Miller', ' - High Priority', Colors.red, Colors.red),
          _buildListTile(Icons.person, 'Linda Garcia', ' - Follow-Up', const Color(0xFF2C64B4), Colors.grey),
          _buildListTile(Icons.person, 'Michael Chen', ' - New Referral', Colors.green, Colors.green),
          _buildListTile(Icons.person, 'Susan Davis', ' - Ongoing', const Color(0xFF2C64B4), const Color(0xFF2C64B4)),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildMessages() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Messages'),
          _buildMessageRow('Dr. Smith', 'Update on John Miller\'s progress'),
          _buildMessageRow('Nurse Kelly', 'Reminder: Call Linda Garcia today'),
          _buildMessageRow('Karen', 'Can we discuss Michael Chen\'s needs?'),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildTaskManager() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Task Manager'),
          _buildTaskRow(Icons.medical_services, 'Medication Check', 'Overdue', Colors.red),
          _buildTaskRow(Icons.description, 'Insurance Assist.', 'Due Today', Colors.teal),
          _buildTaskRow(Icons.calendar_today, 'Follow-Up Call', '', Colors.transparent),
          _buildTaskRow(Icons.check_box, 'Care Coordination', '', Colors.transparent),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildNextAppointments() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Next Appointments'),
          _buildApptRow('Anna Wilson', 'Apr 25, 10:00 AM'),
          _buildApptRow('Robert Lee', 'Apr 26, 2:30 PM'),
          _buildApptRow('Emily Turner', 'Apr 27, 9:45 AM'),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildResourceCenter() {
    return Container(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: const Offset(0, 2))]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionHeader('Resource Center'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildResourceLink('Care Guidelines'),
                      const SizedBox(height: 20),
                      _buildResourceLink('Insurance Info'),
                      const SizedBox(height: 20),
                      _buildResourceLink('Patient Education'),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildResourceLink('Patient Forms'),
                      const SizedBox(height: 20),
                      _buildResourceLink('Support Services'),
                      const SizedBox(height: 40), 
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper bindings 
  Widget _buildListTile(IconData icon, String name, String sub, Color iconC, Color subC) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: iconC, size: 20),
          const SizedBox(width: 12),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2C64B4), fontSize: 13)),
          Expanded(child: Text(sub, style: TextStyle(color: subC, fontSize: 13), overflow: TextOverflow.ellipsis)),
        ],
      ),
    );
  }

  Widget _buildMessageRow(String sender, String msg) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          const Icon(Icons.chat_bubble, color: Color(0xFF2C64B4), size: 18),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                text: '$sender: ',
                style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2C64B4), fontSize: 13),
                children: [
                  TextSpan(text: '"$msg"', style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.black87)),
                ]
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskRow(IconData icon, String title, String badge, Color badgeColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
           Icon(icon, color: const Color(0xFF2C64B4), size: 20),
           const SizedBox(width: 12),
           Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF2C3E50), fontSize: 13), overflow: TextOverflow.ellipsis)),
           if (badge.isNotEmpty)
             Container(
               padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
               decoration: BoxDecoration(color: badgeColor, borderRadius: BorderRadius.circular(4)),
               child: Text(badge, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
             ),
           const SizedBox(width: 8),
           const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildApptRow(String name, String time) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
           const Icon(Icons.check_circle, color: Color(0xFF2C64B4), size: 20),
           const SizedBox(width: 12),
           Expanded(
             child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2C3E50), fontSize: 13)),
                  Text(time, style: const TextStyle(fontWeight: FontWeight.normal, color: Colors.grey, fontSize: 11)),
                ]
             ),
           ),
           const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildResourceLink(String title) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(color: const Color(0xFF2C64B4), borderRadius: BorderRadius.circular(4)),
          child: const Icon(Icons.description, color: Colors.white, size: 10),
        ),
        const SizedBox(width: 6),
        Expanded(child: Text(title, style: const TextStyle(color: Color(0xFF2C64B4), fontWeight: FontWeight.w600, fontSize: 12), overflow: TextOverflow.ellipsis)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F4F7),
      appBar: AppBar(
        titleSpacing: 16,
        backgroundColor: const Color(0xFF2864AD),
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.add_box, color: Colors.white, size: 24),
            SizedBox(width: 8),
            Text('PSW DASH', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16, letterSpacing: 1.0)),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Row(
              children: const [
                CircleAvatar(
                  radius: 14,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color: Color(0xFF2864AD), size: 18),
                ),
                SizedBox(width: 8),
                // Hide name on extremely tight screens
                Text('Sarah', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
                Icon(Icons.keyboard_arrow_down, color: Colors.white, size: 20),
              ],
            ),
          )
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isDesktop = constraints.maxWidth >= 900;
          
          if (isDesktop) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildTopKpiCard('Total Patients', '1,532', Icons.people, const Color(0xFF3498DB))),
                      const SizedBox(width: 20),
                      Expanded(child: _buildTopKpiCard('New Referrals', '24', Icons.person_add, const Color(0xFF3498DB))),
                      const SizedBox(width: 20),
                      Expanded(child: _buildTopKpiCard('Follow-Ups Due', '18', Icons.fact_check_outlined, const Color(0xFF1ABC9C))),
                      const SizedBox(width: 20),
                      Expanded(child: _buildTopKpiCard('Overdue Tasks', '5', Icons.check_box, const Color(0xFFE74C3C))),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildPatientOverview(),
                            const SizedBox(height: 24),
                            _buildRecentPatients(),
                            const SizedBox(height: 24),
                            _buildMessages(),
                          ],
                        ),
                      ),
                      const SizedBox(width: 24),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildTaskManager(),
                            const SizedBox(height: 24),
                            _buildNextAppointments(),
                            const SizedBox(height: 24),
                            _buildResourceCenter(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            // -- MOBILE RESPONSIVE LAYOUT --
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(child: _buildTopKpiCard('Patients', '1,532', Icons.people, const Color(0xFF3498DB))),
                      const SizedBox(width: 12),
                      Expanded(child: _buildTopKpiCard('Referrals', '24', Icons.person_add, const Color(0xFF3498DB))),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildTopKpiCard('Follow-Ups', '18', Icons.fact_check_outlined, const Color(0xFF1ABC9C))),
                      const SizedBox(width: 12),
                      Expanded(child: _buildTopKpiCard('Overdue', '5', Icons.check_box, const Color(0xFFE74C3C))),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text('PRIORITY WORKFLOW', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 11, letterSpacing: 1.2)),
                  const SizedBox(height: 12),
                  _buildTaskManager(),
                  const SizedBox(height: 16),
                  _buildNextAppointments(),
                  const SizedBox(height: 32),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
