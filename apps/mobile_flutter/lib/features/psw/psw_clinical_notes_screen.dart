import 'package:flutter/material.dart';
import '../../core/widgets/primecare_app_bar.dart';
import '../shared/layouts/desktop_pane_wrapper.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswClinicalNotesScreen extends StatelessWidget {
  const PswClinicalNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimeCareAppBar(title: 'Clinical Progress Note'),
      body: DesktopPaneWrapper(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: const [BoxShadow(color: Color(0x05000000), blurRadius: 16, offset: Offset(0, 4))],
                ),
                child: const TextField(
                  maxLines: 15,
                  style: TextStyle(fontSize: 18, color: Color(0xFF334155), height: 1.5),
                  decoration: InputDecoration(
                    hintText: 'Describe patient mood, physical changes, or any incidents occurring during this active shift...',
                    hintStyle: TextStyle(color: Color(0xFF94A3B8)),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(24),
                  ),
                ),
              ),
              
              const SizedBox(height: 24),
              
              Row(
                children: [
                  Expanded(
                    child: PrimeCareButton(
                      onPressed: (){},
                      text: 'Add Image',
                      isPrimary: false,
                      icon: Icons.camera_alt,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: PrimeCareButton(
                      onPressed: (){},
                      text: 'Audio Memo',
                      isPrimary: false,
                      icon: Icons.mic,
                    ),
                  ),
                ],
              ),
              
              const SizedBox(height: 48),
              PrimeCareButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                       content: const Text('Progress Note Appended Securely'),
                       backgroundColor: Theme.of(context).colorScheme.primary,
                       behavior: SnackBarBehavior.floating,
                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                     )
                  );
                },
                text: 'SAVE CLINICAL NOTE',
                isPrimary: true,
              )
            ],
          ),
        ),
      ),
    );
  }
}
