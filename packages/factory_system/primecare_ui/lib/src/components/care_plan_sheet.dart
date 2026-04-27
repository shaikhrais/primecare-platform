// Layer: 01_INFRASTRUCTURE
import 'package:primecare_ui/src/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CarePlanSheet extends StatefulWidget {
  final String patientId;
  const CarePlanSheet({super.key, required this.patientId});

  @override
  State<CarePlanSheet> createState() => _CarePlanSheetState();
}

class _CarePlanSheetState extends State<CarePlanSheet> {
  Map<String, dynamic>? _carePlan;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchCarePlan();
  }

  Future<void> _fetchCarePlan() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('api_token') ?? '';

      final res = await http.get(
        Uri.parse(
          'https://primecare-api.itpro-mohammed.workers.dev/v1/psw/care-plan/${widget.patientId}',
        ),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (mounted) {
        if (res.statusCode == 200) {
          setState(() {
            _carePlan = json.decode(res.body) as Map<String, dynamic>?;
            _isLoading = false;
          });
        } else if (res.statusCode == 404) {
          setState(() {
            _error = 'No active care plan found for this patient.';
            _isLoading = false;
          });
        } else {
          setState(() {
            _error = 'Failed to load care plan: ${res.statusCode}';
            _isLoading = false;
          });
        }
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = 'Network error: $e';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Active Care Plan',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo,
                ),
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
          const Divider(),
          if (_isLoading)
            const Expanded(child: Center(child: CircularProgressIndicator()))
          else if (_error != null)
            Expanded(
              child: Center(
                child: Text(
                  _error!,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                    color: PrimeCareColors.rose,
                    fontSize: 16,
                  ),
                ),
              ),
            )
          else if (_carePlan != null)
            Expanded(
              child: ListView(
                children: [
                  _buildSection(
                    'Patient',
                    ((_carePlan!['client']
                                as Map<String, dynamic>?)?['fullName']
                            as String?) ??
                        'Unknown',
                  ),
                  _buildSection(
                    'Authored By (RN)',
                    ((_carePlan!['author']
                                as Map<String, dynamic>?)?['fullName']
                            as String?) ??
                        'System Generated',
                  ),
                  _buildSection(
                    'Last Reviewed',
                    _carePlan!['reviewDate'] != null
                        ? _carePlan!['reviewDate'].toString().substring(0, 10)
                        : 'Never',
                  ),
                  const SizedBox(height: 16),
                  _buildCard(
                    'Primary Diagnoses',
                    (_carePlan!['diagnoses'] as String?) ?? 'None documented',
                  ),
                  _buildCard(
                    'Clinical Goals',
                    (_carePlan!['clinicalGoals'] as String?) ??
                        'No specific goals',
                  ),
                  _buildCard(
                    'Required Interventions',
                    (_carePlan!['interventions'] as String?) ??
                        'Standard ADL care',
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: PrimeCareColors.slate400,
            ),
          ),
          Text(
            value,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(String title, String content) {
    return Card(
      elevation: 0,
      color: Colors.indigo.shade50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: const TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
