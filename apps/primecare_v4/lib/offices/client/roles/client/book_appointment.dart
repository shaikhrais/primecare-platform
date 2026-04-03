import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class BookAppointmentView extends StatelessWidget {
  const BookAppointmentView({Key? key}) : super(key: key);

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
            Text('Book Clinical Session', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            _buildServiceOption('Nursing Assessment', 'RN / RPN', '1 Hour', Colors.teal),
            _buildServiceOption('Physiotherapy', 'PT / PTA', '45 Mins', Colors.indigo),
            _buildServiceOption('Wellness Check', 'PSW / RPN', '30 Mins', Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceOption(String service, String role, String duration, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassSurface(
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Icon(Icons.calendar_month, color: color),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(service, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text('Provider: $role | $duration', style: const TextStyle(color: Colors.blueGrey, fontSize: 12)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.blueGrey),
          ],
        ),
      ),
    );
  }
}
