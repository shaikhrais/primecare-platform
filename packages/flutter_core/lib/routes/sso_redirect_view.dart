import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SsoRedirectView extends StatefulWidget {
  final String redirectUrl;

  const SsoRedirectView({super.key, required this.redirectUrl});

  @override
  State<SsoRedirectView> createState() => _SsoRedirectViewState();
}

class _SsoRedirectViewState extends State<SsoRedirectView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _launchSSO();
    });
  }

  Future<void> _launchSSO() async {
    if (await canLaunchUrlString(widget.redirectUrl)) {
      await launchUrlString(
        widget.redirectUrl,
        mode: LaunchMode.externalApplication, // Forces system browser for shared cookie jar
        webOnlyWindowName: '_self', // Replaces the current tab on Web
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 24),
            Text(
              'Redirecting to PrimeCare Auth Portal...',
              style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
