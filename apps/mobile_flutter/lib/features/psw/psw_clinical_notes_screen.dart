import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import 'package:primecare_ui/primecare_ui.dart';

class PswClinicalNotesScreen extends StatelessWidget {
  const PswClinicalNotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      
      body: DesktopPaneWrapper(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: PrimeCareColumn(
            children: [
              PrimeCareCard(
                
                child: TextField(
                  maxLines: 15,
                  style: TextStyle(fontSize: 18, color: PrimeCareColors.slate700, height: 1.5),
                  decoration: InputDecoration(
                    hintText: AppLocalizations.of(context)!.describePatientMoodPhysicalChangesOr,
                    hintStyle: TextStyle(color: PrimeCareColors.slate400),
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.all(24),
                  ),
                ),
              ),
              
              SizedBox(height: 24),
              
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
                  SizedBox(width: 16),
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
              
              SizedBox(height: 48),
              PrimeCareButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                     SnackBar(
                       content: PrimeCareText(AppLocalizations.of(context)!.progressNoteAppendedSecurely),
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
