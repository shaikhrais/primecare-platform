import 'package:flutter/material.dart';

class ProgressUpdatesScreen extends StatelessWidget {
  const ProgressUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Weekly Progress Updates',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF191C1E),
                ),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF006948), // Emerald Teal
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  elevation: 0,
                ),
                onPressed: () {},
                icon: const Icon(Icons.add_comment),
                label: const Text(
                  'Add Update',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Patient Summary Banner
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF191C1E).withOpacity(0.04),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
              border: Border.all(color: const Color(0xFFE0E3E5).withOpacity(0.5)),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: const Color(0xFFE6F0EC),
                  child: const Text(
                    'ER',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF006948),
                    ),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Emma Richardson',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5654A8), // Navy Indigo
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Room 204 | Post-Op Hip Replacement Cycle',
                        style: TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 14,
                          color: const Color(0xFF6D7A72).withOpacity(0.8),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 48,
                  color: const Color(0xFFE0E3E5),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'Primary Goal',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(0xFF3D4A42),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Independent Mobility (50m)',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        color: Color(0xFF191C1E),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Timeline Feed
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: ListView(
                  children: [
                    _buildTimelineCard(
                      date: 'Today, 10:30 AM',
                      staffName: 'Sarah Jenkins',
                      staffRole: 'PT',
                      goal: 'Mobility & Transfer',
                      content: 'Emma successfully walked 20 meters with a walker. Showed improved confidence and reduced pain compared to yesterday. Continuing gait training exercises.',
                      status: 'On Track',
                    ),
                    const SizedBox(height: 16),
                    _buildTimelineCard(
                      date: 'Oct 24, 2023, 14:15 PM',
                      staffName: 'Dr. Martinez',
                      staffRole: 'Attending',
                      goal: 'Pain Management',
                      content: 'Pain reported at 4/10 during resting. Discontinuing IV analgesics and transitioning to oral meds. Incision site clean, no signs of infection.',
                      status: 'On Track',
                    ),
                    const SizedBox(height: 16),
                    _buildTimelineCard(
                      date: 'Oct 23, 2023, 09:00 AM',
                      staffName: 'Jessica Smith',
                      staffRole: 'RN',
                      goal: 'Wound Care',
                      content: 'Dressing changed this morning. Small amount of serosanguinous drainage noted, which is expected. Patient educated on keeping the area dry.',
                      status: 'Needs Review',
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineCard({
    required String date,
    required String staffName,
    required String staffRole,
    required String goal,
    required String content,
    required String status,
  }) {
    Color statusColor;
    Color statusBgColor;

    if (status == 'On Track') {
      statusColor = const Color(0xFF006948);
      statusBgColor = const Color(0xFFE6F0EC);
    } else if (status == 'Needs Review') {
      statusColor = const Color(0xFFB36B00);
      statusBgColor = const Color(0xFFFFF8E5);
    } else {
      statusColor = const Color(0xFF5654A8);
      statusBgColor = const Color(0xFFEEEDF9);
    }

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF191C1E).withOpacity(0.02),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFE0E3E5).withOpacity(0.5)),
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: const Color(0xFFF2F4F6),
                    child: Text(
                      staffName.substring(0, 1),
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(0xFF3D4A42),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            staffName,
                            style: const TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color(0xFF191C1E),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF2F4F6),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              staffRole,
                              style: const TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF6D7A72),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        date,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 12,
                          color: Color(0xFF6D7A72),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusBgColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Goal: $goal',
            style: const TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: Color(0xFF5654A8), // Navy Indigo
            ),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 15,
              color: Color(0xFF191C1E),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
