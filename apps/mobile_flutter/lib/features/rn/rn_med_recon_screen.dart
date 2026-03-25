import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';

class RnMedReconScreen extends StatefulWidget {
  final String patientId;
  const RnMedReconScreen({super.key, required this.patientId});

  @override
  State<RnMedReconScreen> createState() => _RnMedReconScreenState();
}

class _RnMedReconScreenState extends State<RnMedReconScreen> {
  bool _isScanning = false;
  bool _isSubmitting = false;
  final TextEditingController _discrepanciesCtrl = TextEditingController();
  List<Map<String, dynamic>> _scannedMeds = [];

  Future<void> _simulateCameraOcrScan() async {
    setState(() => _isScanning = true);
    try {
      final data = await apiClient.post('/v1/rn/clinical/ocr-vision');
      if (mounted) {
        setState(() {
          _isScanning = false;
          _scannedMeds = List<Map<String, dynamic>>.from(data);
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isScanning = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Vision API Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  Future<void> _submitReconciliation() async {
    if (_scannedMeds.isEmpty) return;
    
    setState(() => _isSubmitting = true);
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('api_token') ?? '';
      
      final res = await http.post(
        Uri.parse('https://primecare-api.itpro-mohammed.workers.dev/v1/rn/clinical/recon'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'clientId': widget.patientId,
          'reconData': _scannedMeds,
          'discrepancies': _discrepanciesCtrl.text,
        }),
      );

      if (mounted) {
        setState(() => _isSubmitting = false);
        if (res.statusCode == 201) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Medication Reconciliation Complete!'), backgroundColor: Colors.green),
          );
          Navigator.pop(context);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${res.body}'), backgroundColor: Colors.red),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isSubmitting = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Network error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  void dispose() {
    _discrepanciesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Medication Reconciliation')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Align patient physical medication bottles with the active systemic care plan. Discrepancies represent severe clinical risk.',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            const SizedBox(height: 24),
            
            if (_scannedMeds.isEmpty)
              SizedBox(
                height: 200,
                child: Center(
                  child: _isScanning
                    ? const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                           CircularProgressIndicator(),
                           SizedBox(height: 16),
                           Text('Running AI OCR against Camera Feed...'),
                        ]
                      )
                    : ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                          backgroundColor: Colors.indigo,
                        ),
                        onPressed: _simulateCameraOcrScan,
                        icon: const Icon(Icons.camera_alt, color: Colors.white),
                        label: const Text('Scan Pill Bottles', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                ),
              )
            else ...[
              const Text('Scanned Medications (OCR Output):', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
              const SizedBox(height: 12),
              ..._scannedMeds.map((m) => Card(
                elevation: 0,
                color: Colors.green.shade50,
                child: ListTile(
                  leading: const Icon(Icons.medication, color: Colors.green),
                  title: Text('${m["name"]} ${m["dosage"]}'),
                  subtitle: Text('${m["frequency"]} via ${m["route"]}'),
                  trailing: const Icon(Icons.check_circle, color: Colors.green),
                ),
              )),
              
              const SizedBox(height: 24),
              const Text('Clinical Discrepancies & Notes:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 8),
              TextField(
                controller: _discrepanciesCtrl,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'e.g., Patient missing 500mg Metformin bottle, family states dropped in sink...',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 32),
              
              _isSubmitting
                ? const Center(child: CircularProgressIndicator())
                : PrimeButton(
                    label: 'AUTHORIZE & SYNC RECONCILIATION',
                    onPressed: _submitReconciliation,
                  ),
            ]
          ],
        ),
      ),
    );
  }
}
