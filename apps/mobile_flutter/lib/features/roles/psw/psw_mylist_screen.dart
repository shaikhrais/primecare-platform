import 'package:flutter/material.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswMyListScreen extends StatelessWidget {
  const PswMyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F4F8),
      appBar: PrimeCareAppBar(title: 'My List'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            PrimeCareSectionHeader(title: 'To-Do Tasks', isWhite: true),
            PrimeCareCardContainer(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  ListTile(leading: Icon(Icons.check), title: Text('Medication Reminder - Due Today', style: TextStyle(color: Colors.red))),
                  ListTile(leading: Icon(Icons.check), title: Text('Complete Visit Notes')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
