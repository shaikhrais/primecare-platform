import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_core/flutter_core.dart';
import 'package:flutter_ui/flutter_ui.dart';

class SubscriptionUpgradeScreen extends ConsumerStatefulWidget {
  const SubscriptionUpgradeScreen({super.key});

  @override
  ConsumerState<SubscriptionUpgradeScreen> createState() =>
      _SubscriptionUpgradeScreenState();
}

class _SubscriptionUpgradeScreenState
    extends ConsumerState<SubscriptionUpgradeScreen> {
  final TextEditingController _promoController = TextEditingController();
  bool _isApplying = false;
  String? _applyMessage;
  bool _isSuccess = false;

  void _applyPromoCode() async {
    final code = _promoController.text.trim();
    if (code.isEmpty) return;

    setState(() {
      _isApplying = true;
      _applyMessage = null;
    });

    try {
      final apiClient = ref.read(apiClientProvider);

      final response = await apiClient.post(
        '/saas/promo/apply',
        body: {'code': code.toUpperCase()},
      );

      setState(() {
        _isApplying = false;

        if (response.statusCode == 200 && response.data['success'] == true) {
          _isSuccess = true;
          _applyMessage =
              response.data['message'] ?? 'Subscription successfully upgraded!';
        } else {
          _isSuccess = false;
          _applyMessage = response.data['error'] ?? 'API rejected the code.';
        }
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _isApplying = false;
        _isSuccess = false;
        _applyMessage = 'Error connecting to the payment server.';
      });
    }
  }

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderLayout(
      child: PageTemplate(
        title: 'Subscription & Upgrades',
        subtitle: 'Manage your SaaS billing and promo codes.',
        kpiCards: [
          // Simulated Current Status
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: Theme.of(context).colorScheme.outlineVariant,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Tier",
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      color: Colors.grey.shade600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _isSuccess ? "Premium" : "Free",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ],
              ),
            ),
          ),
        ],
        bodySections: [
          Text(
            'Apply Promo Code',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _promoController,
                  decoration: const InputDecoration(
                    labelText: 'Enter Promo Code',
                    border: OutlineInputBorder(),
                  ),
                  onSubmitted: (_) => _applyPromoCode(),
                ),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: _isApplying ? null : _applyPromoCode,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
                child: _isApplying
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Apply'),
              ),
            ],
          ),
          if (_applyMessage != null) ...[
            const SizedBox(height: 16),
            Text(
              _applyMessage!,
              style: TextStyle(
                color: _isSuccess ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
