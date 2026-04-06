import 'package:flutter/material.dart';

class VitalsScreen extends StatelessWidget {
  const VitalsScreen({super.key});

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
                'Vital Signs Dashboard',
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
                icon: const Icon(Icons.add),
                label: const Text(
                  'Record Vitals',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Left Panel: Entry Form Placeholder
                Expanded(
                  flex: 4,
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
                        const Text(
                          'Quick Entry',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF5654A8), // Navy Indigo
                          ),
                        ),
                        const SizedBox(height: 32),
                        _buildInputField('Blood Pressure', 'mmHg', 'e.g., 120/80'),
                        const SizedBox(height: 24),
                        _buildInputField('Heart Rate', 'bpm', 'e.g., 75'),
                        const SizedBox(height: 24),
                        _buildInputField('SpO2', '%', 'e.g., 98'),
                        const SizedBox(height: 24),
                        _buildInputField('Temperature', '°C', 'e.g., 37.0'),
                        const SizedBox(height: 24),
                        _buildInputField('Respiratory Rate', 'bpm', 'e.g., 16'),
                        const Spacer(),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF006948),
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              elevation: 0,
                            ),
                            onPressed: () {},
                            child: const Text(
                              'Save Readings',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 32),
                // Right Panel: Recent Readings & Trends
                Expanded(
                  flex: 6,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recent Measurements',
                        style: TextStyle(
                          fontFamily: 'Outfit',
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF191C1E),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 16,
                          mainAxisSpacing: 16,
                          childAspectRatio: 1.5,
                          children: [
                            _buildMetricCard(
                              title: 'Blood Pressure',
                              value: '142/90',
                              unit: 'mmHg',
                              icon: Icons.monitor_heart,
                              isAbnormal: true,
                              trend: '+5 from last',
                            ),
                            _buildMetricCard(
                              title: 'Heart Rate',
                              value: '88',
                              unit: 'bpm',
                              icon: Icons.favorite,
                              isAbnormal: false,
                              trend: '-2 from last',
                            ),
                            _buildMetricCard(
                              title: 'SpO2',
                              value: '97',
                              unit: '%',
                              icon: Icons.air,
                              isAbnormal: false,
                              trend: 'Stable',
                            ),
                            _buildMetricCard(
                              title: 'Temperature',
                              value: '38.1',
                              unit: '°C',
                              icon: Icons.thermostat,
                              isAbnormal: true,
                              trend: '+0.4 from last',
                            ),
                          ],
                        ),
                      ),
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

  Widget _buildInputField(String label, String unit, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF3D4A42),
              ),
            ),
            Text(
              unit,
              style: const TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                color: Color(0xFF6D7A72),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: const Color(0xFFF2F4F6),
            borderRadius: BorderRadius.circular(12),
          ),
          child: TextField(
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(
                fontFamily: 'Inter',
                color: Color(0xFFBCCAC0),
              ),
              border: InputBorder.none,
            ),
            keyboardType: TextInputType.number,
            style: const TextStyle(
              fontFamily: 'Inter',
              color: Color(0xFF191C1E),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String unit,
    required IconData icon,
    required bool isAbnormal,
    required String trend,
  }) {
    Color valueColor = isAbnormal ? const Color(0xFFBA1A1A) : const Color(0xFF191C1E);
    Color bgHighlight = isAbnormal ? const Color(0xFFFFF4F4) : const Color(0xFFE6F0EC);
    Color iconColor = isAbnormal ? const Color(0xFFBA1A1A) : const Color(0xFF006948);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isAbnormal ? const Color(0xFFFFDADA) : const Color(0xFFE0E3E5).withOpacity(0.5),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF191C1E).withOpacity(0.02),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Color(0xFF5654A8), // Navy Indigo
                ),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: bgHighlight,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20, color: iconColor),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                value,
                style: TextStyle(
                  fontFamily: 'Outfit',
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: valueColor,
                  height: 1.0,
                ),
              ),
              const SizedBox(width: 8),
              Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Text(
                  unit,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    color: Color(0xFF6D7A72),
                  ),
                ),
              ),
            ],
          ),
          Text(
            trend,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isAbnormal ? const Color(0xFF93000A) : const Color(0xFF6D7A72),
            ),
          ),
        ],
      ),
    );
  }
}
