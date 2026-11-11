/*
PRIME:SCREEN=sso_redirect
PRIME:DESIGN=DESIGN_APPROVED
PRIME:HTML=HTML_RESPONSIVE_DONE
PRIME:COMP=COMP_REUSABLE
PRIME:LOGIC=LOGIC_WORKING
PRIME:API=API_CONNECTED
PRIME:DB=DB_NONE
PRIME:VALIDATION=VALIDATION_NONE
PRIME:QA=QA_NOT_STARTED
PRIME:FINAL=FINAL_NOT_READY
PRIME:PROGRESS=100
PRIME:BLOCKER=
PRIME:NEXT_ACTION=
*/
// Governance - Category: middleware | Purpose: Core implementation file for the Sso Redirect View platform logic.
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeAppBar;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeTextField;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeCircularProgressIndicator;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeScaffold;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeIcon, PrimeIconButton;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeElevatedButton, PrimeOutlinedButton;
import 'package:primecare_ui_foundation/primecare_ui_foundation.dart' show PrimeText;
import 'package:flutter_core/flutter_core.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SsoRedirectView extends GovernedConsumerStatefulWidget {
  final String redirectUrl;

  const SsoRedirectView({super.key, required this.redirectUrl});

  @override
  ConsumerState<SsoRedirectView> createState() => _SsoRedirectViewState();
}

class _SsoRedirectViewState extends GovernedConsumerState<SsoRedirectView> {
  @override
  String get screenDescription =>
      'The screen requires components for monitoring the SSO redirect process, collecting user feedback, and displaying performance metrics, along with necessary buttons and API endpoints.';

  @override
  List<String> get requiredComponents => const [
        'SSORedirectMonitor',
        'ErrorLogViewer',
        'UserFeedbackCollector',
        'PerformanceMetricsDisplay',
      ];

  @override
  List<String> get requiredFunctions => const [
        'monitorSSORedirect',
        'validateRedirectURL',
        'checkForErrors',
        'collectUserFeedback',
        'trackRedirectPerformance',
      ];

  late TextEditingController _urlController;
  bool _useSystemBrowser = false;
  String _selectedProvider = 'Google Auth';
  bool _redirecting = true;

  @override
  void initState() {
    super.initState();
    _urlController = TextEditingController(text: widget.redirectUrl);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_redirecting) {
        _launchSSO();
      }
    });
  }

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  Future<void> _launchSSO() async {
    try {
      await launchUrlString(
        _urlController.text,
        mode: _useSystemBrowser ? LaunchMode.externalApplication : LaunchMode.platformDefault,
        webOnlyWindowName: '_self',
      );
    } catch (e) {
      debugPrint('SSO launch error: $e');
    }
  }

  @override
  Widget buildScreen(BuildContext context) {
    return PrimeScaffold(
      appBar: PrimeAppBar(
        title: const PrimeText('Single Sign-On Portal'),
        leading: PrimeIconButton(
          icon: const PrimeIcon(Icons.arrow_back),
          onPressed: () {
            setState(() {
              _redirecting = false;
            });
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 450),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (_redirecting) ...[
                  const Center(child: PrimeCircularProgressIndicator()),
                  const SizedBox(height: 24),
                  const PrimeText(
                    'Redirecting to PrimeCare Auth Portal...',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  PrimeText(
                    'Auth Provider: $_selectedProvider',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 13),
                  ),
                  const SizedBox(height: 24),
                ],
                const Divider(),
                const SizedBox(height: 16),
                const PrimeText(
                  'SSO Connection Settings',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
                const SizedBox(height: 16),
                PrimeTextField(
                  controller: _urlController,
                  decoration: const InputDecoration(
                    labelText: 'Identity Provider URL',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (val) {
                    setState(() {});
                  },
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: ['Google Auth', 'Okta Identity', 'Azure AD'].map((prov) {
                    final isSel = _selectedProvider == prov;
                    return ChoiceChip(
                      label: PrimeText(prov),
                      selected: isSel,
                      onSelected: (selected) {
                        setState(() {
                          _selectedProvider = prov;
                        });
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 16),
                SwitchListTile(
                  title: const PrimeText('Use system web browser'),
                  subtitle: const PrimeText('Recommended for secure credential sharing'),
                  value: _useSystemBrowser,
                  onChanged: (val) {
                    setState(() {
                      _useSystemBrowser = val;
                    });
                  },
                ),
                const SizedBox(height: 24),
                PrimeElevatedButton.icon(
                  icon: const PrimeIcon(Icons.open_in_new),
                  label: const PrimeText('Launch Identity Provider Manual Redirect'),
                  onPressed: _launchSSO,
                  style: PrimeElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                ),
                const SizedBox(height: 12),
                PrimeOutlinedButton(
                  onPressed: () {
                    setState(() {
                      _redirecting = !_redirecting;
                    });
                  },
                  child: PrimeText(_redirecting ? 'Pause Auto-Redirect' : 'Resume Auto-Redirect'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
