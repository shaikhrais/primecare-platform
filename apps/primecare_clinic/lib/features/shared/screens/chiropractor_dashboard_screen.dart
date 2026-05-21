import 'package:flutter/material.dart';

class ChiropractorDashboardScreen extends StatefulWidget {
  const ChiropractorDashboardScreen({Key? key}) : super(key: key);

  @override
  State<ChiropractorDashboardScreen> createState() => _ChiropractorDashboardScreenState();
}

class _ChiropractorDashboardScreenState extends State<ChiropractorDashboardScreen> {
  String _selectedRegion = 'Cervical';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Chiropractic Adjustments'), backgroundColor: Colors.cyan.shade700),
        body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1800),
          child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Spinal Mapping & Charting', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 24),
              SegmentedButton<String>(
                segments: const [
                  ButtonSegment(value: 'Cervical', label: Text('Cervical')),
                  ButtonSegment(value: 'Thoracic', label: Text('Thoracic')),
                  ButtonSegment(value: 'Lumbar', label: Text('Lumbar')),
                  ButtonSegment(value: 'Sacral', label: Text('Sacral')),
                ],
                selected: {_selectedRegion},
                onSelectionChanged: (Set<String> newSelection) {
                  setState(() => _selectedRegion = newSelection.first);
                },
              ),
              const SizedBox(height: 32),
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(color: Colors.cyan.shade50, borderRadius: BorderRadius.circular(16), border: Border.all(color: Colors.cyan)),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.boy, size: 100, color: Colors.cyan),
                        const SizedBox(height: 16),
                        Text('Logging adjustment for \$_selectedRegion region.', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Adjustment securely logged.')));
                },
                icon: const Icon(Icons.check_circle),
                label: const Text('Sign Adjustment Chart'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.cyan.shade700, foregroundColor: Colors.white, minimumSize: const Size.fromHeight(56)),
              )
            ],
          ),
        ),
        ),
      ),
      ),
    );
  }
}