import 'package:flutter/material.dart';

class DefaultNotImplementedHeaderSection extends StatelessWidget {
  const DefaultNotImplementedHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      key: const Key('default_not_implemented_header-section'),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Header Section', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          // TODO: Add element slots here from DB
        ],
      ),
    );
  }
}
