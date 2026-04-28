import 'package:flutter/material.dart';

enum BannerType { info, warning, error, success }

class PrimeCareBanner extends StatelessWidget {
  final BannerType type;
  final String? title;
  final String message;
  final VoidCallback? onDismiss;

  const PrimeCareBanner({
    Key? key,
    required this.type,
    this.title,
    required this.message,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
