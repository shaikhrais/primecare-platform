import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../../core/api_client.dart';

class RnPatient {
  final String id;
  final String fullName;
  final String? dob;
  final String? city;
  final String? province;

  RnPatient({required this.id, required this.fullName, this.dob, this.city, this.province});
}

class RnPatientsScreen extends StatefulWidget {
  const RnPatientsScreen({super.key});

  @override
  State<RnPatientsScreen> createState() => _RnPatientsScreenState();
}

class _RnPatientsScreenState extends State<RnPatientsScreen> {
  bool _isLoading = true;
  List<RnPatient> _patients = [];

  @override
  void initState() {
    super.initState();
    _fetchPatients();
  }

  Future<void> _fetchPatients() async {
    try {
      final response = await apiClient.get('/v1/rn/patients');
      if (response != null && mounted) {
        final List<dynamic> jsonList = response is Map && response['mocked'] == true ? [] : response;
        setState(() {
          _patients = jsonList.map((j) => RnPatient(
            id: j['id'],
            fullName: j['fullName'],
            dob: j['dob'],
            city: j['city'],
            province: j['province']
          )).toList();
          _isLoading = false;
        });
      }
    } catch(e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Color primary = Theme.of(context).primaryColor;
    return PrimeCareScaffold(
      body: _isLoading 
      ? const Center(child: CircularProgressIndicator())
      : SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.people_alt_rounded, size: 48, color: primary),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Registered Patients Matrix', style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
                      Text('DB -> API -> UI Execution Tracker natively mapping Prisma arrays.', style: TextStyle(color: Colors.grey[600], fontWeight: FontWeight.w600)),
                    ]
                  )
                ]
              ),
              const SizedBox(height: 32),
              _patients.isEmpty 
              ? PrimeCareCard(child: const Center(child: Padding(padding: EdgeInsets.all(32), child: Text('No Active Database Patient Rows Rendered.', style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 18)))))
              : ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _patients.length,
                itemBuilder: (context, index) {
                   final p = _patients[index];
                   return PrimeCareCard(
                     margin: const EdgeInsets.only(bottom: 12),
                     padding: EdgeInsets.zero,
                     child: ListTile(
                       contentPadding: const EdgeInsets.all(12),
                       leading: CircleAvatar(backgroundColor: primary.withValues(alpha:0.1), child: Icon(Icons.person, color: primary)),
                       title: Text(p.fullName, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: PrimeCareColors.radarDark)),
                       subtitle: Text('\${p.city ?? 'Unknown City'}, \${p.province ?? 'NA'} - DOB: \${p.dob?.substring(0,10) ?? 'Not Provided'}'),
                       trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                       onTap: () { ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Opening \${p.fullName} Clinical Profile Server Connection...'))); },
                     )
                   );
                }
              )
            ]
          )
        )
    );
  }
}
