import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class ViewScheduleView extends StatelessWidget {
  const ViewScheduleView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Care Schedule', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildScheduleItem('RN Assessment', 'RN Arthur Dent', 'Today, 02:00 PM', Colors.teal),
            _buildScheduleItem('Physical Therapy', 'Physio Slartibartfast', 'Tomorrow, 10:00 AM', Colors.indigo),
            _buildScheduleItem('Follow-up Wellness Sync', 'Dr. Aris Thorne', 'Friday, 03:00 PM', Colors.teal),
          ],
        ),
      ),
    );
  }

  Widget _buildScheduleItem(String service, String provider, String time, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Icon(Icons.event, color: color),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(provider, style: const TextStyle(color: Colors.blueGrey, fontSize: 13)),
                ],
              ),
            ),
            Text(time, style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
