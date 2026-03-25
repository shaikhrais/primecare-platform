import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../../core/colors.dart';
import 'package:primecare_ui/primecare_ui.dart';

class ScrumMasterUsersScreen extends StatelessWidget {
  const ScrumMasterUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      backgroundColor: PrimeCareColors.radarDark,

      body: ListView.builder(
        padding: EdgeInsets.all(20),
        itemCount: 15, // Dummy list
        itemBuilder: (context, index) {
          return PrimeCareCard(
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.all(16),

            child: PrimeCareRow(
              children: [
                PrimeCareIcon(
                  Icons.storage_rounded,
                  color: PrimeCareColors.purple,
                  size: 32,
                ),
                SizedBox(width: 16),
                PrimeCareExpanded(
                  child: PrimeCareColumn(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      PrimeCareText(
                        'TENANT_ID_${index + 1000}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'monospace',
                        ),
                      ),
                      SizedBox(height: 4),
                      PrimeCareText(
                        'Active Users: ${(index * 42) + 12}',
                        style: TextStyle(
                          color: PrimeCareColors.slate400,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: PrimeCareIcon(
                    Icons.admin_panel_settings_rounded,
                    color: PrimeCareColors.emerald,
                  ),
                  onPressed: () {},
                  tooltip: AppLocalizations.of(context)!.impersonateTenant,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
