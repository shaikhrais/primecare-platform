import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswMarScreen extends StatefulWidget {
  const PswMarScreen({super.key});

  @override
  State<PswMarScreen> createState() => _PswMarScreenState();
}

class _PswMarScreenState extends State<PswMarScreen> {
  final List<Map<String, dynamic>> _meds = [
    {'name': 'Lisinopril', 'dose': '10mg', 'time': '08:00 AM', 'status': 'PENDING'},
    {'name': 'Metformin', 'dose': '500mg', 'time': '12:00 PM', 'status': 'PENDING'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _meds.length,
        itemBuilder: (context, index) {
          final med = _meds[index];
          return PrimeCareCard(
            margin: const EdgeInsets.only(bottom: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('${med['name']} - ${med['dose']}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    PrimeStatusBadge(
                      text: med['status'], 
                      color: med['status'] == 'PENDING' ? Colors.orange : (med['status'] == 'ADMINISTERED' ? Colors.green : Colors.red)
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text('Scheduled: ${med['time']}', style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 16),
                if (med['status'] == 'PENDING') ...[
                  Row(
                    children: [
                      Expanded(
                        child: PrimeCareButton(
                          onPressed: () {
                            setState(() => med['status'] = 'ADMINISTERED');
                          },
                          label: 'Administer',
                          icon: Icons.check,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: PrimeCareButton(
                          type: PrimeCareButtonType.secondary,
                          onPressed: () {
                            setState(() => med['status'] = 'REFUSED');
                          },
                          label: 'Refused',
                          icon: Icons.close,
                        ),
                      ),
                    ],
                  ),
                ]
              ],
            ),
          );
        }
      ),
    );
  }
}
