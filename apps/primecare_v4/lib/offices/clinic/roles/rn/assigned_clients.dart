import 'package:flutter/material.dart';

class AssignedClientsScreen extends StatelessWidget {
  const AssignedClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(),
          const SizedBox(height: 32),
          Expanded(
            child: _buildClientGrid(),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Assigned Clients',
          style: TextStyle(
            fontFamily: 'Outfit',
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF191C1E),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F4F6),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.search, color: Color(0xFF3D4A42)),
                    hintText: 'Search patients by name, ID, or diagnosis...',
                    border: InputBorder.none,
                    hintStyle: TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFF3D4A42),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 24),
            _buildFilterChip('All', true),
            const SizedBox(width: 12),
            _buildFilterChip('Critical', false),
            const SizedBox(width: 12),
            _buildFilterChip('Routine', false),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF006948) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: isSelected ? null : Border.all(color: const Color(0xFFBCCAC0), width: 1),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          fontWeight: FontWeight.w600,
          color: isSelected ? Colors.white : const Color(0xFF3D4A42),
        ),
      ),
    );
  }

  Widget _buildClientGrid() {
    final clients = [
      {'name': 'Jane Smith', 'age': '72', 'dx': 'Congestive Heart Failure', 'next': 'Vitals Check @ 10:30 AM', 'critical': true},
      {'name': 'John Doe', 'age': '65', 'dx': 'Type 2 Diabetes', 'next': 'Blood Sugar Monitoring @ 1:00 PM', 'critical': false},
      {'name': 'Alice Johnson', 'age': '81', 'dx': 'Post-Op Hip Replacement', 'next': 'Physical Therapy @ 2:15 PM', 'critical': false},
      {'name': 'Robert Brown', 'age': '59', 'dx': 'Chronic Obstructive Pulm. Disease', 'next': 'Medication Admin @ 9:00 AM', 'critical': true},
      {'name': 'Emily Davis', 'age': '45', 'dx': 'Asthma', 'next': 'Routine Check @ 3:00 PM', 'critical': false},
      {'name': 'Michael Wilson', 'age': '68', 'dx': 'Hypertension', 'next': 'BP Check @ 11:30 AM', 'critical': false},
    ];

    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 24,
        mainAxisSpacing: 24,
        childAspectRatio: 1.1,
      ),
      itemCount: clients.length,
      itemBuilder: (context, index) {
        return _buildClientCard(clients[index]);
      },
    );
  }

  Widget _buildClientCard(Map<String, dynamic> client) {
    final isCritical = client['critical'] as bool;
    
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9), // Glassmorphic feel
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF191C1E).withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(24),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: isCritical ? const Color(0xFFE54A4A) : const Color(0xFF006948),
                width: 4,
              ),
            ),
          ),
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      client['name']!,
                      style: const TextStyle(
                        fontFamily: 'Outfit',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF191C1E),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: isCritical ? const Color(0xFFFCE8E8) : const Color(0xFFE6F0EC),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      isCritical ? 'Critical' : 'Routine',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: isCritical ? const Color(0xFFE54A4A) : const Color(0xFF006948),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Age ${client['age']} • ${client['dx']}',
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: Color(0xFF3D4A42),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F4F6),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.access_time_filled, size: 16, color: Color(0xFF5654A8)), // Navy Indigo
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        client['next']!,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF1E1B4B), // Navy
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF006948),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    elevation: 0,
                  ),
                  onPressed: () {},
                  child: const Text(
                    'View Patient Record',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
