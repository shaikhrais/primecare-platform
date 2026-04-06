import 'package:flutter/material.dart';

class TodaysScheduleScreen extends StatelessWidget {
  const TodaysScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left Side: Clinical Timeline (60%)
          Expanded(
            flex: 6,
            child: _buildClinicalTimeline(),
          ),
          const SizedBox(width: 32),
          // Right Side: Upcoming Critical Tasks (40%)
          Expanded(
            flex: 4,
            child: _buildCriticalTasks(),
          ),
        ],
      ),
    );
  }

  Widget _buildClinicalTimeline() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F6), // surface-container-low
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Clinical Timeline',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF191C1E),
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return _buildTimelineItem(index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineItem(int index) {
    final times = ['08:00 AM', '10:30 AM', '01:15 PM', '03:45 PM'];
    final patients = ['John Doe', 'Jane Smith', 'Alice Johnson', 'Robert Brown'];
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 80,
            child: Text(
              times[index],
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.w600,
                color: Color(0xFF3D4A42),
              ),
            ),
          ),
          Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: const BoxDecoration(
                  color: Color(0xFF006948), // Emerald Teal
                  shape: BoxShape.circle,
                ),
              ),
              if (index != 3)
                Container(
                  width: 2,
                  height: 60,
                  color: const Color(0xFFBCCAC0),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white, // surface-container-lowest
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF191C1E).withOpacity(0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patients[index],
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Color(0xFF191C1E),
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Routine Checkup & Vitals',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 14,
                      color: Color(0xFF3D4A42),
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

  Widget _buildCriticalTasks() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.6), // Glassmorphism base
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
      ),
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Critical Tasks',
            style: TextStyle(
              fontFamily: 'Outfit',
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1E1B4B), // Navy Indigo
            ),
          ),
          const SizedBox(height: 32),
          _buildTaskCard('Review Labs', 'Jane Smith • High Priority', true),
          _buildTaskCard('Medication Verification', 'Alice Johnson • Pending', false),
          _buildTaskCard('Care Plan Update', 'Robert Brown • Due Tomorrow', false),
        ],
      ),
    );
  }

  Widget _buildTaskCard(String title, String subtitle, bool isHighPriority) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: isHighPriority
            ? const LinearGradient(
                colors: [Color(0xFF006948), Color(0xFF00855D)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: isHighPriority ? null : const Color(0xFFF7F9FB),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: isHighPriority ? Colors.white : const Color(0xFF191C1E),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 14,
              color: isHighPriority ? const Color(0xFFF5FFF7) : const Color(0xFF3D4A42),
            ),
          ),
        ],
      ),
    );
  }
}
