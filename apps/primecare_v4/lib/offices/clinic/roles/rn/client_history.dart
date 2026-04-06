import 'package:flutter/material.dart';

class ClientHistoryScreen extends StatelessWidget {
  const ClientHistoryScreen({super.key});

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
                'Client Medical History',
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF191C1E),
                ),
              ),
              Row(
                children: [
                  OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF5654A8), // Navy Indigo
                      side: const BorderSide(color: Color(0xFF5654A8)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.file_download),
                    label: const Text(
                      'Request Records',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
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
                    icon: const Icon(Icons.edit),
                    label: const Text(
                      'Edit History',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Demographics & Emergency Contacts
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
                  radius: 40,
                  backgroundColor: const Color(0xFFE6F0EC),
                  child: const Text(
                    'ER',
                    style: TextStyle(
                      fontFamily: 'Outfit',
                      fontSize: 32,
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
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF5654A8), // Navy Indigo
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _buildDemographicPill('DOB: Jan 14, 1952 (71 y/o)'),
                          const SizedBox(width: 8),
                          _buildDemographicPill('Sex: Female'),
                          const SizedBox(width: 8),
                          _buildDemographicPill('ID: MRN-78291'),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 64,
                  color: const Color(0xFFE0E3E5),
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Emergency Contact',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Color(0xFF6D7A72),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'David Richardson (Son)',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Color(0xFF191C1E),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: const [
                        Icon(Icons.phone, size: 14, color: Color(0xFF006948)),
                        SizedBox(width: 4),
                        Text(
                          '(555) 123-4567',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 14,
                            color: Color(0xFF3D4A42),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          // Grid Setup
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 32,
              mainAxisSpacing: 32,
              childAspectRatio: 1.6,
              children: [
                _buildHistoryCard(
                  title: 'Allergies & Intolerances',
                  icon: Icons.warning,
                  iconColor: const Color(0xFFBA1A1A), // Red
                  bgColor: const Color(0xFFFFF4F4),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildListItem('Penicillin', 'Severe (Anaphylaxis)', isSevere: true),
                      const SizedBox(height: 12),
                      _buildListItem('Latex', 'Moderate (Contact Dermatitis)'),
                    ],
                  ),
                ),
                _buildHistoryCard(
                  title: 'Chronic Conditions',
                  icon: Icons.favorite,
                  iconColor: const Color(0xFF5654A8), // Indigo
                  bgColor: const Color(0xFFEEEDF9),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildListItem('Hypertension', 'Diagnosed 2015 - Managed with Amlodipine'),
                      const SizedBox(height: 12),
                      _buildListItem('Type 2 Diabetes', 'Diagnosed 2018 - Diet controlled'),
                      const SizedBox(height: 12),
                      _buildListItem('Osteoarthritis', 'Right Hip (Surgical Replacement 2023)'),
                    ],
                  ),
                ),
                _buildHistoryCard(
                  title: 'Surgical History',
                  icon: Icons.content_cut,
                  iconColor: const Color(0xFF006948), // Teal
                  bgColor: const Color(0xFFE6F0EC),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildListItem('Right Total Hip Arthroplasty', 'Oct 15, 2023 - Dr. Reynolds'),
                      const SizedBox(height: 12),
                      _buildListItem('Appendectomy', 'Mar 12, 1985'),
                    ],
                  ),
                ),
                _buildHistoryCard(
                  title: 'Family Medical History',
                  icon: Icons.family_restroom,
                  iconColor: const Color(0xFFB36B00), // Orange
                  bgColor: const Color(0xFFFFF8E5),
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildListItem('Mother', 'Coronary Artery Disease (Deceased, age 78)'),
                      const SizedBox(height: 12),
                      _buildListItem('Father', 'Type 2 Diabetes (Deceased, age 82)'),
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

  Widget _buildDemographicPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF2F4F6),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'Inter',
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: Color(0xFF3D4A42),
        ),
      ),
    );
  }

  Widget _buildHistoryCard({
    required String title,
    required IconData icon,
    required Color iconColor,
    required Color bgColor,
    required Widget content,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE0E3E5).withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF191C1E).withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bgColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: iconColor, size: 24),
              ),
              const SizedBox(width: 16),
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF191C1E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(child: SingleChildScrollView(child: content)),
        ],
      ),
    );
  }

  Widget _buildListItem(String primary, String secondary, {bool isSevere = false}) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 6),
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: isSevere ? const Color(0xFFBA1A1A) : const Color(0xFF006948),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                primary,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: isSevere ? const Color(0xFFBA1A1A) : const Color(0xFF191C1E),
                ),
              ),
              const SizedBox(height: 2),
              Text(
                secondary,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 14,
                  color: Color(0xFF6D7A72),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
