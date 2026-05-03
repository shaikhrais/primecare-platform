import 'package:primecare_ui/primecare_ui.dart';

/// [Component] - API Endpoint Registration Form
class ApiEntryForm extends StatefulWidget {
  const ApiEntryForm({super.key});

  @override
  State<ApiEntryForm> createState() => _ApiEntryFormState();
}

class _ApiEntryFormState extends State<ApiEntryForm> {
  final _formKey = GlobalKey<FormState>();
  final _pathController = TextEditingController();
  String _selectedMethod = 'GET';

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return ClinicalGlassPanel(
      title: 'API Endpoint Registration',
      icon: Icons.api_rounded,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Map new API endpoints to the platform gateway.'),
            const SizedBox(height: 24),
            
            const Text('Endpoint Path', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextFormField(
              controller: _pathController,
              decoration: InputDecoration(
                hintText: '/api/v1/resource',
                filled: true,
                fillColor: theme.colors.background.withValues(alpha: 0.5),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            
            const SizedBox(height: 24),
            
            const Text('HTTP Method', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              children: ['GET', 'POST', 'PUT', 'DELETE'].map((m) => Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(m),
                    selected: _selectedMethod == m,
                    onSelected: (val) => setState(() => _selectedMethod = m),
                  ),
                ),
              )).toList(),
            ),
            
            const SizedBox(height: 32),
            
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Register Endpoint', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
