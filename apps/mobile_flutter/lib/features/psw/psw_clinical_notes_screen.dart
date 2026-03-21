import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class PswClinicalNotesScreen extends StatelessWidget {
  const PswClinicalNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      appBar: const PrimeCareAppBar(title: 'Clinical Progress Note'),
      body: DesktopPaneWrapper(
        child: PrimeCareScrollWrapper(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: PrimeCareColumn(
            children: [
              PrimeCareCard(
                
                child: const TextField(
                  maxLines: 15,
                  style: TextStyle(fontSize: 18, color: PrimeCareColors.slate700, height: 1.5),
                  decoration: InputDecoration(
                    hintText: 'Describe patient mood, physical changes, or any incidents occurring during this active shift...',
                    hintStyle: TextStyle(color: PrimeCareColors.slate400),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(24),
                  ),
                ),
              ),
              
              const PrimeCareSizedBox(height: 24),
              
              PrimeCareRow(
                children: [
                  PrimeCareExpanded(
                    child: PrimeCareButton(
                      onPressed: (){},
                      text: 'Add Image',
                      isPrimary: false,
                      icon: Icons.camera_alt,
                    ),
                  ),
                  const PrimeCareSizedBox(width: 16),
                  PrimeCareExpanded(
                    child: PrimeCareButton(
                      onPressed: (){},
                      text: 'Audio Memo',
                      isPrimary: false,
                      icon: Icons.mic,
                    ),
                  ),
                ],
              ),
              
              const PrimeCareSizedBox(height: 48),
              PrimeCareButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                       content: const PrimeCareText('Progress Note Appended Securely'),
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
