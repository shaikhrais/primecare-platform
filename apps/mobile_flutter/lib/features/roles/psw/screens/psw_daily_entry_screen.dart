import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswDailyEntryScreen extends StatefulWidget {
  const PswDailyEntryScreen({super.key});

  @override
  State<PswDailyEntryScreen> createState() => _PswDailyEntryScreenState();
}

class _PswDailyEntryScreenState extends State<PswDailyEntryScreen> {
  final Map<String, double> _sliders = {
    'Meals Eaten %': 50,
    'Pain Level': 0,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Care Log (ADL)'),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Hygiene & Dressing', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(border: OutlineInputBorder(), labelText: 'Assistance Level'),
                    items: const [
                      DropdownMenuItem(value: 'Independent', child: Text('Independent')),
                      DropdownMenuItem(value: 'Assist', child: Text('Partial Assist')),
                      DropdownMenuItem(value: 'Full', child: Text('Full Support')),
                    ],
                    onChanged: (val) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Toileting & Mobility', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 16),
                  SwitchListTile(
                    title: const Text('Walker / Cane used?'),
                    value: true,
                    onChanged: (v) {},
                  ),
                  SwitchListTile(
                    title: const Text('Bed Transfer completed?'),
                    value: true,
                    onChanged: (v) {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            PrimeCareCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Nutrition & Vitals', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 16),
                  Text('Meals Eaten: ${_sliders['Meals Eaten %']?.round()}%'),
                  Slider(
                    value: _sliders['Meals Eaten %']!,
                    min: 0,
                    max: 100,
                    divisions: 4,
                    onChanged: (val) => setState(() => _sliders['Meals Eaten %'] = val),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Blood Pressure (e.g. 120/80)', border: OutlineInputBorder()),
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Temperature (°C)', border: OutlineInputBorder()),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            PrimeCareButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Daily Entry securely saved.')));
                context.pop();
              },
              icon: Icons.save,
              label: 'Submit Daily Form',
              isFullWidth: true,
            ),
            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }
}
