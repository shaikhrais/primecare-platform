import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class AdminFormEntryScreen extends StatefulWidget {
  const AdminFormEntryScreen({super.key});

  @override
  State<AdminFormEntryScreen> createState() => _AdminFormEntryScreenState();
}

class _AdminFormEntryScreenState extends State<AdminFormEntryScreen> {
  void _showOmniActionHub(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const _OmniActionEntrySheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Admin Omni-Action Form Hub'),
        backgroundColor: Colors.indigo.shade800,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Data Entry Pipeline',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                  color: Colors.indigo,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Centralized administrative payload generation and batch data entry across the entire PrimeCare ecosystem natively.',
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600, height: 1.5),
              ),
              const SizedBox(height: 48),

              // The requested specific button structurally
              _buildPulseButton(
                context: context,
                label: 'Create All Form Entry',
                icon: Icons.add_to_photos_rounded,
                onPressed: () => _showOmniActionHub(context),
              ),

              const Text(
                'Available Forms',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
              const SizedBox(height: 16),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
                children: [
                  _buildEntityCard(context, 'Patient Profile', Icons.elderly, Colors.blue),
                  _buildEntityCard(context, 'Care Worker', Icons.work_outline, Colors.green),
                  _buildEntityCard(context, 'Master Schedule', Icons.calendar_month, Colors.purple),
                  _buildEntityCard(context, 'Incident Report', Icons.warning_amber, Colors.red),
                ],
              ),
              const SizedBox(height: 32),
              
              // Passive metrics card
              PrimeCard(
                child: Column(
                  children: [
                    const Icon(Icons.analytics_outlined, size: 48, color: Colors.grey),
                    const SizedBox(height: 16),
                    const Text('Total Manual Entries Today', style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    const Text('0', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.indigo)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPulseButton({required BuildContext context, required String label, required IconData icon, required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.indigo.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEntityCard(BuildContext context, String title, IconData icon, MaterialColor color) {
    return Material(
      color: color.shade50,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Initializing empty $title form schema...'),
              backgroundColor: color.shade700,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color.shade700, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color.shade900,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OmniActionEntrySheet extends StatelessWidget {
  const _OmniActionEntrySheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        top: 24,
        left: 24,
        right: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Select Data Entity',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          
          Expanded(
            flex: 0,
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.1,
              children: [
                _buildEntityCard(context, 'Patient Profile', Icons.elderly, Colors.blue),
                _buildEntityCard(context, 'Care Worker', Icons.work_outline, Colors.green),
                _buildEntityCard(context, 'Master Schedule', Icons.calendar_month, Colors.purple),
                _buildEntityCard(context, 'Incident Report', Icons.warning_amber, Colors.red),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEntityCard(BuildContext context, String title, IconData icon, MaterialColor color) {
    return Material(
      color: color.shade50,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Initializing empty $title form schema...'),
              backgroundColor: color.shade700,
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.shade100,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color.shade700, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: color.shade900,
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
