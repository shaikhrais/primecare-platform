import 'package:easy_localization/easy_localization.dart';
// Layer: 01_INFRASTRUCTURE
import 'package:flutter/material.dart';

class ClinicalInterventionFormGroup extends StatelessWidget {
  const ClinicalInterventionFormGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: 800),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Intervention Notes',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              maxLines: 4,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                hintText: 'clinical.notes_hint'.tr(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
