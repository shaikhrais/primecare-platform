import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:primecare_ui/primecare_ui.dart';

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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Subscription & Upgrades',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: PrimeCareColors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Manage your SaaS billing and promo codes.',
              style: TextStyle(
                color: PrimeCareColors.white.withAlpha(178),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 32),

            // Current Status Card
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: PrimeCareColors.white.withAlpha(15),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: PrimeCareColors.white.withAlpha(30)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Current Tier",
                    style: TextStyle(
                      color: PrimeCareColors.white.withAlpha(150),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        _isSuccess ? "PREMIUM" : "FREE PLAN",
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              color: _isSuccess
                                  ? PrimeCareColors.skyBlue
                                  : PrimeCareColors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                      ),
                      if (_isSuccess) ...[
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.verified,
                          color: PrimeCareColors.skyBlue,
                          size: 20,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 48),

            Text(
              'Promo Code',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: PrimeCareColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _promoController,
                    style: const TextStyle(color: PrimeCareColors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: PrimeCareColors.white.withAlpha(10),
                      hintText: 'Enter code (e.g. LIFETIME50)',
                      hintStyle: TextStyle(
                        color: PrimeCareColors.white.withAlpha(100),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: PrimeCareColors.white.withAlpha(30),
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: PrimeCareColors.white.withAlpha(30),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: PrimeCareColors.skyBlue,
                        ),
                      ),
                    ),
                    onSubmitted: (_) => _applyPromoCode(),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _isApplying ? null : _applyPromoCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PrimeCareColors.skyBlue,
                    foregroundColor: PrimeCareColors.black,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 20,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isApplying
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              PrimeCareColors.black,
                            ),
                          ),
                        )
                      : const Text(
                          'Apply',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              ],
            ),
            if (_applyMessage != null) ...[
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      (_isSuccess
                              ? PrimeCareColors.skyBlue
                              : PrimeCareColors.rose)
                          .withAlpha(20),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color:
                        (_isSuccess
                                ? PrimeCareColors.skyBlue
                                : PrimeCareColors.rose)
                            .withAlpha(50),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      _isSuccess ? Icons.check_circle : Icons.error_outline,
                      color: _isSuccess
                          ? PrimeCareColors.skyBlue
                          : PrimeCareColors.rose,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _applyMessage!,
                        style: TextStyle(
                          color: _isSuccess
                              ? PrimeCareColors.skyBlue
                              : PrimeCareColors.rose,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
