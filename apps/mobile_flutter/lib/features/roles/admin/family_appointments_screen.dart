import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final familyApptsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/family-appointments'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['appointments'] as List<dynamic>;
    } else {
      throw Exception('Failed to load apps');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class FamilyAppointmentsScreen extends ConsumerWidget {
  const FamilyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final apptsAsync = ref.watch(familyApptsProvider);

    return Scaffold(
      backgroundColor: Colors.teal.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Family Appointments'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Upcoming Visits & Calendar', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Book Appointment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 600,
               desktopCrossAxisCount: 3,
               children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        const Text('Monthly Schedule', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(child: PrimeCareCard(child: const Center(child: Text('Interactive Calendar Engine Placeholder', style: TextStyle(color: Colors.grey))))),
                     ]
                  ),
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        const Text('Upcoming Visits', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: apptsAsync.when(
                              data: (appts) {
                                 if (appts.isEmpty) return const PrimeCareCard(child: Center(child: Text('No upcoming appts')));
                                 return ListView.separated(
                                    itemCount: appts.length,
                                    separatorBuilder: (c, i) => const SizedBox(height: 16),
                                    itemBuilder: (c, i) => _buildApptCard(appts[i]),
                                 );
                              },
                              loading: () => const Center(child: CircularProgressIndicator()),
                              error: (e, st) => Center(child: Text('Error: $e')),
                           )
                        )
                     ]
                  ),
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        const Text('Care Providers', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: ListView(
                              children: [
                                 _buildProviderCard('Dr. Evans', 'Pediatrics', 'https://api.dicebear.com/7.x/avataaars/png?seed=1'),
                                 const SizedBox(height: 16),
                                 _buildProviderCard('Nurse Patel', 'Family Health', 'https://api.dicebear.com/7.x/avataaars/png?seed=2'),
                              ]
                           )
                        )
                     ]
                  ),
               ]
            ),
          ]
        ),
      ),
    );
  }

  Widget _buildApptCard(dynamic appt) {
      final date = DateTime.parse(appt['date']);
      return PrimeCareCard(
         child: Row(
            children: [
               Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(color: Colors.teal.shade50, borderRadius: BorderRadius.circular(12)),
                  child: Column(
                     children: [
                        Text('${date.month}/${date.day}', style: TextStyle(color: Colors.teal.shade700, fontWeight: FontWeight.bold)),
                        Text(appt['time'], style: const TextStyle(color: Colors.black54, fontSize: 10)),
                     ]
                  )
               ),
               const SizedBox(width: 16),
               Expanded(
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                     children: [
                        Text(appt['title'], style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text('For: ${appt["patientName"]}', style: const TextStyle(color: Colors.black87, fontSize: 11)),
                        const SizedBox(height: 4),
                        Row(
                           children: [
                              Icon(Icons.person, size: 12, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Text(appt['doctorName'], style: const TextStyle(color: Colors.black54, fontSize: 10)),
                              const SizedBox(width: 12),
                              Icon(Icons.location_on, size: 12, color: Colors.grey.shade600),
                              const SizedBox(width: 4),
                              Expanded(child: Text(appt['location'], overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.black54, fontSize: 10))),
                           ]
                        )
                     ]
                  )
               )
            ]
         )
      );
  }

  Widget _buildProviderCard(String n, String role, String img) {
     return PrimeCareCard(
        child: Row(
           children: [
              CircleAvatar(backgroundImage: NetworkImage(img)),
              const SizedBox(width: 16),
              Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    Text(n, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(role, style: const TextStyle(color: Colors.black54, fontSize: 11)),
                 ]
              ),
              const Spacer(),
              const Icon(Icons.chat_bubble_outline, color: Color(0xFF0F4C81), size: 20),
           ]
        )
     );
  }
}
