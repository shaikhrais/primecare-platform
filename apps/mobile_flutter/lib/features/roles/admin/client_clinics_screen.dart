import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:primecare_ui/primecare_ui.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

final clinicsProvider = FutureProvider<List<dynamic>>((ref) async {
  try {
    // Calling the newly spun up Cloudflare Worker Prisma API endpoint
    final response = await http.get(Uri.parse('http://127.0.0.1:8787/v1/client/clinics'));
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json['clinics'] as List<dynamic>;
    } else {
      throw Exception('Failed to load clinics. Status: ${response.statusCode}');
    }
  } catch (e) {
    debugPrint('API Error: $e');
    return [];
  }
});

class ClientClinicsScreen extends ConsumerStatefulWidget {
  const ClientClinicsScreen({super.key});
  @override ConsumerState<ClientClinicsScreen> createState() => _State();
}

class _State extends ConsumerState<ClientClinicsScreen> {
  String _simulatedStatus = "Simulating load...";

  @override
  Widget build(BuildContext context) {
    final asyncData = ref.watch(clinicsProvider);

    return Scaffold(
      backgroundColor: Colors.teal.shade50.withOpacity(0.3),
      appBar: const PrimeCareAppBar(title: 'Clinics Management'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
               children: [
                  const Text('Clinics Management', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                  Container(
                     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), 
                     decoration: BoxDecoration(color: const Color(0xFF0F4C81), borderRadius: BorderRadius.circular(8)), 
                     child: const Text('Add Clinic (+)', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13))
                  )
               ]
            ),
            const SizedBox(height: 32),
            PrimeResponsiveGrid(
               desktopMainAxisExtent: 800,
               children: [
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                        const Text('Clinic Network Matrix', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                        const SizedBox(height: 16),
                        Expanded(
                           child: asyncData.when(
                              data: (clinics) {
                                 if (clinics.isEmpty) {
                                    return const PrimeCareCard(child: Center(child: Text('Network configuration empty. Check DB schema.')));
                                 }
                                 return PrimeCareDataTable<dynamic>(
                                    columns: const ['Clinic Name', 'Address', 'Status', 'Efficiency', 'Revenue'],
                                    data: clinics,
                                    rowBuilder: (clinic) {
                                       bool isCanceling = clinic['status'] == 'CANCELING'; // Simulating mockup typo Sancelting
                                       return [
                                          DataCell(Text(clinic['name'].toString(), style: const TextStyle(fontWeight: FontWeight.bold))),
                                          DataCell(Text(clinic['address'].toString(), style: const TextStyle(fontSize: 11, color: Colors.black54))),
                                          DataCell(
                                             Container(
                                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                                decoration: BoxDecoration(color: isCanceling ? Colors.red.shade100 : Colors.teal.shade100, borderRadius: BorderRadius.circular(4)),
                                                child: Text(isCanceling ? 'Sancelting' : 'Active', style: TextStyle(color: isCanceling ? Colors.red.shade700 : Colors.teal.shade700, fontSize: 10))
                                             )
                                          ),
                                          DataCell(
                                             Row(
                                                children: [
                                                   const Icon(Icons.show_chart, size: 12, color: Colors.teal),
                                                   const SizedBox(width: 4),
                                                   Text('${((clinic["efficiencyScore"] as num) * 100).toInt()}%', style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                                ]
                                             )
                                          ),
                                          DataCell(Text('\$${clinic["revenue"]}')),
                                       ];
                                    }
                                 );
                              },
                              loading: () => const Center(child: CircularProgressIndicator()),
                              error: (e, st) => Center(child: Text('API Offline: $e')),
                           )
                        )
                     ]
                  )
               ]
            )
          ]
        ),
      ),
    );
  }
}
