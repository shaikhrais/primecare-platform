import 'package:flutter/material.dart';

class IncidentReportsScreen extends StatelessWidget {
  const IncidentReportsScreen({super.key});

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
                'Incident Reports & Logs',
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
                icon: const Icon(Icons.add_alert),
                label: const Text(
                  'New Report',
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
          // Filter / Search Bar
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF191C1E).withOpacity(0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
              border: Border.all(color: const Color(0xFFE0E3E5).withOpacity(0.5)),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Color(0xFF6D7A72)),
                const SizedBox(width: 16),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search by patient, date, or severity...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontFamily: 'Inter',
                        color: Color(0xFFBCCAC0),
                      ),
                    ),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      color: Color(0xFF191C1E),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 24,
                  color: const Color(0xFFE0E3E5),
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.filter_list, color: Color(0xFF5654A8)),
                  label: const Text(
                    'Filter',
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF5654A8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Panel: Incident List
                Expanded(
                  flex: 5,
                  child: Container(
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
                    clipBehavior: Clip.antiAlias,
                    child: ListView(
                      children: [
                        _buildIncidentListItem(
                          patientName: 'Emma Richardson',
                          patientId: 'MRN-78291',
                          type: 'Fall (Unwitnessed)',
                          date: 'Oct 24, 2023 - 14:30',
                          severity: 'Critical',
                          status: 'Open',
                          isSelected: true,
                        ),
                        const Divider(height: 1, color: Color(0xFFE0E3E5)),
                        _buildIncidentListItem(
                          patientName: 'Liam Chen',
                          patientId: 'MRN-44102',
                          type: 'Medication Error',
                          date: 'Oct 23, 2023 - 09:15',
                          severity: 'Warning',
                          status: 'Resolved',
                          isSelected: false,
                        ),
                        const Divider(height: 1, color: Color(0xFFE0E3E5)),
                        _buildIncidentListItem(
                          patientName: 'Sophia Patel',
                          patientId: 'MRN-90211',
                          type: 'Skin Tear',
                          date: 'Oct 22, 2023 - 18:45',
                          severity: 'Low',
                          status: 'Resolved',
                          isSelected: false,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 32),
                // Right Panel: Detailed View
                Expanded(
                  flex: 5,
                  child: Container(
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
                    padding: const EdgeInsets.all(32.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Incident Details',
                                  style: TextStyle(
                                    fontFamily: 'Outfit',
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF5654A8), // Navy Indigo
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'INC-20231024-01 | Reported by RN J. Smith',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    color: const Color(0xFF6D7A72).withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF4F4),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(color: const Color(0xFFFFDADA)),
                              ),
                              child: const Text(
                                'Critical',
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                  color: Color(0xFFBA1A1A),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 32),
                        const Text(
                          'Description',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF3D4A42),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Patient was found on the floor near the bathroom. Patient stated they slipped while trying to reach the sink. No immediate visible injuries, but patient complains of right hip pain. Vitals taken and physician notified immediately.',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            color: Color(0xFF191C1E),
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Immediate Actions Taken',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Color(0xFF3D4A42),
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          '• Assisted patient back to bed with 2-person assist.\n• Full body assessment completed.\n• Dr. Martinez paged at 14:35.\n• Neurological vitals initiated.',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 15,
                            color: Color(0xFF191C1E),
                            height: 1.5,
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFF5654A8),
                                  side: const BorderSide(color: Color(0xFF5654A8)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  'Add Follow-up Note',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
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
                                  'Mark as Resolved',
                                  style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIncidentListItem({
    required String patientName,
    required String patientId,
    required String type,
    required String date,
    required String severity,
    required String status,
    required bool isSelected,
  }) {
    Color severityColor;
    Color severityBgColor;

    switch (severity.toLowerCase()) {
      case 'critical':
        severityColor = const Color(0xFFBA1A1A);
        severityBgColor = const Color(0xFFFFF4F4);
        break;
      case 'warning':
        severityColor = const Color(0xFFB36B00);
        severityBgColor = const Color(0xFFFFF8E5);
        break;
      default:
        severityColor = const Color(0xFF006948);
        severityBgColor = const Color(0xFFE6F0EC);
    }

    return Container(
      color: isSelected ? const Color(0xFFF4F7FB) : Colors.transparent,
      padding: const EdgeInsets.all(24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: severityBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.report_problem, color: severityColor, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      patientName,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF191C1E),
                      ),
                    ),
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
                const SizedBox(height: 4),
                Text(
                  patientId,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12,
                    color: Color(0xFF6D7A72),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Color(0xFF3D4A42),
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: status == 'Open' ? const Color(0xFFE6EFFF) : const Color(0xFFF2F4F6),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            status,
                            style: TextStyle(
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                              color: status == 'Open' ? const Color(0xFF0055CC) : const Color(0xFF6D7A72),
                            ),
                          ),
                        ),
                        if (isSelected) const SizedBox(width: 16),
                        if (isSelected) const Icon(Icons.chevron_right, color: Color(0xFF6D7A72)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
