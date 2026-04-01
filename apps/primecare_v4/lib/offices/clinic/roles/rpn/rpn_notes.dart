import 'package:flutter/material.dart';
import '../../../../office/components/glass_surface.dart';
import '../../../../core/theme/app_theme.dart';

class RpnNotesView extends StatelessWidget {
  const RpnNotesView({Key? key}) : super(key: key);

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
            Text('RPN Clinical Progress Notes', style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, fontFamily: 'Outfit')),
            const SizedBox(height: 24),
            const GlassSurface(
              padding: EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Active Note Session', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueGrey)),
                  SizedBox(height: 16),
                  TextField(decoration: InputDecoration(hintText: 'Subjective: Patient reports...')),
                  SizedBox(height: 12),
                  TextField(decoration: InputDecoration(hintText: 'Objective: Observed vital signs...')),
                  SizedBox(height: 48),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
