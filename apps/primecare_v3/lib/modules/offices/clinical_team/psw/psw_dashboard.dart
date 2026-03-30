import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../../../core/components/role_data_builder.dart';
import 'psw_data_entry_page.dart';

class PswDashboardWidget extends StatelessWidget {
  const PswDashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScrollWrapper(
      physics: const BouncingScrollPhysics(),
      child: PrimeCareContainer(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const PrimeCareText('PSW Dashboard', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const PrimeCareSizedBox(height: 16),
            RoleDataBuilder(
              roleId: 'psw',
              builder: (context, data) {
                return DashboardKpiGrid(kpis: data.kpis, title: '\${data.greetingTitle} | Metrics');
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              icon: const Icon(Icons.storage),
              label: const Text('Access Global Data Entry Hub'),
              style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => const PswDataEntryPage()),
                );
              },
            ),
          ]
        ),
      )
    );
  }
}
